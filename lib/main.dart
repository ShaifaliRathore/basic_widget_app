import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: false,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;

  String _selectedValue = 'Shaifali';
  final List<String> _dropdownList = [
    'Shaifali',
    'Akriti',
    'Diksha',
    'Krishna',
    'Nitin',
    'Anjali'
  ];

  final List<String> _dismissibleList = [
    'Flutter',
    'Dart',
    'React',
    'Javascript',
    'Laravel',
    'Php',
    'Python'
  ];

  TimeOfDay? _timeOfDay = TimeOfDay.now();
  DateTime? _dateTime = DateTime.now();

  int _currentStep = 0;

  List<Step> stepList() => [
        Step(
          isActive: _currentStep >= 0,
          state: _currentStep <= 0 ? StepState.editing : StepState.complete,
          title: const Text('Account'),
          subtitle: const Text('Enter email and password'),
          content: const Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text('Email'),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text('Password'),
                ),
              )
            ],
          ),
        ),
        Step(
          isActive: _currentStep >= 1,
          state: _currentStep <= 1 ? StepState.editing : StepState.complete,
          title: const Text('Address'),
          subtitle: const Text('Enter address and pincode'),
          content: const Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text('Address'),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text('Pincode'),
                ),
              )
            ],
          ),
        ),
        Step(
          isActive: _currentStep >= 2,
          state: StepState.complete,
          title: const Text('Confirm'),
          subtitle: const Text('Account verification confirmation'),
          content: const Column(
            children: [
              Text(
                'Account verification is done',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20.0,
              )
            ],
          ),
        ),
      ];

  File? _selectedImage;

  @override
  void initState() {
    super.initState();
  }

  final List<Widget> _pages = [
    Center(
      child: Container(
        height: 300,
        width: 300,
        decoration: BoxDecoration(
          image: const DecorationImage(
            image: NetworkImage(
              'https://gratisography.com/wp-content/uploads/2024/03/gratisography-funflower-800x525.jpg',
            ),
            fit: BoxFit.cover,
          ),
          border: Border.all(color: Colors.black, width: 3.0),
          shape: BoxShape.circle,
        ),
      ),
    ),
    Center(
      child: Container(
        height: 300,
        width: 300,
        decoration: BoxDecoration(
          image: const DecorationImage(
            image: AssetImage(
              'assets/images/profile.png',
            ),
          ),
          border: Border.all(color: Colors.blue, width: 3.0),
          borderRadius: const BorderRadius.all(Radius.circular(20.0)),
        ),
      ),
    ),
    Padding(
      padding: const EdgeInsets.all(20.0),
      child: Center(
        child: FadeInImage.assetNetwork(
          placeholder: 'assets/images/profile.png',
          image:
              'https://media.gcflearnfree.org/ctassets/topics/246/share_flower_fullsize.jpg',
        ),
      ),
    ),
    Padding(
      padding: const EdgeInsets.all(20.0),
      child: Center(
        child: Image.network(
          'https://gratisography.com/wp-content/uploads/2024/01/gratisography-cyber-kitty-800x525.jpg',
        ),
      ),
    ),
    const Center(
      child: Text('Hello Shaifali Rathore'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        drawer: Drawer(
          child: ListView(
            children: [
              _buildHeader(),
              _buildListTile(
                icon: Icons.home,
                title: 'Home',
                onTap: () => Navigator.pop(context),
              ),
              _buildListTile(
                icon: Icons.person,
                title: 'Profile',
                onTap: () => Navigator.pop(context),
              ),
              _buildListTile(
                icon: Icons.search,
                title: 'Search',
                onTap: () => Navigator.pop(context),
              ),
              _buildListTile(
                icon: Icons.notifications,
                title: 'Notification',
                onTap: () => Navigator.pop(context),
              ),
              _buildListTile(
                icon: Icons.settings,
                title: 'Settings',
                onTap: () => Navigator.pop(context),
              ),
              _buildListTile(
                icon: Icons.arrow_downward_rounded,
                title: 'Open Bottom Sheet',
                onTap: () => _displayBottomSheet(context),
              ),
              _buildListTile(
                icon: Icons.comment,
                title: 'Open Aimated Diialog',
                onTap: () => _oepnAnimatedDialog(context),
              ),
              _buildListTile(
                icon: Icons.watch,
                title:
                    '${_timeOfDay?.hour.toString().padLeft(2, '0')}:${_timeOfDay?.minute.toString().padLeft(2, '0')} ${_timeOfDay?.period.name.toUpperCase()}',
                onTap: () => _showTimePicker(),
              ),
              _buildListTile(
                icon: Icons.calendar_month,
                title: _dateTime.toString().split(' ')[0],
                onTap: () => _showDatePicker(),
              ),
              _buildListTile(
                icon: Icons.logout,
                title: 'Logout',
                onTap: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          backgroundColor: Colors.orange,
          type: BottomNavigationBarType.fixed,
          onTap: (index) => setState(() {
            _selectedIndex = index;
          }),
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                _selectedIndex == 0
                    ? 'assets/vector/home-bold.svg'
                    : 'assets/vector/home-outline.svg',
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                _selectedIndex == 1
                    ? 'assets/vector/search-bold.svg'
                    : 'assets/vector/search-outline.svg',
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                _selectedIndex == 2
                    ? 'assets/vector/add-square-bold.svg'
                    : 'assets/vector/add-square-outline.svg',
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                _selectedIndex == 3
                    ? 'assets/vector/video-play-bold.svg'
                    : 'assets/vector/video-play-outline.svg',
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Container(
                height: 25,
                width: 25,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/profile.png'),
                  ),
                  shape: BoxShape.circle,
                ),
              ),
              label: '',
            ),
          ],
        ),
        appBar: AppBar(
          backgroundColor: Colors.orange,
          title: Text(
            widget.title,
          ),
          bottom: const TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Row(
                children: [
                  Tab(
                    icon: Icon(
                      Icons.directions_boat,
                    ),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  Text(
                    'Boat',
                  )
                ],
              ),
              Row(
                children: [
                  Tab(
                    icon: Icon(
                      Icons.directions_train,
                    ),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  Text(
                    'Train',
                  )
                ],
              ),
              Row(
                children: [
                  Tab(
                    icon: Icon(
                      Icons.directions_car,
                    ),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  Text(
                    'Car',
                  )
                ],
              ),
              Row(
                children: [
                  Tab(
                    icon: Icon(
                      Icons.directions_bike,
                    ),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  Text(
                    'Bike',
                  )
                ],
              ),
              Row(
                children: [
                  Tab(
                    icon: Icon(
                      Icons.directions_walk,
                    ),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  Text(
                    'Walk',
                  )
                ],
              ),
              Row(
                children: [
                  Tab(
                    icon: Icon(
                      Icons.directions_off,
                    ),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  Text(
                    'Off',
                  )
                ],
              ),
            ],
            isScrollable: true,
          ),
        ),
        body: _selectedIndex == 0
            ? ListView.builder(
                itemCount: _dismissibleList.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    onDismissed: (direction) {
                      setState(() {
                        _dismissibleList.removeAt(index);
                      });
                    },
                    confirmDismiss: (direction) async {
                      if (direction == DismissDirection.startToEnd) {
                        return await showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Delete'),
                              content: const Text(
                                  'Are you sure you want to delete this item?'),
                              actions: [
                                ElevatedButton(
                                  onPressed: () =>
                                      Navigator.of(context).pop(true),
                                  child: const Text('Delete'),
                                ),
                                TextButton(
                                  onPressed: () =>
                                      Navigator.of(context).pop(false),
                                  child: const Text('Cancel'),
                                )
                              ],
                            );
                          },
                        );
                      } else {
                        return await showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Save'),
                              content: const Text(
                                  'Are you sure you want to save this item?'),
                              actions: [
                                ElevatedButton(
                                  onPressed: () =>
                                      Navigator.of(context).pop(true),
                                  child: const Text('Save'),
                                ),
                                TextButton(
                                  onPressed: () =>
                                      Navigator.of(context).pop(false),
                                  child: const Text('Cancel'),
                                )
                              ],
                            );
                          },
                        );
                      }
                    },
                    background: Container(
                      height: 40.0,
                      margin: const EdgeInsets.only(top: 10.0),
                      color: Colors.red,
                      child: const Padding(
                        padding: EdgeInsets.only(left: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Delete',
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Icon(
                              Icons.delete_outline,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                    secondaryBackground: Container(
                      height: 40.0,
                      margin: const EdgeInsets.only(top: 10.0),
                      color: Colors.green,
                      child: const Padding(
                        padding: EdgeInsets.only(right: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'Save',
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Icon(
                              Icons.save_alt_outlined,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                    key: ValueKey<String>(_dismissibleList[index]),
                    child: Container(
                      height: 40.0,
                      margin: const EdgeInsets.only(top: 10.0),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                      ),
                      child: Center(
                        child: Text(
                          _dismissibleList[index],
                        ),
                      ),
                    ),
                  );
                },
              )
            : _selectedIndex == 1
                ? Center(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                ),
                                onPressed: () => _pickImageFromGallery(),
                                child: const Text('Pick image from gallery'),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                ),
                                onPressed: () => _pickImageFromCamera(),
                                child: const Text('Pick image from camera'),
                              ),
                            ],
                          ),
                        ),
                        _selectedImage != null
                            ? Expanded(child: Image.file(_selectedImage!))
                            : const Text('Please select an image')
                      ],
                    ),
                  )
                : _selectedIndex == 2
                    ? Stepper(
                        steps: stepList(),
                        // type: StepperType.horizontal,
                        currentStep: _currentStep,
                        elevation: 0.0,
                        onStepContinue: () {
                          if (_currentStep < (stepList().length - 1)) {
                            setState(() {
                              _currentStep += 1;
                            });
                          }
                        },
                        onStepCancel: () {
                          if (_currentStep > 0) {
                            setState(() {
                              _currentStep -= 1;
                            });
                          }
                        },
                      )
                    : _selectedIndex == 3
                        ? Center(
                            child: Container(
                              height: 40,
                              width: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Colors.orange,
                              ),
                              child: Center(
                                child: DropdownButton(
                                  items: _dropdownList.map((String val) {
                                    return DropdownMenuItem(
                                      value: val,
                                      child: Text(val),
                                    );
                                  }).toList(),
                                  onChanged: (String? newVal) {
                                    setState(() {
                                      _selectedValue = newVal!;
                                    });
                                  },
                                  value: _selectedValue,
                                  icon: const Icon(
                                      Icons.keyboard_arrow_down_outlined),
                                  iconSize: 20.0,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                  dropdownColor: Colors.orange[200],
                                  underline: const SizedBox.shrink(),
                                ),
                              ),
                            ),
                          )
                        : _selectedIndex == 4
                            ? const TabBarView(
                                children: [
                                  Center(
                                    child: Text('Boat'),
                                  ),
                                  Center(
                                    child: Text('Train'),
                                  ),
                                  Center(
                                    child: Text('Car'),
                                  ),
                                  Center(
                                    child: Text('Bike'),
                                  ),
                                  Center(
                                    child: Text('Walk'),
                                  ),
                                  Center(
                                    child: Text('Off'),
                                  ),
                                ],
                              )
                            : _pages[_selectedIndex],
      ),
    );
  }

  _buildHeader() {
    return DrawerHeader(
      decoration: const BoxDecoration(
        color: Colors.orange,
      ),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50.0),
              border: Border.all(color: Colors.black, width: 2.0),
            ),
            child: const CircleAvatar(
              backgroundImage: NetworkImage(
                'https://gratisography.com/wp-content/uploads/2024/03/gratisography-funflower-800x525.jpg',
              ),
              radius: 40.0,
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          const Text(
            "Flutter Guys",
            style: TextStyle(fontSize: 16.0),
          )
        ],
      ),
    );
  }

  _buildListTile({
    required IconData icon,
    required String title,
    required GestureTapCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon),
      minLeadingWidth: 5.0,
      title: Text(
        title,
        style: const TextStyle(color: Colors.black54),
      ),
      onTap: onTap,
    );
  }

  _displayBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      isDismissible: false,
      context: context,
      builder: (context) {
        return SizedBox(
          height: 200,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Bottom Sheet Examaple",
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.black,
                  ),
                ),
                InkWell(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.close),
                )
              ],
            ),
          ),
        );
      },
      backgroundColor: Colors.orange[200],
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
    );
  }

  _oepnAnimatedDialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      pageBuilder: (context, animation1, animation2) {
        return Container();
      },
      transitionDuration: const Duration(milliseconds: 300),
      transitionBuilder: (context, animation1, animation2, widget) {
        return ScaleTransition(
          scale: Tween<double>(begin: 0.5, end: 1.0).animate(animation1),
          child: FadeTransition(
            opacity: Tween<double>(begin: 0.5, end: 1.0).animate(animation1),
            child: AlertDialog(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Hello'),
                  Tooltip(
                    message: 'Close Dialog',
                    child: InkWell(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.close),
                    ),
                  ),
                ],
              ),
              content: const Text('I\'m practicing flutter basics widgets'),
              shape: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide.none,
              ),
              backgroundColor: Colors.orange[200],
            ),
          ),
        );
      },
    );
  }

  Future<void> _showTimePicker() async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: _timeOfDay!,
    );
    if (pickedTime != null) {
      setState(() {
        _timeOfDay = pickedTime;
      });
    }
  }

  Future<void> _showDatePicker() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _dateTime,
      firstDate: DateTime(1997),
      lastDate: DateTime(2025),
    );
    if (pickedDate != null) {
      setState(() {
        _dateTime = pickedDate;
      });
    }
  }

  Future _pickImageFromGallery() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage == null) return;
    setState(() {
      _selectedImage = File(pickedImage.path);
    });
  }

  _pickImageFromCamera() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedImage == null) return;
    setState(() {
      _selectedImage = File(pickedImage.path);
    });
  }
}
