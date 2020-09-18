Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87CD726F739
	for <lists+linux-tip-commits@lfdr.de>; Fri, 18 Sep 2020 09:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbgIRHmp (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 18 Sep 2020 03:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbgIRHmh (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 18 Sep 2020 03:42:37 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2FF5C06178A;
        Fri, 18 Sep 2020 00:42:36 -0700 (PDT)
Date:   Fri, 18 Sep 2020 07:42:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600414953;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Jja6+qKWU9od5nLu9pPv+9cUX3fTZa3XmGuyu42DSBs=;
        b=lLsHxK4q5L3C3ziyI04aXTVksr1/+HlM+XvUwKkIswXfjoY7rt3W8rhyQynnc+7QcmSPum
        rPhTxfY7XJBogiT8bSQZ1DghEGsaWd3zmM15OyaDRW8Tj/yE4meYuM70LseMnEUSPZe1nt
        UPRwiaghXDUTci0gppWCbmts+0807qO85AysSgaCFUfg9T4kxRn36C7eM1I8dcdQNZXub/
        wN+LhyzRVCFxNiEdC0lJZcF8Bd0HAHUXY8BNMq0C47YTDfkIFp3sqehb8ymL/CV53vHtAq
        ScPZVJ40SqJVb7z+jwRh4Q/cwn8gFTsJLmGs/bfpmt6Y7ndnP9NkIYPsfReXqw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600414953;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Jja6+qKWU9od5nLu9pPv+9cUX3fTZa3XmGuyu42DSBs=;
        b=h1W03CxTtTDliGtGKADjgDfgXDh7vGnA78oTqFeeBwvwkEEuUmJOyEhoh8QssWY9+8acST
        U1Y6DRlYQTUCReDw==
From:   "tip-bot2 for Ashok Raj" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/pasid] Documentation/x86: Add documentation for SVA (Shared
 Virtual Addressing)
Cc:     Ashok Raj <ashok.raj@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Borislav Petkov <bp@suse.de>, Tony Luck <tony.luck@intel.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1600187413-163670-4-git-send-email-fenghua.yu@intel.com>
References: <1600187413-163670-4-git-send-email-fenghua.yu@intel.com>
MIME-Version: 1.0
Message-ID: <160041495313.15536.2567791842546152891.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/pasid branch of tip:

Commit-ID:     4e7b11567d946ebe14a3d10b697b078971a9da89
Gitweb:        https://git.kernel.org/tip/4e7b11567d946ebe14a3d10b697b078971a9da89
Author:        Ashok Raj <ashok.raj@intel.com>
AuthorDate:    Tue, 15 Sep 2020 09:30:07 -07:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 17 Sep 2020 19:29:42 +02:00

Documentation/x86: Add documentation for SVA (Shared Virtual Addressing)

ENQCMD and Data Streaming Accelerator (DSA) and all of their associated
features are a complicated stack with lots of interconnected pieces.
This documentation provides a big picture overview for all of the
features.

Signed-off-by: Ashok Raj <ashok.raj@intel.com>
Co-developed-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Link: https://lkml.kernel.org/r/1600187413-163670-4-git-send-email-fenghua.yu@intel.com
---
 Documentation/x86/index.rst |   1 +-
 Documentation/x86/sva.rst   | 257 +++++++++++++++++++++++++++++++++++-
 2 files changed, 258 insertions(+)
 create mode 100644 Documentation/x86/sva.rst

diff --git a/Documentation/x86/index.rst b/Documentation/x86/index.rst
index 265d9e9..e5d5ff0 100644
--- a/Documentation/x86/index.rst
+++ b/Documentation/x86/index.rst
@@ -30,3 +30,4 @@ x86-specific Documentation
    usb-legacy-support
    i386/index
    x86_64/index
+   sva
diff --git a/Documentation/x86/sva.rst b/Documentation/x86/sva.rst
new file mode 100644
index 0000000..076efd5
--- /dev/null
+++ b/Documentation/x86/sva.rst
@@ -0,0 +1,257 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===========================================
+Shared Virtual Addressing (SVA) with ENQCMD
+===========================================
+
+Background
+==========
+
+Shared Virtual Addressing (SVA) allows the processor and device to use the
+same virtual addresses avoiding the need for software to translate virtual
+addresses to physical addresses. SVA is what PCIe calls Shared Virtual
+Memory (SVM).
+
+In addition to the convenience of using application virtual addresses
+by the device, it also doesn't require pinning pages for DMA.
+PCIe Address Translation Services (ATS) along with Page Request Interface
+(PRI) allow devices to function much the same way as the CPU handling
+application page-faults. For more information please refer to the PCIe
+specification Chapter 10: ATS Specification.
+
+Use of SVA requires IOMMU support in the platform. IOMMU is also
+required to support the PCIe features ATS and PRI. ATS allows devices
+to cache translations for virtual addresses. The IOMMU driver uses the
+mmu_notifier() support to keep the device TLB cache and the CPU cache in
+sync. When an ATS lookup fails for a virtual address, the device should
+use the PRI in order to request the virtual address to be paged into the
+CPU page tables. The device must use ATS again in order the fetch the
+translation before use.
+
+Shared Hardware Workqueues
+==========================
+
+Unlike Single Root I/O Virtualization (SR-IOV), Scalable IOV (SIOV) permits
+the use of Shared Work Queues (SWQ) by both applications and Virtual
+Machines (VM's). This allows better hardware utilization vs. hard
+partitioning resources that could result in under utilization. In order to
+allow the hardware to distinguish the context for which work is being
+executed in the hardware by SWQ interface, SIOV uses Process Address Space
+ID (PASID), which is a 20-bit number defined by the PCIe SIG.
+
+PASID value is encoded in all transactions from the device. This allows the
+IOMMU to track I/O on a per-PASID granularity in addition to using the PCIe
+Resource Identifier (RID) which is the Bus/Device/Function.
+
+
+ENQCMD
+======
+
+ENQCMD is a new instruction on Intel platforms that atomically submits a
+work descriptor to a device. The descriptor includes the operation to be
+performed, virtual addresses of all parameters, virtual address of a completion
+record, and the PASID (process address space ID) of the current process.
+
+ENQCMD works with non-posted semantics and carries a status back if the
+command was accepted by hardware. This allows the submitter to know if the
+submission needs to be retried or other device specific mechanisms to
+implement fairness or ensure forward progress should be provided.
+
+ENQCMD is the glue that ensures applications can directly submit commands
+to the hardware and also permits hardware to be aware of application context
+to perform I/O operations via use of PASID.
+
+Process Address Space Tagging
+=============================
+
+A new thread-scoped MSR (IA32_PASID) provides the connection between
+user processes and the rest of the hardware. When an application first
+accesses an SVA-capable device, this MSR is initialized with a newly
+allocated PASID. The driver for the device calls an IOMMU-specific API
+that sets up the routing for DMA and page-requests.
+
+For example, the Intel Data Streaming Accelerator (DSA) uses
+iommu_sva_bind_device(), which will do the following:
+
+- Allocate the PASID, and program the process page-table (%cr3 register) in the
+  PASID context entries.
+- Register for mmu_notifier() to track any page-table invalidations to keep
+  the device TLB in sync. For example, when a page-table entry is invalidated,
+  the IOMMU propagates the invalidation to the device TLB. This will force any
+  future access by the device to this virtual address to participate in
+  ATS. If the IOMMU responds with proper response that a page is not
+  present, the device would request the page to be paged in via the PCIe PRI
+  protocol before performing I/O.
+
+This MSR is managed with the XSAVE feature set as "supervisor state" to
+ensure the MSR is updated during context switch.
+
+PASID Management
+================
+
+The kernel must allocate a PASID on behalf of each process which will use
+ENQCMD and program it into the new MSR to communicate the process identity to
+platform hardware.  ENQCMD uses the PASID stored in this MSR to tag requests
+from this process.  When a user submits a work descriptor to a device using the
+ENQCMD instruction, the PASID field in the descriptor is auto-filled with the
+value from MSR_IA32_PASID. Requests for DMA from the device are also tagged
+with the same PASID. The platform IOMMU uses the PASID in the transaction to
+perform address translation. The IOMMU APIs setup the corresponding PASID
+entry in IOMMU with the process address used by the CPU (e.g. %cr3 register in
+x86).
+
+The MSR must be configured on each logical CPU before any application
+thread can interact with a device. Threads that belong to the same
+process share the same page tables, thus the same MSR value.
+
+PASID is cleared when a process is created. The PASID allocation and MSR
+programming may occur long after a process and its threads have been created.
+One thread must call iommu_sva_bind_device() to allocate the PASID for the
+process. If a thread uses ENQCMD without the MSR first being populated, a #GP
+will be raised. The kernel will update the PASID MSR with the PASID for all
+threads in the process. A single process PASID can be used simultaneously
+with multiple devices since they all share the same address space.
+
+One thread can call iommu_sva_unbind_device() to free the allocated PASID.
+The kernel will clear the PASID MSR for all threads belonging to the process.
+
+New threads inherit the MSR value from the parent.
+
+Relationships
+=============
+
+ * Each process has many threads, but only one PASID.
+ * Devices have a limited number (~10's to 1000's) of hardware workqueues.
+   The device driver manages allocating hardware workqueues.
+ * A single mmap() maps a single hardware workqueue as a "portal" and
+   each portal maps down to a single workqueue.
+ * For each device with which a process interacts, there must be
+   one or more mmap()'d portals.
+ * Many threads within a process can share a single portal to access
+   a single device.
+ * Multiple processes can separately mmap() the same portal, in
+   which case they still share one device hardware workqueue.
+ * The single process-wide PASID is used by all threads to interact
+   with all devices.  There is not, for instance, a PASID for each
+   thread or each thread<->device pair.
+
+FAQ
+===
+
+* What is SVA/SVM?
+
+Shared Virtual Addressing (SVA) permits I/O hardware and the processor to
+work in the same address space, i.e., to share it. Some call it Shared
+Virtual Memory (SVM), but Linux community wanted to avoid confusing it with
+POSIX Shared Memory and Secure Virtual Machines which were terms already in
+circulation.
+
+* What is a PASID?
+
+A Process Address Space ID (PASID) is a PCIe-defined Transaction Layer Packet
+(TLP) prefix. A PASID is a 20-bit number allocated and managed by the OS.
+PASID is included in all transactions between the platform and the device.
+
+* How are shared workqueues different?
+
+Traditionally, in order for userspace applications to interact with hardware,
+there is a separate hardware instance required per process. For example,
+consider doorbells as a mechanism of informing hardware about work to process.
+Each doorbell is required to be spaced 4k (or page-size) apart for process
+isolation. This requires hardware to provision that space and reserve it in
+MMIO. This doesn't scale as the number of threads becomes quite large. The
+hardware also manages the queue depth for Shared Work Queues (SWQ), and
+consumers don't need to track queue depth. If there is no space to accept
+a command, the device will return an error indicating retry.
+
+A user should check Deferrable Memory Write (DMWr) capability on the device
+and only submits ENQCMD when the device supports it. In the new DMWr PCIe
+terminology, devices need to support DMWr completer capability. In addition,
+it requires all switch ports to support DMWr routing and must be enabled by
+the PCIe subsystem, much like how PCIe atomic operations are managed for
+instance.
+
+SWQ allows hardware to provision just a single address in the device. When
+used with ENQCMD to submit work, the device can distinguish the process
+submitting the work since it will include the PASID assigned to that
+process. This helps the device scale to a large number of processes.
+
+* Is this the same as a user space device driver?
+
+Communicating with the device via the shared workqueue is much simpler
+than a full blown user space driver. The kernel driver does all the
+initialization of the hardware. User space only needs to worry about
+submitting work and processing completions.
+
+* Is this the same as SR-IOV?
+
+Single Root I/O Virtualization (SR-IOV) focuses on providing independent
+hardware interfaces for virtualizing hardware. Hence, it's required to be
+almost fully functional interface to software supporting the traditional
+BARs, space for interrupts via MSI-X, its own register layout.
+Virtual Functions (VFs) are assisted by the Physical Function (PF)
+driver.
+
+Scalable I/O Virtualization builds on the PASID concept to create device
+instances for virtualization. SIOV requires host software to assist in
+creating virtual devices; each virtual device is represented by a PASID
+along with the bus/device/function of the device.  This allows device
+hardware to optimize device resource creation and can grow dynamically on
+demand. SR-IOV creation and management is very static in nature. Consult
+references below for more details.
+
+* Why not just create a virtual function for each app?
+
+Creating PCIe SR-IOV type Virtual Functions (VF) is expensive. VFs require
+duplicated hardware for PCI config space and interrupts such as MSI-X.
+Resources such as interrupts have to be hard partitioned between VFs at
+creation time, and cannot scale dynamically on demand. The VFs are not
+completely independent from the Physical Function (PF). Most VFs require
+some communication and assistance from the PF driver. SIOV, in contrast,
+creates a software-defined device where all the configuration and control
+aspects are mediated via the slow path. The work submission and completion
+happen without any mediation.
+
+* Does this support virtualization?
+
+ENQCMD can be used from within a guest VM. In these cases, the VMM helps
+with setting up a translation table to translate from Guest PASID to Host
+PASID. Please consult the ENQCMD instruction set reference for more
+details.
+
+* Does memory need to be pinned?
+
+When devices support SVA along with platform hardware such as IOMMU
+supporting such devices, there is no need to pin memory for DMA purposes.
+Devices that support SVA also support other PCIe features that remove the
+pinning requirement for memory.
+
+Device TLB support - Device requests the IOMMU to lookup an address before
+use via Address Translation Service (ATS) requests.  If the mapping exists
+but there is no page allocated by the OS, IOMMU hardware returns that no
+mapping exists.
+
+Device requests the virtual address to be mapped via Page Request
+Interface (PRI). Once the OS has successfully completed the mapping, it
+returns the response back to the device. The device requests again for
+a translation and continues.
+
+IOMMU works with the OS in managing consistency of page-tables with the
+device. When removing pages, it interacts with the device to remove any
+device TLB entry that might have been cached before removing the mappings from
+the OS.
+
+References
+==========
+
+VT-D:
+https://01.org/blogs/ashokraj/2018/recent-enhancements-intel-virtualization-technology-directed-i/o-intel-vt-d
+
+SIOV:
+https://01.org/blogs/2019/assignable-interfaces-intel-scalable-i/o-virtualization-linux
+
+ENQCMD in ISE:
+https://software.intel.com/sites/default/files/managed/c5/15/architecture-instruction-set-extensions-programming-reference.pdf
+
+DSA spec:
+https://software.intel.com/sites/default/files/341204-intel-data-streaming-accelerator-spec.pdf
