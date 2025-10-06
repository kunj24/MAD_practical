import 'package:flutter/material.dart';
import '../models/education.dart';
import '../models/experience.dart';
import '../widgets/section_card.dart';
import '../widgets/field_widgets.dart';

class ResumeHomePage extends StatefulWidget {
  const ResumeHomePage({super.key});

  @override
  State<ResumeHomePage> createState() => _ResumeHomePageState();
}

class _ResumeHomePageState extends State<ResumeHomePage> {
  // Contact controllers
  final nameController = TextEditingController(text: 'Your Name');
  final titleController = TextEditingController(text: 'Software Engineer');
  final emailController = TextEditingController(text: 'you@example.com');
  final phoneController = TextEditingController(text: '+91 98765 43210');
  final locationController = TextEditingController(text: 'City, Country');

  // Summary, Skills, Projects
  final summaryController = TextEditingController(
    text:
        'Results-driven software engineer with experience in mobile and web apps.',
  );
  final skillsController = TextEditingController(text: 'Dart, Flutter, Python');
  final projectsController = TextEditingController(
    text: 'Project A — Mobile app; Project B — Backend',
  );

  // Dynamic lists
  late List<EducationEntry> education;
  late List<ExperienceEntry> experience;

  // UI state
  int selectedTabIndex = 0;

  @override
  void initState() {
    super.initState();
    education = [
      EducationEntry(institute: 'University', degree: 'B.Tech', year: '2024'),
    ];
    experience = [
      ExperienceEntry(
        company: 'Acme Corp',
        role: 'Intern',
        duration: 'Jun-Aug 2023',
      ),
    ];
  }

  void addEducation() => setState(() => education.add(EducationEntry()));
  void removeEducation(int i) => setState(() => education.removeAt(i));
  void addExperience() => setState(() => experience.add(ExperienceEntry()));
  void removeExperience(int i) => setState(() => experience.removeAt(i));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Icon(Icons.description_outlined, color: Colors.white),
            const SizedBox(width: 8),
            const Text('Resume Maker'),
            const Spacer(),
            ElevatedButton.icon(
              onPressed: () => setState(() => selectedTabIndex = 1),
              icon: const Icon(Icons.visibility_outlined),
              label: const Text('Preview'),
            ),
          ],
        ),
        centerTitle: false,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth > 900;
          return Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                ToggleButtons(
                  isSelected: [selectedTabIndex == 0, selectedTabIndex == 1],
                  onPressed: (i) => setState(() => selectedTabIndex = i),
                  children: const [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Text('Edit'),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Text('Preview'),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: selectedTabIndex == 0
                      ? (isWide ? buildEditorWide() : buildEditor())
                      : (isWide ? buildPreviewWide() : buildPreview()),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget buildEditorWide() {
    return Row(
      children: [
        Expanded(flex: 2, child: buildEditor()),
        const SizedBox(width: 12),
        Expanded(flex: 1, child: buildPreviewCard()),
      ],
    );
  }

  Widget buildPreviewWide() {
    return Row(
      children: [
        Expanded(flex: 1, child: buildEditor()),
        const SizedBox(width: 12),
        Expanded(flex: 1, child: buildPreviewCard()),
      ],
    );
  }

  Widget buildPreviewCard() {
    return Card(
      color: const Color(0xFF0F0F0F),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(padding: const EdgeInsets.all(12), child: buildPreview()),
    );
  }

  Widget buildEditor() {
    return ListView(
      padding: const EdgeInsets.all(12),
      children: [
        SectionCard(
          title: 'Contact',
          child: Column(
            children: [
              buildTextField(nameController, 'Full Name', icon: Icons.person),
              buildTextField(titleController, 'Title'),
              buildTextField(emailController, 'Email'),
              buildTextField(phoneController, 'Phone'),
              buildTextField(locationController, 'Location'),
            ],
          ),
        ),
        SectionCard(
          title: 'Summary',
          child: buildMultilineField(summaryController, 'Brief summary'),
        ),
        SectionCard(
          title: 'Education',
          action: TextButton.icon(
            onPressed: addEducation,
            icon: const Icon(Icons.add),
            label: const Text('Add'),
          ),
          child: Column(
            children: [
              for (int i = 0; i < education.length; i++) buildEducationTile(i),
            ],
          ),
        ),
        SectionCard(
          title: 'Experience',
          action: TextButton.icon(
            onPressed: addExperience,
            icon: const Icon(Icons.add),
            label: const Text('Add'),
          ),
          child: Column(
            children: [
              for (int i = 0; i < experience.length; i++)
                buildExperienceTile(i),
            ],
          ),
        ),
        SectionCard(
          title: 'Skills & Projects',
          child: Column(
            children: [
              buildTextField(skillsController, 'Skills (comma separated)'),
              buildMultilineField(projectsController, 'Projects'),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildEducationTile(int i) {
    final e = education[i];
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Row(
              children: [
                Text('Entry ${i + 1}'),
                const Spacer(),
                IconButton(
                  onPressed: () => removeEducation(i),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            smallTextField(
              initial: e.institute,
              placeholder: 'Institute',
              onChanged: (v) => setState(() => e.institute = v),
            ),
            smallTextField(
              initial: e.degree,
              placeholder: 'Degree',
              onChanged: (v) => setState(() => e.degree = v),
            ),
            smallTextField(
              initial: e.year,
              placeholder: 'Year',
              onChanged: (v) => setState(() => e.year = v),
            ),
            smallTextField(
              initial: e.details,
              placeholder: 'Details',
              onChanged: (v) => setState(() => e.details = v),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildExperienceTile(int i) {
    final ex = experience[i];
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Row(
              children: [
                Text('Entry ${i + 1}'),
                const Spacer(),
                IconButton(
                  onPressed: () => removeExperience(i),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            smallTextField(
              initial: ex.company,
              placeholder: 'Company',
              onChanged: (v) => setState(() => ex.company = v),
            ),
            smallTextField(
              initial: ex.role,
              placeholder: 'Role',
              onChanged: (v) => setState(() => ex.role = v),
            ),
            smallTextField(
              initial: ex.duration,
              placeholder: 'Duration',
              onChanged: (v) => setState(() => ex.duration = v),
            ),
            smallTextField(
              initial: ex.details,
              placeholder: 'Details',
              onChanged: (v) => setState(() => ex.details = v),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPreview() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            nameController.text,
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          Text(titleController.text, style: const TextStyle(fontSize: 18)),
          const SizedBox(height: 10),
          Text('Summary: ${summaryController.text}'),
          const SizedBox(height: 10),
          Text('Education:'),
          ...education.map(
            (e) => Text('${e.degree}, ${e.institute} (${e.year})'),
          ),
          const SizedBox(height: 10),
          Text('Experience:'),
          ...experience.map(
            (ex) => Text('${ex.role} at ${ex.company} (${ex.duration})'),
          ),
          const SizedBox(height: 10),
          Text('Skills: ${skillsController.text}'),
          Text('Projects: ${projectsController.text}'),
        ],
      ),
    );
  }
}
