Return-Path: <linux-tip-commits+bounces-6030-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E751AFC7D5
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Jul 2025 12:06:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB6281BC4762
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Jul 2025 10:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB44271442;
	Tue,  8 Jul 2025 10:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cXIWC2dg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OaTNGRIM"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BAFE26E70C;
	Tue,  8 Jul 2025 10:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751969048; cv=none; b=svVzGaDreTTy1e5JHmKtNQwxIDS/PO5/DCmHs0ajHkRtsEs7DKOC2i4rLduU8Y6MpNR/kTwRNAIKd+x6FIfwY06ZUXLIc44uPl8nIaGSlv85xc8VzWp5tE9O53rXftsIrNMW3vvHfbwLxHf3zYfHvSMoTd9NbM1pAtBFSCY9Crw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751969048; c=relaxed/simple;
	bh=ICPfog77fYQKfrD5Z30JUC3B2u4kXLq2sRIrmo5EXuE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=nGLv0CwF+Wng+I94JdXYj26WzGWjwZ+9chsuSdjd8/q9Yi9TbnXzwO4tj4++T879SZ5gxXxfmsHgK4Zq/UZ9oTGYDUB04q5buXL+xHbAUkaGmqGxj9gFOEafggC59M8SVFI2nm9rxDsw5OR4LL/AqQcqYO1wE1nBv9aL5KAknO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cXIWC2dg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OaTNGRIM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 08 Jul 2025 10:04:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751969043;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r5HEHgyfmytqXnlS0LfRBQjnmLgyUlWFIZ4NGKt/9Ys=;
	b=cXIWC2dgK1zchXH4HNNbejKT6bBJZv2otujuEzcPBkwTrYAEtnbse6glHB2QsfqvLEyV4S
	S4ZX/7vUuzGcvGY1Jpbywi/+33iMYXr6lp7vlSo8tQM7P/HyFLeMQxjQnux7PU0XAvgC7s
	KtFUHsjlXZfumk8M53B3kcUHC+ZdllXEwKXtgaOBkU7gLIpIZs+3v1sZlO5fWEFb9GsPVo
	DpSqAfh2flAktxAlsCSlrb6OBwRywna499XKOaadXUMb7b9nHj61/1EnWlc0GBGVxzK+v7
	B3cMDYTSwQjc4dIyv8h92tLJiWSARMFQrCmsKCFkm2cKiuhR0te3rhG3gqN9rA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751969043;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r5HEHgyfmytqXnlS0LfRBQjnmLgyUlWFIZ4NGKt/9Ys=;
	b=OaTNGRIMYE43NVgvLveQm3DUVBmCKakWzI6K1lSG/O2k/qG+d/wtXEVgc1mXRWynaCW7gM
	LgGMr2Rmf/mcFZDg==
From: "tip-bot2 for Perry Yuan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/platform] Documentation/x86: Add AMD Hardware Feedback
 Interface documentation
Cc: Perry Yuan <Perry.Yuan@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Bagas Sanjaya <bagasdotme@gmail.com>,
 ilpo.jarvinen@linux.intel.com, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250609200518.3616080-2-superm1@kernel.org>
References: <20250609200518.3616080-2-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175196904241.406.4928209037972159653.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/platform branch of tip:

Commit-ID:     11390345ba0c101a7bd904139d154d6328773379
Gitweb:        https://git.kernel.org/tip/11390345ba0c101a7bd904139d154d63287=
73379
Author:        Perry Yuan <Perry.Yuan@amd.com>
AuthorDate:    Mon, 09 Jun 2025 15:05:06 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 07 Jul 2025 19:22:02 +02:00

Documentation/x86: Add AMD Hardware Feedback Interface documentation

Introduce a new documentation file, `amd_hfi.rst`, which delves into the
implementation details of the AMD Hardware Feedback Interface and its
associated driver, `amd_hfi`. This documentation describes how the driver
provides hint to the OS scheduling which depends on the capability of core
performance and efficiency ranking data.

This documentation describes:

  * The design of the driver
  * How the driver provides hints to the OS scheduling
  * How the driver interfaces with the kernel for efficiency ranking data.

Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Acked-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
Link: https://lore.kernel.org/20250609200518.3616080-2-superm1@kernel.org
---
 Documentation/arch/x86/amd-hfi.rst | 133 ++++++++++++++++++++++++++++-
 Documentation/arch/x86/index.rst   |   1 +-
 2 files changed, 134 insertions(+)
 create mode 100644 Documentation/arch/x86/amd-hfi.rst

diff --git a/Documentation/arch/x86/amd-hfi.rst b/Documentation/arch/x86/amd-=
hfi.rst
new file mode 100644
index 0000000..bf3d3a1
--- /dev/null
+++ b/Documentation/arch/x86/amd-hfi.rst
@@ -0,0 +1,133 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Hardware Feedback Interface For Hetero Core Scheduling On AMD Platform
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+:Copyright: 2025 Advanced Micro Devices, Inc. All Rights Reserved.
+
+:Author: Perry Yuan <perry.yuan@amd.com>
+:Author: Mario Limonciello <mario.limonciello@amd.com>
+
+Overview
+--------
+
+AMD Heterogeneous Core implementations are comprised of more than one
+architectural class and CPUs are comprised of cores of various efficiency and
+power capabilities: performance-oriented *classic cores* and power-efficient
+*dense cores*. As such, power management strategies must be designed to
+accommodate the complexities introduced by incorporating different core type=
s.
+Heterogeneous systems can also extend to more than two architectural classes
+as well. The purpose of the scheduling feedback mechanism is to provide
+information to the operating system scheduler in real time such that the
+scheduler can direct threads to the optimal core.
+
+The goal of AMD's heterogeneous architecture is to attain power benefit by
+sending background threads to the dense cores while sending high priority
+threads to the classic cores. From a performance perspective, sending
+background threads to dense cores can free up power headroom and allow the
+classic cores to optimally service demanding threads. Furthermore, the area
+optimized nature of the dense cores allows for an increasing number of
+physical cores. This improved core density will have positive multithreaded
+performance impact.
+
+AMD Heterogeneous Core Driver
+-----------------------------
+
+The ``amd_hfi`` driver delivers the operating system a performance and energy
+efficiency capability data for each CPU in the system. The scheduler can use
+the ranking data from the HFI driver to make task placement decisions.
+
+Thread Classification and Ranking Table Interaction
+----------------------------------------------------
+
+The thread classification is used to select into a ranking table that
+describes an efficiency and performance ranking for each classification.
+
+Threads are classified during runtime into enumerated classes. The classes
+represent thread performance/power characteristics that may benefit from
+special scheduling behaviors. The below table depicts an example of thread
+classification and a preference where a given thread should be scheduled
+based on its thread class. The real time thread classification is consumed
+by the operating system and is used to inform the scheduler of where the
+thread should be placed.
+
+Thread Classification Example Table
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
++----------+----------------+-------------------------------+---------------=
------+---------+
+| class ID | Classification | Preferred scheduling behavior | Preemption pri=
ority | Counter |
++----------+----------------+-------------------------------+---------------=
------+---------+
+| 0        | Default        | Performant                    | Highest       =
      |         |
++----------+----------------+-------------------------------+---------------=
------+---------+
+| 1        | Non-scalable   | Efficient                     | Lowest        =
      | PMCx1A1 |
++----------+----------------+-------------------------------+---------------=
------+---------+
+| 2        | I/O bound      | Efficient                     | Lowest        =
      | PMCx044 |
++----------+----------------+-------------------------------+---------------=
------+---------+
+
+Thread classification is performed by the hardware each time that the thread=
 is switched out.
+Threads that don't meet any hardware specified criteria are classified as "d=
efault".
+
+AMD Hardware Feedback Interface
+--------------------------------
+
+The Hardware Feedback Interface provides to the operating system information
+about the performance and energy efficiency of each CPU in the system. Each
+capability is given as a unit-less quantity in the range [0-255]. A higher
+performance value indicates higher performance capability, and a higher
+efficiency value indicates more efficiency. Energy efficiency and performance
+are reported in separate capabilities in the shared memory based ranking tab=
le.
+
+These capabilities may change at runtime as a result of changes in the
+operating conditions of the system or the action of external factors.
+Power Management firmware is responsible for detecting events that require
+a reordering of the performance and efficiency ranking. Table updates happen
+relatively infrequently and occur on the time scale of seconds or more.
+
+The following events trigger a table update:
+    * Thermal Stress Events
+    * Silent Compute
+    * Extreme Low Battery Scenarios
+
+The kernel or a userspace policy daemon can use these capabilities to modify
+task placement decisions. For instance, if either the performance or energy
+capabilities of a given logical processor becomes zero, it is an indication
+that the hardware recommends to the operating system to not schedule any tas=
ks
+on that processor for performance or energy efficiency reasons, respectively.
+
+Implementation details for Linux
+--------------------------------
+
+The implementation of threads scheduling consists of the following steps:
+
+1. A thread is spawned and scheduled to the ideal core using the default
+   heterogeneous scheduling policy.
+2. The processor profiles thread execution and assigns an enumerated
+   classification ID.
+   This classification is communicated to the OS via logical processor
+   scope MSR.
+3. During the thread context switch out the operating system consumes the
+   workload (WL) classification which resides in a logical processor scope M=
SR.
+4. The OS triggers the hardware to clear its history by writing to an MSR,
+   after consuming the WL classification and before switching in the new thr=
ead.
+5. If due to the classification, ranking table, and processor availability,
+   the thread is not on its ideal processor, the OS will then consider
+   scheduling the thread on its ideal processor (if available).
+
+Ranking Table
+-------------
+The ranking table is a shared memory region that is used to communicate the
+performance and energy efficiency capabilities of each CPU in the system.
+
+The ranking table design includes rankings for each APIC ID in the system and
+rankings both for performance and efficiency for each workload classificatio=
n.
+
+.. kernel-doc:: drivers/platform/x86/amd/hfi/hfi.c
+   :doc: amd_shmem_info
+
+Ranking Table update
+---------------------------
+The power management firmware issues an platform interrupt after updating the
+ranking table and is ready for the operating system to consume it. CPUs rece=
ive
+such interrupt and read new ranking table from shared memory which PCCT table
+has provided, then ``amd_hfi`` driver parses the new table to provide new
+consume data for scheduling decisions.
diff --git a/Documentation/arch/x86/index.rst b/Documentation/arch/x86/index.=
rst
index 8ea7624..f88bcfc 100644
--- a/Documentation/arch/x86/index.rst
+++ b/Documentation/arch/x86/index.rst
@@ -28,6 +28,7 @@ x86-specific Documentation
    amd-debugging
    amd-memory-encryption
    amd_hsmp
+   amd-hfi
    tdx
    pti
    mds

