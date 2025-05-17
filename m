Return-Path: <linux-tip-commits+bounces-5660-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6ADEABA973
	for <lists+linux-tip-commits@lfdr.de>; Sat, 17 May 2025 12:07:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6ABA0A03F91
	for <lists+linux-tip-commits@lfdr.de>; Sat, 17 May 2025 10:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABDAC213E63;
	Sat, 17 May 2025 10:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="A+lGJ1Pd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Qs/mn7Pw"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F115B1DEFDC;
	Sat, 17 May 2025 10:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747476193; cv=none; b=S27zCjOJdarHgxiNKRl6ICF5rp4cMmf2IO+fpbcEcuonMxuriBKGGv2I27dfrDU6wINufwCHMSSEo4uMpbBfUh6/+F0EB1PBgPPPhuUtAg58zVJ12kPmCc/8DapXJfOeceXGQtP4rYbCQIHAR1PSWGFNWH3erDVaxiPJKKouYZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747476193; c=relaxed/simple;
	bh=7s+1kQImTYV4jg3PsRmKbHk6oGCZkJNOGb8fwUMQ5IY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=dByU4EaVFMxCPMQnM07OOdDQL7Q48u6zn+xBF6oUwwvxqTLJmPmulHXVKl3VMhPE7jCCsWCpLFTOcv59p+3adZPQIe8NDLszbJqgQNzIGmBWAs+35vmeDa/uz+Z4/+IgXepppADjS7pYLASLuYaA8s/Q2lARZFLeESaES42hQGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=A+lGJ1Pd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Qs/mn7Pw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 17 May 2025 10:02:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747476169;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zw+86TWVYjq3SmVUJfoIDXzryRzhnqGTNvUM2Cf7p7Q=;
	b=A+lGJ1PdvEva8+gwlfct9JEUzlXPAVRvXD+z7pVncGH7McS0xU44nxSEgq9LLRl6sjsdSr
	02lNi2VyFnF+uPlOMln4TaRN8H4AfErWxyUGk/SpOEKXJKQZ3VnSqAc+C9mhbeXRkgqRkn
	YzG1muh/lHBfK/jsZwCY4zE8ymtNHnoKbrG6sSGLtMWI/zAaZzzulNQEJQ2nJIFUX/wMMn
	B+QQteDHKDMqm5sElj9rMnVDIvI9fdujgoQX1JNn2W2SBzApZd5NZZ3dO7Tp7NTQtMA4ut
	2z43VgjuLnjJo3b4ev0QNxMLZSvLR706i4LKstjHNbJXFsWSYnGQYpnu7DA8+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747476169;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zw+86TWVYjq3SmVUJfoIDXzryRzhnqGTNvUM2Cf7p7Q=;
	b=Qs/mn7Pwae48Mxp5o7pzIJPS7afipGcz4bWZykJvbDFHuuOruQdcR7wPD+/6ys0A331j/p
	hgFJMGJELA6eE6Bg==
From: "tip-bot2 for James Morse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86,fs/resctrl: Move the resctrl filesystem code to
 live in /fs/resctrl
Cc: James Morse <james.morse@arm.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Reinette Chatre <reinette.chatre@intel.com>, Fenghua Yu <fenghuay@nvidia.com>,
 Tony Luck <tony.luck@intel.com>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250515165855.31452-25-james.morse@arm.com>
References: <20250515165855.31452-25-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174747616799.406.8189583184895348016.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     7168ae330e8105296210b2b2d31d791d5c073345
Gitweb:        https://git.kernel.org/tip/7168ae330e8105296210b2b2d31d791d5c0=
73345
Author:        James Morse <james.morse@arm.com>
AuthorDate:    Thu, 15 May 2025 16:58:54=20
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 16 May 2025 14:36:09 +02:00

x86,fs/resctrl: Move the resctrl filesystem code to live in /fs/resctrl

Resctrl is a filesystem interface to hardware that provides cache
allocation policy and bandwidth control for groups of tasks or CPUs.

To support more than one architecture, resctrl needs to live in /fs/.

Move the code that is concerned with the filesystem interface to
/fs/resctrl.

Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>
Tested-by: Fenghua Yu <fenghuay@nvidia.com>
Tested-by: Tony Luck <tony.luck@intel.com>
Link: https://lore.kernel.org/20250515165855.31452-25-james.morse@arm.com
---
 Documentation/arch/x86/index.rst                |    1 +-
 Documentation/arch/x86/resctrl.rst              | 1523 +-----
 Documentation/filesystems/index.rst             |    1 +-
 Documentation/filesystems/resctrl.rst           | 1523 +++++-
 MAINTAINERS                                     |    2 +-
 arch/x86/kernel/cpu/resctrl/Makefile            |    1 +-
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c       |  641 +--
 arch/x86/kernel/cpu/resctrl/internal.h          |  371 +-
 arch/x86/kernel/cpu/resctrl/monitor.c           |  909 +---
 arch/x86/kernel/cpu/resctrl/monitor_trace.h     |   31 +-
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c       | 1087 +---
 arch/x86/kernel/cpu/resctrl/pseudo_lock_trace.h |    2 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c          | 4597 +--------------
 fs/resctrl/Kconfig                              |    2 +-
 fs/resctrl/ctrlmondata.c                        |  661 ++-
 fs/resctrl/internal.h                           |  426 +-
 fs/resctrl/monitor.c                            |  929 +++-
 fs/resctrl/monitor_trace.h                      |   33 +-
 fs/resctrl/pseudo_lock.c                        | 1105 +++-
 fs/resctrl/pseudo_lock_trace.h                  |    0
 fs/resctrl/rdtgroup.c                           | 4353 +++++++++++++-
 21 files changed, 9186 insertions(+), 9012 deletions(-)
 delete mode 100644 Documentation/arch/x86/resctrl.rst
 create mode 100644 Documentation/filesystems/resctrl.rst
 delete mode 100644 arch/x86/kernel/cpu/resctrl/monitor_trace.h
 delete mode 100644 fs/resctrl/pseudo_lock_trace.h

diff --git a/Documentation/arch/x86/index.rst b/Documentation/arch/x86/index.=
rst
index 8ac64d7..00f9a99 100644
--- a/Documentation/arch/x86/index.rst
+++ b/Documentation/arch/x86/index.rst
@@ -31,7 +31,6 @@ x86-specific Documentation
    pti
    mds
    microcode
-   resctrl
    tsx_async_abort
    buslock
    usb-legacy-support
diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resc=
trl.rst
deleted file mode 100644
index c7949dd..0000000
--- a/Documentation/arch/x86/resctrl.rst
+++ /dev/null
@@ -1,1523 +0,0 @@
-.. SPDX-License-Identifier: GPL-2.0
-.. include:: <isonum.txt>
-
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
-User Interface for Resource Control feature (resctrl)
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
-
-:Copyright: |copy| 2016 Intel Corporation
-:Authors: - Fenghua Yu <fenghua.yu@intel.com>
-          - Tony Luck <tony.luck@intel.com>
-          - Vikas Shivappa <vikas.shivappa@intel.com>
-
-
-Intel refers to this feature as Intel Resource Director Technology(Intel(R) =
RDT).
-AMD refers to this feature as AMD Platform Quality of Service(AMD QoS).
-
-This feature is enabled by the CONFIG_X86_CPU_RESCTRL and the x86 /proc/cpui=
nfo
-flag bits:
-
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
-RDT (Resource Director Technology) Allocation	"rdt_a"
-CAT (Cache Allocation Technology)		"cat_l3", "cat_l2"
-CDP (Code and Data Prioritization)		"cdp_l3", "cdp_l2"
-CQM (Cache QoS Monitoring)			"cqm_llc", "cqm_occup_llc"
-MBM (Memory Bandwidth Monitoring)		"cqm_mbm_total", "cqm_mbm_local"
-MBA (Memory Bandwidth Allocation)		"mba"
-SMBA (Slow Memory Bandwidth Allocation)         ""
-BMEC (Bandwidth Monitoring Event Configuration) ""
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
-
-Historically, new features were made visible by default in /proc/cpuinfo. Th=
is
-resulted in the feature flags becoming hard to parse by humans. Adding a new
-flag to /proc/cpuinfo should be avoided if user space can obtain information
-about the feature from resctrl's info directory.
-
-To use the feature mount the file system::
-
- # mount -t resctrl resctrl [-o cdp[,cdpl2][,mba_MBps][,debug]] /sys/fs/resc=
trl
-
-mount options are:
-
-"cdp":
-	Enable code/data prioritization in L3 cache allocations.
-"cdpl2":
-	Enable code/data prioritization in L2 cache allocations.
-"mba_MBps":
-	Enable the MBA Software Controller(mba_sc) to specify MBA
-	bandwidth in MiBps
-"debug":
-	Make debug files accessible. Available debug files are annotated with
-	"Available only with debug option".
-
-L2 and L3 CDP are controlled separately.
-
-RDT features are orthogonal. A particular system may support only
-monitoring, only control, or both monitoring and control.  Cache
-pseudo-locking is a unique way of using cache control to "pin" or
-"lock" data in the cache. Details can be found in
-"Cache Pseudo-Locking".
-
-
-The mount succeeds if either of allocation or monitoring is present, but
-only those files and directories supported by the system will be created.
-For more details on the behavior of the interface during monitoring
-and allocation, see the "Resource alloc and monitor groups" section.
-
-Info directory
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-
-The 'info' directory contains information about the enabled
-resources. Each resource has its own subdirectory. The subdirectory
-names reflect the resource names.
-
-Each subdirectory contains the following files with respect to
-allocation:
-
-Cache resource(L3/L2)  subdirectory contains the following files
-related to allocation:
-
-"num_closids":
-		The number of CLOSIDs which are valid for this
-		resource. The kernel uses the smallest number of
-		CLOSIDs of all enabled resources as limit.
-"cbm_mask":
-		The bitmask which is valid for this resource.
-		This mask is equivalent to 100%.
-"min_cbm_bits":
-		The minimum number of consecutive bits which
-		must be set when writing a mask.
-
-"shareable_bits":
-		Bitmask of shareable resource with other executing
-		entities (e.g. I/O). User can use this when
-		setting up exclusive cache partitions. Note that
-		some platforms support devices that have their
-		own settings for cache use which can over-ride
-		these bits.
-"bit_usage":
-		Annotated capacity bitmasks showing how all
-		instances of the resource are used. The legend is:
-
-			"0":
-			      Corresponding region is unused. When the system's
-			      resources have been allocated and a "0" is found
-			      in "bit_usage" it is a sign that resources are
-			      wasted.
-
-			"H":
-			      Corresponding region is used by hardware only
-			      but available for software use. If a resource
-			      has bits set in "shareable_bits" but not all
-			      of these bits appear in the resource groups'
-			      schematas then the bits appearing in
-			      "shareable_bits" but no resource group will
-			      be marked as "H".
-			"X":
-			      Corresponding region is available for sharing and
-			      used by hardware and software. These are the
-			      bits that appear in "shareable_bits" as
-			      well as a resource group's allocation.
-			"S":
-			      Corresponding region is used by software
-			      and available for sharing.
-			"E":
-			      Corresponding region is used exclusively by
-			      one resource group. No sharing allowed.
-			"P":
-			      Corresponding region is pseudo-locked. No
-			      sharing allowed.
-"sparse_masks":
-		Indicates if non-contiguous 1s value in CBM is supported.
-
-			"0":
-			      Only contiguous 1s value in CBM is supported.
-			"1":
-			      Non-contiguous 1s value in CBM is supported.
-
-Memory bandwidth(MB) subdirectory contains the following files
-with respect to allocation:
-
-"min_bandwidth":
-		The minimum memory bandwidth percentage which
-		user can request.
-
-"bandwidth_gran":
-		The granularity in which the memory bandwidth
-		percentage is allocated. The allocated
-		b/w percentage is rounded off to the next
-		control step available on the hardware. The
-		available bandwidth control steps are:
-		min_bandwidth + N * bandwidth_gran.
-
-"delay_linear":
-		Indicates if the delay scale is linear or
-		non-linear. This field is purely informational
-		only.
-
-"thread_throttle_mode":
-		Indicator on Intel systems of how tasks running on threads
-		of a physical core are throttled in cases where they
-		request different memory bandwidth percentages:
-
-		"max":
-			the smallest percentage is applied
-			to all threads
-		"per-thread":
-			bandwidth percentages are directly applied to
-			the threads running on the core
-
-If RDT monitoring is available there will be an "L3_MON" directory
-with the following files:
-
-"num_rmids":
-		The number of RMIDs available. This is the
-		upper bound for how many "CTRL_MON" + "MON"
-		groups can be created.
-
-"mon_features":
-		Lists the monitoring events if
-		monitoring is enabled for the resource.
-		Example::
-
-			# cat /sys/fs/resctrl/info/L3_MON/mon_features
-			llc_occupancy
-			mbm_total_bytes
-			mbm_local_bytes
-
-		If the system supports Bandwidth Monitoring Event
-		Configuration (BMEC), then the bandwidth events will
-		be configurable. The output will be::
-
-			# cat /sys/fs/resctrl/info/L3_MON/mon_features
-			llc_occupancy
-			mbm_total_bytes
-			mbm_total_bytes_config
-			mbm_local_bytes
-			mbm_local_bytes_config
-
-"mbm_total_bytes_config", "mbm_local_bytes_config":
-	Read/write files containing the configuration for the mbm_total_bytes
-	and mbm_local_bytes events, respectively, when the Bandwidth
-	Monitoring Event Configuration (BMEC) feature is supported.
-	The event configuration settings are domain specific and affect
-	all the CPUs in the domain. When either event configuration is
-	changed, the bandwidth counters for all RMIDs of both events
-	(mbm_total_bytes as well as mbm_local_bytes) are cleared for that
-	domain. The next read for every RMID will report "Unavailable"
-	and subsequent reads will report the valid value.
-
-	Following are the types of events supported:
-
-	=3D=3D=3D=3D    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-	Bits    Description
-	=3D=3D=3D=3D    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-	6       Dirty Victims from the QOS domain to all types of memory
-	5       Reads to slow memory in the non-local NUMA domain
-	4       Reads to slow memory in the local NUMA domain
-	3       Non-temporal writes to non-local NUMA domain
-	2       Non-temporal writes to local NUMA domain
-	1       Reads to memory in the non-local NUMA domain
-	0       Reads to memory in the local NUMA domain
-	=3D=3D=3D=3D    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-
-	By default, the mbm_total_bytes configuration is set to 0x7f to count
-	all the event types and the mbm_local_bytes configuration is set to
-	0x15 to count all the local memory events.
-
-	Examples:
-
-	* To view the current configuration::
-	  ::
-
-	    # cat /sys/fs/resctrl/info/L3_MON/mbm_total_bytes_config
-	    0=3D0x7f;1=3D0x7f;2=3D0x7f;3=3D0x7f
-
-	    # cat /sys/fs/resctrl/info/L3_MON/mbm_local_bytes_config
-	    0=3D0x15;1=3D0x15;3=3D0x15;4=3D0x15
-
-	* To change the mbm_total_bytes to count only reads on domain 0,
-	  the bits 0, 1, 4 and 5 needs to be set, which is 110011b in binary
-	  (in hexadecimal 0x33):
-	  ::
-
-	    # echo  "0=3D0x33" > /sys/fs/resctrl/info/L3_MON/mbm_total_bytes_config
-
-	    # cat /sys/fs/resctrl/info/L3_MON/mbm_total_bytes_config
-	    0=3D0x33;1=3D0x7f;2=3D0x7f;3=3D0x7f
-
-	* To change the mbm_local_bytes to count all the slow memory reads on
-	  domain 0 and 1, the bits 4 and 5 needs to be set, which is 110000b
-	  in binary (in hexadecimal 0x30):
-	  ::
-
-	    # echo  "0=3D0x30;1=3D0x30" > /sys/fs/resctrl/info/L3_MON/mbm_local_byt=
es_config
-
-	    # cat /sys/fs/resctrl/info/L3_MON/mbm_local_bytes_config
-	    0=3D0x30;1=3D0x30;3=3D0x15;4=3D0x15
-
-"max_threshold_occupancy":
-		Read/write file provides the largest value (in
-		bytes) at which a previously used LLC_occupancy
-		counter can be considered for re-use.
-
-Finally, in the top level of the "info" directory there is a file
-named "last_cmd_status". This is reset with every "command" issued
-via the file system (making new directories or writing to any of the
-control files). If the command was successful, it will read as "ok".
-If the command failed, it will provide more information that can be
-conveyed in the error returns from file operations. E.g.
-::
-
-	# echo L3:0=3Df7 > schemata
-	bash: echo: write error: Invalid argument
-	# cat info/last_cmd_status
-	mask f7 has non-consecutive 1-bits
-
-Resource alloc and monitor groups
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
-
-Resource groups are represented as directories in the resctrl file
-system.  The default group is the root directory which, immediately
-after mounting, owns all the tasks and cpus in the system and can make
-full use of all resources.
-
-On a system with RDT control features additional directories can be
-created in the root directory that specify different amounts of each
-resource (see "schemata" below). The root and these additional top level
-directories are referred to as "CTRL_MON" groups below.
-
-On a system with RDT monitoring the root directory and other top level
-directories contain a directory named "mon_groups" in which additional
-directories can be created to monitor subsets of tasks in the CTRL_MON
-group that is their ancestor. These are called "MON" groups in the rest
-of this document.
-
-Removing a directory will move all tasks and cpus owned by the group it
-represents to the parent. Removing one of the created CTRL_MON groups
-will automatically remove all MON groups below it.
-
-Moving MON group directories to a new parent CTRL_MON group is supported
-for the purpose of changing the resource allocations of a MON group
-without impacting its monitoring data or assigned tasks. This operation
-is not allowed for MON groups which monitor CPUs. No other move
-operation is currently allowed other than simply renaming a CTRL_MON or
-MON group.
-
-All groups contain the following files:
-
-"tasks":
-	Reading this file shows the list of all tasks that belong to
-	this group. Writing a task id to the file will add a task to the
-	group. Multiple tasks can be added by separating the task ids
-	with commas. Tasks will be assigned sequentially. Multiple
-	failures are not supported. A single failure encountered while
-	attempting to assign a task will cause the operation to abort and
-	already added tasks before the failure will remain in the group.
-	Failures will be logged to /sys/fs/resctrl/info/last_cmd_status.
-
-	If the group is a CTRL_MON group the task is removed from
-	whichever previous CTRL_MON group owned the task and also from
-	any MON group that owned the task. If the group is a MON group,
-	then the task must already belong to the CTRL_MON parent of this
-	group. The task is removed from any previous MON group.
-
-
-"cpus":
-	Reading this file shows a bitmask of the logical CPUs owned by
-	this group. Writing a mask to this file will add and remove
-	CPUs to/from this group. As with the tasks file a hierarchy is
-	maintained where MON groups may only include CPUs owned by the
-	parent CTRL_MON group.
-	When the resource group is in pseudo-locked mode this file will
-	only be readable, reflecting the CPUs associated with the
-	pseudo-locked region.
-
-
-"cpus_list":
-	Just like "cpus", only using ranges of CPUs instead of bitmasks.
-
-
-When control is enabled all CTRL_MON groups will also contain:
-
-"schemata":
-	A list of all the resources available to this group.
-	Each resource has its own line and format - see below for details.
-
-"size":
-	Mirrors the display of the "schemata" file to display the size in
-	bytes of each allocation instead of the bits representing the
-	allocation.
-
-"mode":
-	The "mode" of the resource group dictates the sharing of its
-	allocations. A "shareable" resource group allows sharing of its
-	allocations while an "exclusive" resource group does not. A
-	cache pseudo-locked region is created by first writing
-	"pseudo-locksetup" to the "mode" file before writing the cache
-	pseudo-locked region's schemata to the resource group's "schemata"
-	file. On successful pseudo-locked region creation the mode will
-	automatically change to "pseudo-locked".
-
-"ctrl_hw_id":
-	Available only with debug option. The identifier used by hardware
-	for the control group. On x86 this is the CLOSID.
-
-When monitoring is enabled all MON groups will also contain:
-
-"mon_data":
-	This contains a set of files organized by L3 domain and by
-	RDT event. E.g. on a system with two L3 domains there will
-	be subdirectories "mon_L3_00" and "mon_L3_01".	Each of these
-	directories have one file per event (e.g. "llc_occupancy",
-	"mbm_total_bytes", and "mbm_local_bytes"). In a MON group these
-	files provide a read out of the current value of the event for
-	all tasks in the group. In CTRL_MON groups these files provide
-	the sum for all tasks in the CTRL_MON group and all tasks in
-	MON groups. Please see example section for more details on usage.
-	On systems with Sub-NUMA Cluster (SNC) enabled there are extra
-	directories for each node (located within the "mon_L3_XX" directory
-	for the L3 cache they occupy). These are named "mon_sub_L3_YY"
-	where "YY" is the node number.
-
-"mon_hw_id":
-	Available only with debug option. The identifier used by hardware
-	for the monitor group. On x86 this is the RMID.
-
-When the "mba_MBps" mount option is used all CTRL_MON groups will also conta=
in:
-
-"mba_MBps_event":
-	Reading this file shows which memory bandwidth event is used
-	as input to the software feedback loop that keeps memory bandwidth
-	below the value specified in the schemata file. Writing the
-	name of one of the supported memory bandwidth events found in
-	/sys/fs/resctrl/info/L3_MON/mon_features changes the input
-	event.
-
-Resource allocation rules
--------------------------
-
-When a task is running the following rules define which resources are
-available to it:
-
-1) If the task is a member of a non-default group, then the schemata
-   for that group is used.
-
-2) Else if the task belongs to the default group, but is running on a
-   CPU that is assigned to some specific group, then the schemata for the
-   CPU's group is used.
-
-3) Otherwise the schemata for the default group is used.
-
-Resource monitoring rules
--------------------------
-1) If a task is a member of a MON group, or non-default CTRL_MON group
-   then RDT events for the task will be reported in that group.
-
-2) If a task is a member of the default CTRL_MON group, but is running
-   on a CPU that is assigned to some specific group, then the RDT events
-   for the task will be reported in that group.
-
-3) Otherwise RDT events for the task will be reported in the root level
-   "mon_data" group.
-
-
-Notes on cache occupancy monitoring and control
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-When moving a task from one group to another you should remember that
-this only affects *new* cache allocations by the task. E.g. you may have
-a task in a monitor group showing 3 MB of cache occupancy. If you move
-to a new group and immediately check the occupancy of the old and new
-groups you will likely see that the old group is still showing 3 MB and
-the new group zero. When the task accesses locations still in cache from
-before the move, the h/w does not update any counters. On a busy system
-you will likely see the occupancy in the old group go down as cache lines
-are evicted and re-used while the occupancy in the new group rises as
-the task accesses memory and loads into the cache are counted based on
-membership in the new group.
-
-The same applies to cache allocation control. Moving a task to a group
-with a smaller cache partition will not evict any cache lines. The
-process may continue to use them from the old partition.
-
-Hardware uses CLOSid(Class of service ID) and an RMID(Resource monitoring ID)
-to identify a control group and a monitoring group respectively. Each of
-the resource groups are mapped to these IDs based on the kind of group. The
-number of CLOSid and RMID are limited by the hardware and hence the creation=
 of
-a "CTRL_MON" directory may fail if we run out of either CLOSID or RMID
-and creation of "MON" group may fail if we run out of RMIDs.
-
-max_threshold_occupancy - generic concepts
-------------------------------------------
-
-Note that an RMID once freed may not be immediately available for use as
-the RMID is still tagged the cache lines of the previous user of RMID.
-Hence such RMIDs are placed on limbo list and checked back if the cache
-occupancy has gone down. If there is a time when system has a lot of
-limbo RMIDs but which are not ready to be used, user may see an -EBUSY
-during mkdir.
-
-max_threshold_occupancy is a user configurable value to determine the
-occupancy at which an RMID can be freed.
-
-The mon_llc_occupancy_limbo tracepoint gives the precise occupancy in bytes
-for a subset of RMID that are not immediately available for allocation.
-This can't be relied on to produce output every second, it may be necessary
-to attempt to create an empty monitor group to force an update. Output may
-only be produced if creation of a control or monitor group fails.
-
-Schemata files - general concepts
----------------------------------
-Each line in the file describes one resource. The line starts with
-the name of the resource, followed by specific values to be applied
-in each of the instances of that resource on the system.
-
-Cache IDs
----------
-On current generation systems there is one L3 cache per socket and L2
-caches are generally just shared by the hyperthreads on a core, but this
-isn't an architectural requirement. We could have multiple separate L3
-caches on a socket, multiple cores could share an L2 cache. So instead
-of using "socket" or "core" to define the set of logical cpus sharing
-a resource we use a "Cache ID". At a given cache level this will be a
-unique number across the whole system (but it isn't guaranteed to be a
-contiguous sequence, there may be gaps).  To find the ID for each logical
-CPU look in /sys/devices/system/cpu/cpu*/cache/index*/id
-
-Cache Bit Masks (CBM)
----------------------
-For cache resources we describe the portion of the cache that is available
-for allocation using a bitmask. The maximum value of the mask is defined
-by each cpu model (and may be different for different cache levels). It
-is found using CPUID, but is also provided in the "info" directory of
-the resctrl file system in "info/{resource}/cbm_mask". Some Intel hardware
-requires that these masks have all the '1' bits in a contiguous block. So
-0x3, 0x6 and 0xC are legal 4-bit masks with two bits set, but 0x5, 0x9
-and 0xA are not. Check /sys/fs/resctrl/info/{resource}/sparse_masks
-if non-contiguous 1s value is supported. On a system with a 20-bit mask
-each bit represents 5% of the capacity of the cache. You could partition
-the cache into four equal parts with masks: 0x1f, 0x3e0, 0x7c00, 0xf8000.
-
-Notes on Sub-NUMA Cluster mode
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
-When SNC mode is enabled, Linux may load balance tasks between Sub-NUMA
-nodes much more readily than between regular NUMA nodes since the CPUs
-on Sub-NUMA nodes share the same L3 cache and the system may report
-the NUMA distance between Sub-NUMA nodes with a lower value than used
-for regular NUMA nodes.
-
-The top-level monitoring files in each "mon_L3_XX" directory provide
-the sum of data across all SNC nodes sharing an L3 cache instance.
-Users who bind tasks to the CPUs of a specific Sub-NUMA node can read
-the "llc_occupancy", "mbm_total_bytes", and "mbm_local_bytes" in the
-"mon_sub_L3_YY" directories to get node local data.
-
-Memory bandwidth allocation is still performed at the L3 cache
-level. I.e. throttling controls are applied to all SNC nodes.
-
-L3 cache allocation bitmaps also apply to all SNC nodes. But note that
-the amount of L3 cache represented by each bit is divided by the number
-of SNC nodes per L3 cache. E.g. with a 100MB cache on a system with 10-bit
-allocation masks each bit normally represents 10MB. With SNC mode enabled
-with two SNC nodes per L3 cache, each bit only represents 5MB.
-
-Memory bandwidth Allocation and monitoring
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-
-For Memory bandwidth resource, by default the user controls the resource
-by indicating the percentage of total memory bandwidth.
-
-The minimum bandwidth percentage value for each cpu model is predefined
-and can be looked up through "info/MB/min_bandwidth". The bandwidth
-granularity that is allocated is also dependent on the cpu model and can
-be looked up at "info/MB/bandwidth_gran". The available bandwidth
-control steps are: min_bw + N * bw_gran. Intermediate values are rounded
-to the next control step available on the hardware.
-
-The bandwidth throttling is a core specific mechanism on some of Intel
-SKUs. Using a high bandwidth and a low bandwidth setting on two threads
-sharing a core may result in both threads being throttled to use the
-low bandwidth (see "thread_throttle_mode").
-
-The fact that Memory bandwidth allocation(MBA) may be a core
-specific mechanism where as memory bandwidth monitoring(MBM) is done at
-the package level may lead to confusion when users try to apply control
-via the MBA and then monitor the bandwidth to see if the controls are
-effective. Below are such scenarios:
-
-1. User may *not* see increase in actual bandwidth when percentage
-   values are increased:
-
-This can occur when aggregate L2 external bandwidth is more than L3
-external bandwidth. Consider an SKL SKU with 24 cores on a package and
-where L2 external  is 10GBps (hence aggregate L2 external bandwidth is
-240GBps) and L3 external bandwidth is 100GBps. Now a workload with '20
-threads, having 50% bandwidth, each consuming 5GBps' consumes the max L3
-bandwidth of 100GBps although the percentage value specified is only 50%
-<< 100%. Hence increasing the bandwidth percentage will not yield any
-more bandwidth. This is because although the L2 external bandwidth still
-has capacity, the L3 external bandwidth is fully used. Also note that
-this would be dependent on number of cores the benchmark is run on.
-
-2. Same bandwidth percentage may mean different actual bandwidth
-   depending on # of threads:
-
-For the same SKU in #1, a 'single thread, with 10% bandwidth' and '4
-thread, with 10% bandwidth' can consume upto 10GBps and 40GBps although
-they have same percentage bandwidth of 10%. This is simply because as
-threads start using more cores in an rdtgroup, the actual bandwidth may
-increase or vary although user specified bandwidth percentage is same.
-
-In order to mitigate this and make the interface more user friendly,
-resctrl added support for specifying the bandwidth in MiBps as well.  The
-kernel underneath would use a software feedback mechanism or a "Software
-Controller(mba_sc)" which reads the actual bandwidth using MBM counters
-and adjust the memory bandwidth percentages to ensure::
-
-	"actual bandwidth < user specified bandwidth".
-
-By default, the schemata would take the bandwidth percentage values
-where as user can switch to the "MBA software controller" mode using
-a mount option 'mba_MBps'. The schemata format is specified in the below
-sections.
-
-L3 schemata file details (code and data prioritization disabled)
-----------------------------------------------------------------
-With CDP disabled the L3 schemata format is::
-
-	L3:<cache_id0>=3D<cbm>;<cache_id1>=3D<cbm>;...
-
-L3 schemata file details (CDP enabled via mount option to resctrl)
-------------------------------------------------------------------
-When CDP is enabled L3 control is split into two separate resources
-so you can specify independent masks for code and data like this::
-
-	L3DATA:<cache_id0>=3D<cbm>;<cache_id1>=3D<cbm>;...
-	L3CODE:<cache_id0>=3D<cbm>;<cache_id1>=3D<cbm>;...
-
-L2 schemata file details
-------------------------
-CDP is supported at L2 using the 'cdpl2' mount option. The schemata
-format is either::
-
-	L2:<cache_id0>=3D<cbm>;<cache_id1>=3D<cbm>;...
-
-or
-
-	L2DATA:<cache_id0>=3D<cbm>;<cache_id1>=3D<cbm>;...
-	L2CODE:<cache_id0>=3D<cbm>;<cache_id1>=3D<cbm>;...
-
-
-Memory bandwidth Allocation (default mode)
-------------------------------------------
-
-Memory b/w domain is L3 cache.
-::
-
-	MB:<cache_id0>=3Dbandwidth0;<cache_id1>=3Dbandwidth1;...
-
-Memory bandwidth Allocation specified in MiBps
-----------------------------------------------
-
-Memory bandwidth domain is L3 cache.
-::
-
-	MB:<cache_id0>=3Dbw_MiBps0;<cache_id1>=3Dbw_MiBps1;...
-
-Slow Memory Bandwidth Allocation (SMBA)
----------------------------------------
-AMD hardware supports Slow Memory Bandwidth Allocation (SMBA).
-CXL.memory is the only supported "slow" memory device. With the
-support of SMBA, the hardware enables bandwidth allocation on
-the slow memory devices. If there are multiple such devices in
-the system, the throttling logic groups all the slow sources
-together and applies the limit on them as a whole.
-
-The presence of SMBA (with CXL.memory) is independent of slow memory
-devices presence. If there are no such devices on the system, then
-configuring SMBA will have no impact on the performance of the system.
-
-The bandwidth domain for slow memory is L3 cache. Its schemata file
-is formatted as:
-::
-
-	SMBA:<cache_id0>=3Dbandwidth0;<cache_id1>=3Dbandwidth1;...
-
-Reading/writing the schemata file
----------------------------------
-Reading the schemata file will show the state of all resources
-on all domains. When writing you only need to specify those values
-which you wish to change.  E.g.
-::
-
-  # cat schemata
-  L3DATA:0=3Dfffff;1=3Dfffff;2=3Dfffff;3=3Dfffff
-  L3CODE:0=3Dfffff;1=3Dfffff;2=3Dfffff;3=3Dfffff
-  # echo "L3DATA:2=3D3c0;" > schemata
-  # cat schemata
-  L3DATA:0=3Dfffff;1=3Dfffff;2=3D3c0;3=3Dfffff
-  L3CODE:0=3Dfffff;1=3Dfffff;2=3Dfffff;3=3Dfffff
-
-Reading/writing the schemata file (on AMD systems)
---------------------------------------------------
-Reading the schemata file will show the current bandwidth limit on all
-domains. The allocated resources are in multiples of one eighth GB/s.
-When writing to the file, you need to specify what cache id you wish to
-configure the bandwidth limit.
-
-For example, to allocate 2GB/s limit on the first cache id:
-
-::
-
-  # cat schemata
-    MB:0=3D2048;1=3D2048;2=3D2048;3=3D2048
-    L3:0=3Dffff;1=3Dffff;2=3Dffff;3=3Dffff
-
-  # echo "MB:1=3D16" > schemata
-  # cat schemata
-    MB:0=3D2048;1=3D  16;2=3D2048;3=3D2048
-    L3:0=3Dffff;1=3Dffff;2=3Dffff;3=3Dffff
-
-Reading/writing the schemata file (on AMD systems) with SMBA feature
---------------------------------------------------------------------
-Reading and writing the schemata file is the same as without SMBA in
-above section.
-
-For example, to allocate 8GB/s limit on the first cache id:
-
-::
-
-  # cat schemata
-    SMBA:0=3D2048;1=3D2048;2=3D2048;3=3D2048
-      MB:0=3D2048;1=3D2048;2=3D2048;3=3D2048
-      L3:0=3Dffff;1=3Dffff;2=3Dffff;3=3Dffff
-
-  # echo "SMBA:1=3D64" > schemata
-  # cat schemata
-    SMBA:0=3D2048;1=3D  64;2=3D2048;3=3D2048
-      MB:0=3D2048;1=3D2048;2=3D2048;3=3D2048
-      L3:0=3Dffff;1=3Dffff;2=3Dffff;3=3Dffff
-
-Cache Pseudo-Locking
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-CAT enables a user to specify the amount of cache space that an
-application can fill. Cache pseudo-locking builds on the fact that a
-CPU can still read and write data pre-allocated outside its current
-allocated area on a cache hit. With cache pseudo-locking, data can be
-preloaded into a reserved portion of cache that no application can
-fill, and from that point on will only serve cache hits. The cache
-pseudo-locked memory is made accessible to user space where an
-application can map it into its virtual address space and thus have
-a region of memory with reduced average read latency.
-
-The creation of a cache pseudo-locked region is triggered by a request
-from the user to do so that is accompanied by a schemata of the region
-to be pseudo-locked. The cache pseudo-locked region is created as follows:
-
-- Create a CAT allocation CLOSNEW with a CBM matching the schemata
-  from the user of the cache region that will contain the pseudo-locked
-  memory. This region must not overlap with any current CAT allocation/CLOS
-  on the system and no future overlap with this cache region is allowed
-  while the pseudo-locked region exists.
-- Create a contiguous region of memory of the same size as the cache
-  region.
-- Flush the cache, disable hardware prefetchers, disable preemption.
-- Make CLOSNEW the active CLOS and touch the allocated memory to load
-  it into the cache.
-- Set the previous CLOS as active.
-- At this point the closid CLOSNEW can be released - the cache
-  pseudo-locked region is protected as long as its CBM does not appear in
-  any CAT allocation. Even though the cache pseudo-locked region will from
-  this point on not appear in any CBM of any CLOS an application running with
-  any CLOS will be able to access the memory in the pseudo-locked region sin=
ce
-  the region continues to serve cache hits.
-- The contiguous region of memory loaded into the cache is exposed to
-  user-space as a character device.
-
-Cache pseudo-locking increases the probability that data will remain
-in the cache via carefully configuring the CAT feature and controlling
-application behavior. There is no guarantee that data is placed in
-cache. Instructions like INVD, WBINVD, CLFLUSH, etc. can still evict
-=E2=80=9Clocked=E2=80=9D data from cache. Power management C-states may shri=
nk or
-power off cache. Deeper C-states will automatically be restricted on
-pseudo-locked region creation.
-
-It is required that an application using a pseudo-locked region runs
-with affinity to the cores (or a subset of the cores) associated
-with the cache on which the pseudo-locked region resides. A sanity check
-within the code will not allow an application to map pseudo-locked memory
-unless it runs with affinity to cores associated with the cache on which the
-pseudo-locked region resides. The sanity check is only done during the
-initial mmap() handling, there is no enforcement afterwards and the
-application self needs to ensure it remains affine to the correct cores.
-
-Pseudo-locking is accomplished in two stages:
-
-1) During the first stage the system administrator allocates a portion
-   of cache that should be dedicated to pseudo-locking. At this time an
-   equivalent portion of memory is allocated, loaded into allocated
-   cache portion, and exposed as a character device.
-2) During the second stage a user-space application maps (mmap()) the
-   pseudo-locked memory into its address space.
-
-Cache Pseudo-Locking Interface
-------------------------------
-A pseudo-locked region is created using the resctrl interface as follows:
-
-1) Create a new resource group by creating a new directory in /sys/fs/resctr=
l.
-2) Change the new resource group's mode to "pseudo-locksetup" by writing
-   "pseudo-locksetup" to the "mode" file.
-3) Write the schemata of the pseudo-locked region to the "schemata" file. All
-   bits within the schemata should be "unused" according to the "bit_usage"
-   file.
-
-On successful pseudo-locked region creation the "mode" file will contain
-"pseudo-locked" and a new character device with the same name as the resource
-group will exist in /dev/pseudo_lock. This character device can be mmap()'ed
-by user space in order to obtain access to the pseudo-locked memory region.
-
-An example of cache pseudo-locked region creation and usage can be found bel=
ow.
-
-Cache Pseudo-Locking Debugging Interface
-----------------------------------------
-The pseudo-locking debugging interface is enabled by default (if
-CONFIG_DEBUG_FS is enabled) and can be found in /sys/kernel/debug/resctrl.
-
-There is no explicit way for the kernel to test if a provided memory
-location is present in the cache. The pseudo-locking debugging interface uses
-the tracing infrastructure to provide two ways to measure cache residency of
-the pseudo-locked region:
-
-1) Memory access latency using the pseudo_lock_mem_latency tracepoint. Data
-   from these measurements are best visualized using a hist trigger (see
-   example below). In this test the pseudo-locked region is traversed at
-   a stride of 32 bytes while hardware prefetchers and preemption
-   are disabled. This also provides a substitute visualization of cache
-   hits and misses.
-2) Cache hit and miss measurements using model specific precision counters if
-   available. Depending on the levels of cache on the system the pseudo_lock=
_l2
-   and pseudo_lock_l3 tracepoints are available.
-
-When a pseudo-locked region is created a new debugfs directory is created for
-it in debugfs as /sys/kernel/debug/resctrl/<newdir>. A single
-write-only file, pseudo_lock_measure, is present in this directory. The
-measurement of the pseudo-locked region depends on the number written to this
-debugfs file:
-
-1:
-     writing "1" to the pseudo_lock_measure file will trigger the latency
-     measurement captured in the pseudo_lock_mem_latency tracepoint. See
-     example below.
-2:
-     writing "2" to the pseudo_lock_measure file will trigger the L2 cache
-     residency (cache hits and misses) measurement captured in the
-     pseudo_lock_l2 tracepoint. See example below.
-3:
-     writing "3" to the pseudo_lock_measure file will trigger the L3 cache
-     residency (cache hits and misses) measurement captured in the
-     pseudo_lock_l3 tracepoint.
-
-All measurements are recorded with the tracing infrastructure. This requires
-the relevant tracepoints to be enabled before the measurement is triggered.
-
-Example of latency debugging interface
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-In this example a pseudo-locked region named "newlock" was created. Here is
-how we can measure the latency in cycles of reading from this region and
-visualize this data with a histogram that is available if CONFIG_HIST_TRIGGE=
RS
-is set::
-
-  # :> /sys/kernel/tracing/trace
-  # echo 'hist:keys=3Dlatency' > /sys/kernel/tracing/events/resctrl/pseudo_l=
ock_mem_latency/trigger
-  # echo 1 > /sys/kernel/tracing/events/resctrl/pseudo_lock_mem_latency/enab=
le
-  # echo 1 > /sys/kernel/debug/resctrl/newlock/pseudo_lock_measure
-  # echo 0 > /sys/kernel/tracing/events/resctrl/pseudo_lock_mem_latency/enab=
le
-  # cat /sys/kernel/tracing/events/resctrl/pseudo_lock_mem_latency/hist
-
-  # event histogram
-  #
-  # trigger info: hist:keys=3Dlatency:vals=3Dhitcount:sort=3Dhitcount:size=
=3D2048 [active]
-  #
-
-  { latency:        456 } hitcount:          1
-  { latency:         50 } hitcount:         83
-  { latency:         36 } hitcount:         96
-  { latency:         44 } hitcount:        174
-  { latency:         48 } hitcount:        195
-  { latency:         46 } hitcount:        262
-  { latency:         42 } hitcount:        693
-  { latency:         40 } hitcount:       3204
-  { latency:         38 } hitcount:       3484
-
-  Totals:
-      Hits: 8192
-      Entries: 9
-    Dropped: 0
-
-Example of cache hits/misses debugging
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-In this example a pseudo-locked region named "newlock" was created on the L2
-cache of a platform. Here is how we can obtain details of the cache hits
-and misses using the platform's precision counters.
-::
-
-  # :> /sys/kernel/tracing/trace
-  # echo 1 > /sys/kernel/tracing/events/resctrl/pseudo_lock_l2/enable
-  # echo 2 > /sys/kernel/debug/resctrl/newlock/pseudo_lock_measure
-  # echo 0 > /sys/kernel/tracing/events/resctrl/pseudo_lock_l2/enable
-  # cat /sys/kernel/tracing/trace
-
-  # tracer: nop
-  #
-  #                              _-----=3D> irqs-off
-  #                             / _----=3D> need-resched
-  #                            | / _---=3D> hardirq/softirq
-  #                            || / _--=3D> preempt-depth
-  #                            ||| /     delay
-  #           TASK-PID   CPU#  ||||    TIMESTAMP  FUNCTION
-  #              | |       |   ||||       |         |
-  pseudo_lock_mea-1672  [002] ....  3132.860500: pseudo_lock_l2: hits=3D4097=
 miss=3D0
-
-
-Examples for RDT allocation usage
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-
-1) Example 1
-
-On a two socket machine (one L3 cache per socket) with just four bits
-for cache bit masks, minimum b/w of 10% with a memory bandwidth
-granularity of 10%.
-::
-
-  # mount -t resctrl resctrl /sys/fs/resctrl
-  # cd /sys/fs/resctrl
-  # mkdir p0 p1
-  # echo "L3:0=3D3;1=3Dc\nMB:0=3D50;1=3D50" > /sys/fs/resctrl/p0/schemata
-  # echo "L3:0=3D3;1=3D3\nMB:0=3D50;1=3D50" > /sys/fs/resctrl/p1/schemata
-
-The default resource group is unmodified, so we have access to all parts
-of all caches (its schemata file reads "L3:0=3Df;1=3Df").
-
-Tasks that are under the control of group "p0" may only allocate from the
-"lower" 50% on cache ID 0, and the "upper" 50% of cache ID 1.
-Tasks in group "p1" use the "lower" 50% of cache on both sockets.
-
-Similarly, tasks that are under the control of group "p0" may use a
-maximum memory b/w of 50% on socket0 and 50% on socket 1.
-Tasks in group "p1" may also use 50% memory b/w on both sockets.
-Note that unlike cache masks, memory b/w cannot specify whether these
-allocations can overlap or not. The allocations specifies the maximum
-b/w that the group may be able to use and the system admin can configure
-the b/w accordingly.
-
-If resctrl is using the software controller (mba_sc) then user can enter the
-max b/w in MB rather than the percentage values.
-::
-
-  # echo "L3:0=3D3;1=3Dc\nMB:0=3D1024;1=3D500" > /sys/fs/resctrl/p0/schemata
-  # echo "L3:0=3D3;1=3D3\nMB:0=3D1024;1=3D500" > /sys/fs/resctrl/p1/schemata
-
-In the above example the tasks in "p1" and "p0" on socket 0 would use a max =
b/w
-of 1024MB where as on socket 1 they would use 500MB.
-
-2) Example 2
-
-Again two sockets, but this time with a more realistic 20-bit mask.
-
-Two real time tasks pid=3D1234 running on processor 0 and pid=3D5678 running=
 on
-processor 1 on socket 0 on a 2-socket and dual core machine. To avoid noisy
-neighbors, each of the two real-time tasks exclusively occupies one quarter
-of L3 cache on socket 0.
-::
-
-  # mount -t resctrl resctrl /sys/fs/resctrl
-  # cd /sys/fs/resctrl
-
-First we reset the schemata for the default group so that the "upper"
-50% of the L3 cache on socket 0 and 50% of memory b/w cannot be used by
-ordinary tasks::
-
-  # echo "L3:0=3D3ff;1=3Dfffff\nMB:0=3D50;1=3D100" > schemata
-
-Next we make a resource group for our first real time task and give
-it access to the "top" 25% of the cache on socket 0.
-::
-
-  # mkdir p0
-  # echo "L3:0=3Df8000;1=3Dfffff" > p0/schemata
-
-Finally we move our first real time task into this resource group. We
-also use taskset(1) to ensure the task always runs on a dedicated CPU
-on socket 0. Most uses of resource groups will also constrain which
-processors tasks run on.
-::
-
-  # echo 1234 > p0/tasks
-  # taskset -cp 1 1234
-
-Ditto for the second real time task (with the remaining 25% of cache)::
-
-  # mkdir p1
-  # echo "L3:0=3D7c00;1=3Dfffff" > p1/schemata
-  # echo 5678 > p1/tasks
-  # taskset -cp 2 5678
-
-For the same 2 socket system with memory b/w resource and CAT L3 the
-schemata would look like(Assume min_bandwidth 10 and bandwidth_gran is
-10):
-
-For our first real time task this would request 20% memory b/w on socket 0.
-::
-
-  # echo -e "L3:0=3Df8000;1=3Dfffff\nMB:0=3D20;1=3D100" > p0/schemata
-
-For our second real time task this would request an other 20% memory b/w
-on socket 0.
-::
-
-  # echo -e "L3:0=3Df8000;1=3Dfffff\nMB:0=3D20;1=3D100" > p0/schemata
-
-3) Example 3
-
-A single socket system which has real-time tasks running on core 4-7 and
-non real-time workload assigned to core 0-3. The real-time tasks share text
-and data, so a per task association is not required and due to interaction
-with the kernel it's desired that the kernel on these cores shares L3 with
-the tasks.
-::
-
-  # mount -t resctrl resctrl /sys/fs/resctrl
-  # cd /sys/fs/resctrl
-
-First we reset the schemata for the default group so that the "upper"
-50% of the L3 cache on socket 0, and 50% of memory bandwidth on socket 0
-cannot be used by ordinary tasks::
-
-  # echo "L3:0=3D3ff\nMB:0=3D50" > schemata
-
-Next we make a resource group for our real time cores and give it access
-to the "top" 50% of the cache on socket 0 and 50% of memory bandwidth on
-socket 0.
-::
-
-  # mkdir p0
-  # echo "L3:0=3Dffc00\nMB:0=3D50" > p0/schemata
-
-Finally we move core 4-7 over to the new group and make sure that the
-kernel and the tasks running there get 50% of the cache. They should
-also get 50% of memory bandwidth assuming that the cores 4-7 are SMT
-siblings and only the real time threads are scheduled on the cores 4-7.
-::
-
-  # echo F0 > p0/cpus
-
-4) Example 4
-
-The resource groups in previous examples were all in the default "shareable"
-mode allowing sharing of their cache allocations. If one resource group
-configures a cache allocation then nothing prevents another resource group
-to overlap with that allocation.
-
-In this example a new exclusive resource group will be created on a L2 CAT
-system with two L2 cache instances that can be configured with an 8-bit
-capacity bitmask. The new exclusive resource group will be configured to use
-25% of each cache instance.
-::
-
-  # mount -t resctrl resctrl /sys/fs/resctrl/
-  # cd /sys/fs/resctrl
-
-First, we observe that the default group is configured to allocate to all L2
-cache::
-
-  # cat schemata
-  L2:0=3Dff;1=3Dff
-
-We could attempt to create the new resource group at this point, but it will
-fail because of the overlap with the schemata of the default group::
-
-  # mkdir p0
-  # echo 'L2:0=3D0x3;1=3D0x3' > p0/schemata
-  # cat p0/mode
-  shareable
-  # echo exclusive > p0/mode
-  -sh: echo: write error: Invalid argument
-  # cat info/last_cmd_status
-  schemata overlaps
-
-To ensure that there is no overlap with another resource group the default
-resource group's schemata has to change, making it possible for the new
-resource group to become exclusive.
-::
-
-  # echo 'L2:0=3D0xfc;1=3D0xfc' > schemata
-  # echo exclusive > p0/mode
-  # grep . p0/*
-  p0/cpus:0
-  p0/mode:exclusive
-  p0/schemata:L2:0=3D03;1=3D03
-  p0/size:L2:0=3D262144;1=3D262144
-
-A new resource group will on creation not overlap with an exclusive resource
-group::
-
-  # mkdir p1
-  # grep . p1/*
-  p1/cpus:0
-  p1/mode:shareable
-  p1/schemata:L2:0=3Dfc;1=3Dfc
-  p1/size:L2:0=3D786432;1=3D786432
-
-The bit_usage will reflect how the cache is used::
-
-  # cat info/L2/bit_usage
-  0=3DSSSSSSEE;1=3DSSSSSSEE
-
-A resource group cannot be forced to overlap with an exclusive resource grou=
p::
-
-  # echo 'L2:0=3D0x1;1=3D0x1' > p1/schemata
-  -sh: echo: write error: Invalid argument
-  # cat info/last_cmd_status
-  overlaps with exclusive group
-
-Example of Cache Pseudo-Locking
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-Lock portion of L2 cache from cache id 1 using CBM 0x3. Pseudo-locked
-region is exposed at /dev/pseudo_lock/newlock that can be provided to
-application for argument to mmap().
-::
-
-  # mount -t resctrl resctrl /sys/fs/resctrl/
-  # cd /sys/fs/resctrl
-
-Ensure that there are bits available that can be pseudo-locked, since only
-unused bits can be pseudo-locked the bits to be pseudo-locked needs to be
-removed from the default resource group's schemata::
-
-  # cat info/L2/bit_usage
-  0=3DSSSSSSSS;1=3DSSSSSSSS
-  # echo 'L2:1=3D0xfc' > schemata
-  # cat info/L2/bit_usage
-  0=3DSSSSSSSS;1=3DSSSSSS00
-
-Create a new resource group that will be associated with the pseudo-locked
-region, indicate that it will be used for a pseudo-locked region, and
-configure the requested pseudo-locked region capacity bitmask::
-
-  # mkdir newlock
-  # echo pseudo-locksetup > newlock/mode
-  # echo 'L2:1=3D0x3' > newlock/schemata
-
-On success the resource group's mode will change to pseudo-locked, the
-bit_usage will reflect the pseudo-locked region, and the character device
-exposing the pseudo-locked region will exist::
-
-  # cat newlock/mode
-  pseudo-locked
-  # cat info/L2/bit_usage
-  0=3DSSSSSSSS;1=3DSSSSSSPP
-  # ls -l /dev/pseudo_lock/newlock
-  crw------- 1 root root 243, 0 Apr  3 05:01 /dev/pseudo_lock/newlock
-
-::
-
-  /*
-  * Example code to access one page of pseudo-locked cache region
-  * from user space.
-  */
-  #define _GNU_SOURCE
-  #include <fcntl.h>
-  #include <sched.h>
-  #include <stdio.h>
-  #include <stdlib.h>
-  #include <unistd.h>
-  #include <sys/mman.h>
-
-  /*
-  * It is required that the application runs with affinity to only
-  * cores associated with the pseudo-locked region. Here the cpu
-  * is hardcoded for convenience of example.
-  */
-  static int cpuid =3D 2;
-
-  int main(int argc, char *argv[])
-  {
-    cpu_set_t cpuset;
-    long page_size;
-    void *mapping;
-    int dev_fd;
-    int ret;
-
-    page_size =3D sysconf(_SC_PAGESIZE);
-
-    CPU_ZERO(&cpuset);
-    CPU_SET(cpuid, &cpuset);
-    ret =3D sched_setaffinity(0, sizeof(cpuset), &cpuset);
-    if (ret < 0) {
-      perror("sched_setaffinity");
-      exit(EXIT_FAILURE);
-    }
-
-    dev_fd =3D open("/dev/pseudo_lock/newlock", O_RDWR);
-    if (dev_fd < 0) {
-      perror("open");
-      exit(EXIT_FAILURE);
-    }
-
-    mapping =3D mmap(0, page_size, PROT_READ | PROT_WRITE, MAP_SHARED,
-            dev_fd, 0);
-    if (mapping =3D=3D MAP_FAILED) {
-      perror("mmap");
-      close(dev_fd);
-      exit(EXIT_FAILURE);
-    }
-
-    /* Application interacts with pseudo-locked memory @mapping */
-
-    ret =3D munmap(mapping, page_size);
-    if (ret < 0) {
-      perror("munmap");
-      close(dev_fd);
-      exit(EXIT_FAILURE);
-    }
-
-    close(dev_fd);
-    exit(EXIT_SUCCESS);
-  }
-
-Locking between applications
-----------------------------
-
-Certain operations on the resctrl filesystem, composed of read/writes
-to/from multiple files, must be atomic.
-
-As an example, the allocation of an exclusive reservation of L3 cache
-involves:
-
-  1. Read the cbmmasks from each directory or the per-resource "bit_usage"
-  2. Find a contiguous set of bits in the global CBM bitmask that is clear
-     in any of the directory cbmmasks
-  3. Create a new directory
-  4. Set the bits found in step 2 to the new directory "schemata" file
-
-If two applications attempt to allocate space concurrently then they can
-end up allocating the same bits so the reservations are shared instead of
-exclusive.
-
-To coordinate atomic operations on the resctrlfs and to avoid the problem
-above, the following locking procedure is recommended:
-
-Locking is based on flock, which is available in libc and also as a shell
-script command
-
-Write lock:
-
- A) Take flock(LOCK_EX) on /sys/fs/resctrl
- B) Read/write the directory structure.
- C) funlock
-
-Read lock:
-
- A) Take flock(LOCK_SH) on /sys/fs/resctrl
- B) If success read the directory structure.
- C) funlock
-
-Example with bash::
-
-  # Atomically read directory structure
-  $ flock -s /sys/fs/resctrl/ find /sys/fs/resctrl
-
-  # Read directory contents and create new subdirectory
-
-  $ cat create-dir.sh
-  find /sys/fs/resctrl/ > output.txt
-  mask =3D function-of(output.txt)
-  mkdir /sys/fs/resctrl/newres/
-  echo mask > /sys/fs/resctrl/newres/schemata
-
-  $ flock /sys/fs/resctrl/ ./create-dir.sh
-
-Example with C::
-
-  /*
-  * Example code do take advisory locks
-  * before accessing resctrl filesystem
-  */
-  #include <sys/file.h>
-  #include <stdlib.h>
-
-  void resctrl_take_shared_lock(int fd)
-  {
-    int ret;
-
-    /* take shared lock on resctrl filesystem */
-    ret =3D flock(fd, LOCK_SH);
-    if (ret) {
-      perror("flock");
-      exit(-1);
-    }
-  }
-
-  void resctrl_take_exclusive_lock(int fd)
-  {
-    int ret;
-
-    /* release lock on resctrl filesystem */
-    ret =3D flock(fd, LOCK_EX);
-    if (ret) {
-      perror("flock");
-      exit(-1);
-    }
-  }
-
-  void resctrl_release_lock(int fd)
-  {
-    int ret;
-
-    /* take shared lock on resctrl filesystem */
-    ret =3D flock(fd, LOCK_UN);
-    if (ret) {
-      perror("flock");
-      exit(-1);
-    }
-  }
-
-  void main(void)
-  {
-    int fd, ret;
-
-    fd =3D open("/sys/fs/resctrl", O_DIRECTORY);
-    if (fd =3D=3D -1) {
-      perror("open");
-      exit(-1);
-    }
-    resctrl_take_shared_lock(fd);
-    /* code to read directory contents */
-    resctrl_release_lock(fd);
-
-    resctrl_take_exclusive_lock(fd);
-    /* code to read and write directory contents */
-    resctrl_release_lock(fd);
-  }
-
-Examples for RDT Monitoring along with allocation usage
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
-Reading monitored data
-----------------------
-Reading an event file (for ex: mon_data/mon_L3_00/llc_occupancy) would
-show the current snapshot of LLC occupancy of the corresponding MON
-group or CTRL_MON group.
-
-
-Example 1 (Monitor CTRL_MON group and subset of tasks in CTRL_MON group)
-------------------------------------------------------------------------
-On a two socket machine (one L3 cache per socket) with just four bits
-for cache bit masks::
-
-  # mount -t resctrl resctrl /sys/fs/resctrl
-  # cd /sys/fs/resctrl
-  # mkdir p0 p1
-  # echo "L3:0=3D3;1=3Dc" > /sys/fs/resctrl/p0/schemata
-  # echo "L3:0=3D3;1=3D3" > /sys/fs/resctrl/p1/schemata
-  # echo 5678 > p1/tasks
-  # echo 5679 > p1/tasks
-
-The default resource group is unmodified, so we have access to all parts
-of all caches (its schemata file reads "L3:0=3Df;1=3Df").
-
-Tasks that are under the control of group "p0" may only allocate from the
-"lower" 50% on cache ID 0, and the "upper" 50% of cache ID 1.
-Tasks in group "p1" use the "lower" 50% of cache on both sockets.
-
-Create monitor groups and assign a subset of tasks to each monitor group.
-::
-
-  # cd /sys/fs/resctrl/p1/mon_groups
-  # mkdir m11 m12
-  # echo 5678 > m11/tasks
-  # echo 5679 > m12/tasks
-
-fetch data (data shown in bytes)
-::
-
-  # cat m11/mon_data/mon_L3_00/llc_occupancy
-  16234000
-  # cat m11/mon_data/mon_L3_01/llc_occupancy
-  14789000
-  # cat m12/mon_data/mon_L3_00/llc_occupancy
-  16789000
-
-The parent ctrl_mon group shows the aggregated data.
-::
-
-  # cat /sys/fs/resctrl/p1/mon_data/mon_l3_00/llc_occupancy
-  31234000
-
-Example 2 (Monitor a task from its creation)
---------------------------------------------
-On a two socket machine (one L3 cache per socket)::
-
-  # mount -t resctrl resctrl /sys/fs/resctrl
-  # cd /sys/fs/resctrl
-  # mkdir p0 p1
-
-An RMID is allocated to the group once its created and hence the <cmd>
-below is monitored from its creation.
-::
-
-  # echo $$ > /sys/fs/resctrl/p1/tasks
-  # <cmd>
-
-Fetch the data::
-
-  # cat /sys/fs/resctrl/p1/mon_data/mon_l3_00/llc_occupancy
-  31789000
-
-Example 3 (Monitor without CAT support or before creating CAT groups)
----------------------------------------------------------------------
-
-Assume a system like HSW has only CQM and no CAT support. In this case
-the resctrl will still mount but cannot create CTRL_MON directories.
-But user can create different MON groups within the root group thereby
-able to monitor all tasks including kernel threads.
-
-This can also be used to profile jobs cache size footprint before being
-able to allocate them to different allocation groups.
-::
-
-  # mount -t resctrl resctrl /sys/fs/resctrl
-  # cd /sys/fs/resctrl
-  # mkdir mon_groups/m01
-  # mkdir mon_groups/m02
-
-  # echo 3478 > /sys/fs/resctrl/mon_groups/m01/tasks
-  # echo 2467 > /sys/fs/resctrl/mon_groups/m02/tasks
-
-Monitor the groups separately and also get per domain data. From the
-below its apparent that the tasks are mostly doing work on
-domain(socket) 0.
-::
-
-  # cat /sys/fs/resctrl/mon_groups/m01/mon_L3_00/llc_occupancy
-  31234000
-  # cat /sys/fs/resctrl/mon_groups/m01/mon_L3_01/llc_occupancy
-  34555
-  # cat /sys/fs/resctrl/mon_groups/m02/mon_L3_00/llc_occupancy
-  31234000
-  # cat /sys/fs/resctrl/mon_groups/m02/mon_L3_01/llc_occupancy
-  32789
-
-
-Example 4 (Monitor real time tasks)
------------------------------------
-
-A single socket system which has real time tasks running on cores 4-7
-and non real time tasks on other cpus. We want to monitor the cache
-occupancy of the real time threads on these cores.
-::
-
-  # mount -t resctrl resctrl /sys/fs/resctrl
-  # cd /sys/fs/resctrl
-  # mkdir p1
-
-Move the cpus 4-7 over to p1::
-
-  # echo f0 > p1/cpus
-
-View the llc occupancy snapshot::
-
-  # cat /sys/fs/resctrl/p1/mon_data/mon_L3_00/llc_occupancy
-  11234000
-
-Intel RDT Errata
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-
-Intel MBM Counters May Report System Memory Bandwidth Incorrectly
------------------------------------------------------------------
-
-Errata SKX99 for Skylake server and BDF102 for Broadwell server.
-
-Problem: Intel Memory Bandwidth Monitoring (MBM) counters track metrics
-according to the assigned Resource Monitor ID (RMID) for that logical
-core. The IA32_QM_CTR register (MSR 0xC8E), used to report these
-metrics, may report incorrect system bandwidth for certain RMID values.
-
-Implication: Due to the errata, system memory bandwidth may not match
-what is reported.
-
-Workaround: MBM total and local readings are corrected according to the
-following correction factor table:
-
-+---------------+---------------+---------------+-----------------+
-|core count	|rmid count	|rmid threshold	|correction factor|
-+---------------+---------------+---------------+-----------------+
-|1		|8		|0		|1.000000	  |
-+---------------+---------------+---------------+-----------------+
-|2		|16		|0		|1.000000	  |
-+---------------+---------------+---------------+-----------------+
-|3		|24		|15		|0.969650	  |
-+---------------+---------------+---------------+-----------------+
-|4		|32		|0		|1.000000	  |
-+---------------+---------------+---------------+-----------------+
-|6		|48		|31		|0.969650	  |
-+---------------+---------------+---------------+-----------------+
-|7		|56		|47		|1.142857	  |
-+---------------+---------------+---------------+-----------------+
-|8		|64		|0		|1.000000	  |
-+---------------+---------------+---------------+-----------------+
-|9		|72		|63		|1.185115	  |
-+---------------+---------------+---------------+-----------------+
-|10		|80		|63		|1.066553	  |
-+---------------+---------------+---------------+-----------------+
-|11		|88		|79		|1.454545	  |
-+---------------+---------------+---------------+-----------------+
-|12		|96		|0		|1.000000	  |
-+---------------+---------------+---------------+-----------------+
-|13		|104		|95		|1.230769	  |
-+---------------+---------------+---------------+-----------------+
-|14		|112		|95		|1.142857	  |
-+---------------+---------------+---------------+-----------------+
-|15		|120		|95		|1.066667	  |
-+---------------+---------------+---------------+-----------------+
-|16		|128		|0		|1.000000	  |
-+---------------+---------------+---------------+-----------------+
-|17		|136		|127		|1.254863	  |
-+---------------+---------------+---------------+-----------------+
-|18		|144		|127		|1.185255	  |
-+---------------+---------------+---------------+-----------------+
-|19		|152		|0		|1.000000	  |
-+---------------+---------------+---------------+-----------------+
-|20		|160		|127		|1.066667	  |
-+---------------+---------------+---------------+-----------------+
-|21		|168		|0		|1.000000	  |
-+---------------+---------------+---------------+-----------------+
-|22		|176		|159		|1.454334	  |
-+---------------+---------------+---------------+-----------------+
-|23		|184		|0		|1.000000	  |
-+---------------+---------------+---------------+-----------------+
-|24		|192		|127		|0.969744	  |
-+---------------+---------------+---------------+-----------------+
-|25		|200		|191		|1.280246	  |
-+---------------+---------------+---------------+-----------------+
-|26		|208		|191		|1.230921	  |
-+---------------+---------------+---------------+-----------------+
-|27		|216		|0		|1.000000	  |
-+---------------+---------------+---------------+-----------------+
-|28		|224		|191		|1.143118	  |
-+---------------+---------------+---------------+-----------------+
-
-If rmid > rmid threshold, MBM total and local values should be multiplied
-by the correction factor.
-
-See:
-
-1. Erratum SKX99 in Intel Xeon Processor Scalable Family Specification Updat=
e:
-http://web.archive.org/web/20200716124958/https://www.intel.com/content/www/=
us/en/processors/xeon/scalable/xeon-scalable-spec-update.html
-
-2. Erratum BDF102 in Intel Xeon E5-2600 v4 Processor Product Family Specific=
ation Update:
-http://web.archive.org/web/20191125200531/https://www.intel.com/content/dam/=
www/public/us/en/documents/specification-updates/xeon-e5-v4-spec-update.pdf
-
-3. The errata in Intel Resource Director Technology (Intel RDT) on 2nd Gener=
ation Intel Xeon Scalable Processors Reference Manual:
-https://software.intel.com/content/www/us/en/develop/articles/intel-resource=
-director-technology-rdt-reference-manual.html
-
-for further information.
diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/=
index.rst
index a9cf8e9..3261851 100644
--- a/Documentation/filesystems/index.rst
+++ b/Documentation/filesystems/index.rst
@@ -113,6 +113,7 @@ Documentation for filesystem implementations.
    qnx6
    ramfs-rootfs-initramfs
    relay
+   resctrl
    romfs
    smb/index
    spufs/index
diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystem=
s/resctrl.rst
new file mode 100644
index 0000000..c7949dd
--- /dev/null
+++ b/Documentation/filesystems/resctrl.rst
@@ -0,0 +1,1523 @@
+.. SPDX-License-Identifier: GPL-2.0
+.. include:: <isonum.txt>
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
+User Interface for Resource Control feature (resctrl)
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
+
+:Copyright: |copy| 2016 Intel Corporation
+:Authors: - Fenghua Yu <fenghua.yu@intel.com>
+          - Tony Luck <tony.luck@intel.com>
+          - Vikas Shivappa <vikas.shivappa@intel.com>
+
+
+Intel refers to this feature as Intel Resource Director Technology(Intel(R) =
RDT).
+AMD refers to this feature as AMD Platform Quality of Service(AMD QoS).
+
+This feature is enabled by the CONFIG_X86_CPU_RESCTRL and the x86 /proc/cpui=
nfo
+flag bits:
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
+RDT (Resource Director Technology) Allocation	"rdt_a"
+CAT (Cache Allocation Technology)		"cat_l3", "cat_l2"
+CDP (Code and Data Prioritization)		"cdp_l3", "cdp_l2"
+CQM (Cache QoS Monitoring)			"cqm_llc", "cqm_occup_llc"
+MBM (Memory Bandwidth Monitoring)		"cqm_mbm_total", "cqm_mbm_local"
+MBA (Memory Bandwidth Allocation)		"mba"
+SMBA (Slow Memory Bandwidth Allocation)         ""
+BMEC (Bandwidth Monitoring Event Configuration) ""
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
+
+Historically, new features were made visible by default in /proc/cpuinfo. Th=
is
+resulted in the feature flags becoming hard to parse by humans. Adding a new
+flag to /proc/cpuinfo should be avoided if user space can obtain information
+about the feature from resctrl's info directory.
+
+To use the feature mount the file system::
+
+ # mount -t resctrl resctrl [-o cdp[,cdpl2][,mba_MBps][,debug]] /sys/fs/resc=
trl
+
+mount options are:
+
+"cdp":
+	Enable code/data prioritization in L3 cache allocations.
+"cdpl2":
+	Enable code/data prioritization in L2 cache allocations.
+"mba_MBps":
+	Enable the MBA Software Controller(mba_sc) to specify MBA
+	bandwidth in MiBps
+"debug":
+	Make debug files accessible. Available debug files are annotated with
+	"Available only with debug option".
+
+L2 and L3 CDP are controlled separately.
+
+RDT features are orthogonal. A particular system may support only
+monitoring, only control, or both monitoring and control.  Cache
+pseudo-locking is a unique way of using cache control to "pin" or
+"lock" data in the cache. Details can be found in
+"Cache Pseudo-Locking".
+
+
+The mount succeeds if either of allocation or monitoring is present, but
+only those files and directories supported by the system will be created.
+For more details on the behavior of the interface during monitoring
+and allocation, see the "Resource alloc and monitor groups" section.
+
+Info directory
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+The 'info' directory contains information about the enabled
+resources. Each resource has its own subdirectory. The subdirectory
+names reflect the resource names.
+
+Each subdirectory contains the following files with respect to
+allocation:
+
+Cache resource(L3/L2)  subdirectory contains the following files
+related to allocation:
+
+"num_closids":
+		The number of CLOSIDs which are valid for this
+		resource. The kernel uses the smallest number of
+		CLOSIDs of all enabled resources as limit.
+"cbm_mask":
+		The bitmask which is valid for this resource.
+		This mask is equivalent to 100%.
+"min_cbm_bits":
+		The minimum number of consecutive bits which
+		must be set when writing a mask.
+
+"shareable_bits":
+		Bitmask of shareable resource with other executing
+		entities (e.g. I/O). User can use this when
+		setting up exclusive cache partitions. Note that
+		some platforms support devices that have their
+		own settings for cache use which can over-ride
+		these bits.
+"bit_usage":
+		Annotated capacity bitmasks showing how all
+		instances of the resource are used. The legend is:
+
+			"0":
+			      Corresponding region is unused. When the system's
+			      resources have been allocated and a "0" is found
+			      in "bit_usage" it is a sign that resources are
+			      wasted.
+
+			"H":
+			      Corresponding region is used by hardware only
+			      but available for software use. If a resource
+			      has bits set in "shareable_bits" but not all
+			      of these bits appear in the resource groups'
+			      schematas then the bits appearing in
+			      "shareable_bits" but no resource group will
+			      be marked as "H".
+			"X":
+			      Corresponding region is available for sharing and
+			      used by hardware and software. These are the
+			      bits that appear in "shareable_bits" as
+			      well as a resource group's allocation.
+			"S":
+			      Corresponding region is used by software
+			      and available for sharing.
+			"E":
+			      Corresponding region is used exclusively by
+			      one resource group. No sharing allowed.
+			"P":
+			      Corresponding region is pseudo-locked. No
+			      sharing allowed.
+"sparse_masks":
+		Indicates if non-contiguous 1s value in CBM is supported.
+
+			"0":
+			      Only contiguous 1s value in CBM is supported.
+			"1":
+			      Non-contiguous 1s value in CBM is supported.
+
+Memory bandwidth(MB) subdirectory contains the following files
+with respect to allocation:
+
+"min_bandwidth":
+		The minimum memory bandwidth percentage which
+		user can request.
+
+"bandwidth_gran":
+		The granularity in which the memory bandwidth
+		percentage is allocated. The allocated
+		b/w percentage is rounded off to the next
+		control step available on the hardware. The
+		available bandwidth control steps are:
+		min_bandwidth + N * bandwidth_gran.
+
+"delay_linear":
+		Indicates if the delay scale is linear or
+		non-linear. This field is purely informational
+		only.
+
+"thread_throttle_mode":
+		Indicator on Intel systems of how tasks running on threads
+		of a physical core are throttled in cases where they
+		request different memory bandwidth percentages:
+
+		"max":
+			the smallest percentage is applied
+			to all threads
+		"per-thread":
+			bandwidth percentages are directly applied to
+			the threads running on the core
+
+If RDT monitoring is available there will be an "L3_MON" directory
+with the following files:
+
+"num_rmids":
+		The number of RMIDs available. This is the
+		upper bound for how many "CTRL_MON" + "MON"
+		groups can be created.
+
+"mon_features":
+		Lists the monitoring events if
+		monitoring is enabled for the resource.
+		Example::
+
+			# cat /sys/fs/resctrl/info/L3_MON/mon_features
+			llc_occupancy
+			mbm_total_bytes
+			mbm_local_bytes
+
+		If the system supports Bandwidth Monitoring Event
+		Configuration (BMEC), then the bandwidth events will
+		be configurable. The output will be::
+
+			# cat /sys/fs/resctrl/info/L3_MON/mon_features
+			llc_occupancy
+			mbm_total_bytes
+			mbm_total_bytes_config
+			mbm_local_bytes
+			mbm_local_bytes_config
+
+"mbm_total_bytes_config", "mbm_local_bytes_config":
+	Read/write files containing the configuration for the mbm_total_bytes
+	and mbm_local_bytes events, respectively, when the Bandwidth
+	Monitoring Event Configuration (BMEC) feature is supported.
+	The event configuration settings are domain specific and affect
+	all the CPUs in the domain. When either event configuration is
+	changed, the bandwidth counters for all RMIDs of both events
+	(mbm_total_bytes as well as mbm_local_bytes) are cleared for that
+	domain. The next read for every RMID will report "Unavailable"
+	and subsequent reads will report the valid value.
+
+	Following are the types of events supported:
+
+	=3D=3D=3D=3D    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+	Bits    Description
+	=3D=3D=3D=3D    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+	6       Dirty Victims from the QOS domain to all types of memory
+	5       Reads to slow memory in the non-local NUMA domain
+	4       Reads to slow memory in the local NUMA domain
+	3       Non-temporal writes to non-local NUMA domain
+	2       Non-temporal writes to local NUMA domain
+	1       Reads to memory in the non-local NUMA domain
+	0       Reads to memory in the local NUMA domain
+	=3D=3D=3D=3D    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+	By default, the mbm_total_bytes configuration is set to 0x7f to count
+	all the event types and the mbm_local_bytes configuration is set to
+	0x15 to count all the local memory events.
+
+	Examples:
+
+	* To view the current configuration::
+	  ::
+
+	    # cat /sys/fs/resctrl/info/L3_MON/mbm_total_bytes_config
+	    0=3D0x7f;1=3D0x7f;2=3D0x7f;3=3D0x7f
+
+	    # cat /sys/fs/resctrl/info/L3_MON/mbm_local_bytes_config
+	    0=3D0x15;1=3D0x15;3=3D0x15;4=3D0x15
+
+	* To change the mbm_total_bytes to count only reads on domain 0,
+	  the bits 0, 1, 4 and 5 needs to be set, which is 110011b in binary
+	  (in hexadecimal 0x33):
+	  ::
+
+	    # echo  "0=3D0x33" > /sys/fs/resctrl/info/L3_MON/mbm_total_bytes_config
+
+	    # cat /sys/fs/resctrl/info/L3_MON/mbm_total_bytes_config
+	    0=3D0x33;1=3D0x7f;2=3D0x7f;3=3D0x7f
+
+	* To change the mbm_local_bytes to count all the slow memory reads on
+	  domain 0 and 1, the bits 4 and 5 needs to be set, which is 110000b
+	  in binary (in hexadecimal 0x30):
+	  ::
+
+	    # echo  "0=3D0x30;1=3D0x30" > /sys/fs/resctrl/info/L3_MON/mbm_local_byt=
es_config
+
+	    # cat /sys/fs/resctrl/info/L3_MON/mbm_local_bytes_config
+	    0=3D0x30;1=3D0x30;3=3D0x15;4=3D0x15
+
+"max_threshold_occupancy":
+		Read/write file provides the largest value (in
+		bytes) at which a previously used LLC_occupancy
+		counter can be considered for re-use.
+
+Finally, in the top level of the "info" directory there is a file
+named "last_cmd_status". This is reset with every "command" issued
+via the file system (making new directories or writing to any of the
+control files). If the command was successful, it will read as "ok".
+If the command failed, it will provide more information that can be
+conveyed in the error returns from file operations. E.g.
+::
+
+	# echo L3:0=3Df7 > schemata
+	bash: echo: write error: Invalid argument
+	# cat info/last_cmd_status
+	mask f7 has non-consecutive 1-bits
+
+Resource alloc and monitor groups
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
+
+Resource groups are represented as directories in the resctrl file
+system.  The default group is the root directory which, immediately
+after mounting, owns all the tasks and cpus in the system and can make
+full use of all resources.
+
+On a system with RDT control features additional directories can be
+created in the root directory that specify different amounts of each
+resource (see "schemata" below). The root and these additional top level
+directories are referred to as "CTRL_MON" groups below.
+
+On a system with RDT monitoring the root directory and other top level
+directories contain a directory named "mon_groups" in which additional
+directories can be created to monitor subsets of tasks in the CTRL_MON
+group that is their ancestor. These are called "MON" groups in the rest
+of this document.
+
+Removing a directory will move all tasks and cpus owned by the group it
+represents to the parent. Removing one of the created CTRL_MON groups
+will automatically remove all MON groups below it.
+
+Moving MON group directories to a new parent CTRL_MON group is supported
+for the purpose of changing the resource allocations of a MON group
+without impacting its monitoring data or assigned tasks. This operation
+is not allowed for MON groups which monitor CPUs. No other move
+operation is currently allowed other than simply renaming a CTRL_MON or
+MON group.
+
+All groups contain the following files:
+
+"tasks":
+	Reading this file shows the list of all tasks that belong to
+	this group. Writing a task id to the file will add a task to the
+	group. Multiple tasks can be added by separating the task ids
+	with commas. Tasks will be assigned sequentially. Multiple
+	failures are not supported. A single failure encountered while
+	attempting to assign a task will cause the operation to abort and
+	already added tasks before the failure will remain in the group.
+	Failures will be logged to /sys/fs/resctrl/info/last_cmd_status.
+
+	If the group is a CTRL_MON group the task is removed from
+	whichever previous CTRL_MON group owned the task and also from
+	any MON group that owned the task. If the group is a MON group,
+	then the task must already belong to the CTRL_MON parent of this
+	group. The task is removed from any previous MON group.
+
+
+"cpus":
+	Reading this file shows a bitmask of the logical CPUs owned by
+	this group. Writing a mask to this file will add and remove
+	CPUs to/from this group. As with the tasks file a hierarchy is
+	maintained where MON groups may only include CPUs owned by the
+	parent CTRL_MON group.
+	When the resource group is in pseudo-locked mode this file will
+	only be readable, reflecting the CPUs associated with the
+	pseudo-locked region.
+
+
+"cpus_list":
+	Just like "cpus", only using ranges of CPUs instead of bitmasks.
+
+
+When control is enabled all CTRL_MON groups will also contain:
+
+"schemata":
+	A list of all the resources available to this group.
+	Each resource has its own line and format - see below for details.
+
+"size":
+	Mirrors the display of the "schemata" file to display the size in
+	bytes of each allocation instead of the bits representing the
+	allocation.
+
+"mode":
+	The "mode" of the resource group dictates the sharing of its
+	allocations. A "shareable" resource group allows sharing of its
+	allocations while an "exclusive" resource group does not. A
+	cache pseudo-locked region is created by first writing
+	"pseudo-locksetup" to the "mode" file before writing the cache
+	pseudo-locked region's schemata to the resource group's "schemata"
+	file. On successful pseudo-locked region creation the mode will
+	automatically change to "pseudo-locked".
+
+"ctrl_hw_id":
+	Available only with debug option. The identifier used by hardware
+	for the control group. On x86 this is the CLOSID.
+
+When monitoring is enabled all MON groups will also contain:
+
+"mon_data":
+	This contains a set of files organized by L3 domain and by
+	RDT event. E.g. on a system with two L3 domains there will
+	be subdirectories "mon_L3_00" and "mon_L3_01".	Each of these
+	directories have one file per event (e.g. "llc_occupancy",
+	"mbm_total_bytes", and "mbm_local_bytes"). In a MON group these
+	files provide a read out of the current value of the event for
+	all tasks in the group. In CTRL_MON groups these files provide
+	the sum for all tasks in the CTRL_MON group and all tasks in
+	MON groups. Please see example section for more details on usage.
+	On systems with Sub-NUMA Cluster (SNC) enabled there are extra
+	directories for each node (located within the "mon_L3_XX" directory
+	for the L3 cache they occupy). These are named "mon_sub_L3_YY"
+	where "YY" is the node number.
+
+"mon_hw_id":
+	Available only with debug option. The identifier used by hardware
+	for the monitor group. On x86 this is the RMID.
+
+When the "mba_MBps" mount option is used all CTRL_MON groups will also conta=
in:
+
+"mba_MBps_event":
+	Reading this file shows which memory bandwidth event is used
+	as input to the software feedback loop that keeps memory bandwidth
+	below the value specified in the schemata file. Writing the
+	name of one of the supported memory bandwidth events found in
+	/sys/fs/resctrl/info/L3_MON/mon_features changes the input
+	event.
+
+Resource allocation rules
+-------------------------
+
+When a task is running the following rules define which resources are
+available to it:
+
+1) If the task is a member of a non-default group, then the schemata
+   for that group is used.
+
+2) Else if the task belongs to the default group, but is running on a
+   CPU that is assigned to some specific group, then the schemata for the
+   CPU's group is used.
+
+3) Otherwise the schemata for the default group is used.
+
+Resource monitoring rules
+-------------------------
+1) If a task is a member of a MON group, or non-default CTRL_MON group
+   then RDT events for the task will be reported in that group.
+
+2) If a task is a member of the default CTRL_MON group, but is running
+   on a CPU that is assigned to some specific group, then the RDT events
+   for the task will be reported in that group.
+
+3) Otherwise RDT events for the task will be reported in the root level
+   "mon_data" group.
+
+
+Notes on cache occupancy monitoring and control
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+When moving a task from one group to another you should remember that
+this only affects *new* cache allocations by the task. E.g. you may have
+a task in a monitor group showing 3 MB of cache occupancy. If you move
+to a new group and immediately check the occupancy of the old and new
+groups you will likely see that the old group is still showing 3 MB and
+the new group zero. When the task accesses locations still in cache from
+before the move, the h/w does not update any counters. On a busy system
+you will likely see the occupancy in the old group go down as cache lines
+are evicted and re-used while the occupancy in the new group rises as
+the task accesses memory and loads into the cache are counted based on
+membership in the new group.
+
+The same applies to cache allocation control. Moving a task to a group
+with a smaller cache partition will not evict any cache lines. The
+process may continue to use them from the old partition.
+
+Hardware uses CLOSid(Class of service ID) and an RMID(Resource monitoring ID)
+to identify a control group and a monitoring group respectively. Each of
+the resource groups are mapped to these IDs based on the kind of group. The
+number of CLOSid and RMID are limited by the hardware and hence the creation=
 of
+a "CTRL_MON" directory may fail if we run out of either CLOSID or RMID
+and creation of "MON" group may fail if we run out of RMIDs.
+
+max_threshold_occupancy - generic concepts
+------------------------------------------
+
+Note that an RMID once freed may not be immediately available for use as
+the RMID is still tagged the cache lines of the previous user of RMID.
+Hence such RMIDs are placed on limbo list and checked back if the cache
+occupancy has gone down. If there is a time when system has a lot of
+limbo RMIDs but which are not ready to be used, user may see an -EBUSY
+during mkdir.
+
+max_threshold_occupancy is a user configurable value to determine the
+occupancy at which an RMID can be freed.
+
+The mon_llc_occupancy_limbo tracepoint gives the precise occupancy in bytes
+for a subset of RMID that are not immediately available for allocation.
+This can't be relied on to produce output every second, it may be necessary
+to attempt to create an empty monitor group to force an update. Output may
+only be produced if creation of a control or monitor group fails.
+
+Schemata files - general concepts
+---------------------------------
+Each line in the file describes one resource. The line starts with
+the name of the resource, followed by specific values to be applied
+in each of the instances of that resource on the system.
+
+Cache IDs
+---------
+On current generation systems there is one L3 cache per socket and L2
+caches are generally just shared by the hyperthreads on a core, but this
+isn't an architectural requirement. We could have multiple separate L3
+caches on a socket, multiple cores could share an L2 cache. So instead
+of using "socket" or "core" to define the set of logical cpus sharing
+a resource we use a "Cache ID". At a given cache level this will be a
+unique number across the whole system (but it isn't guaranteed to be a
+contiguous sequence, there may be gaps).  To find the ID for each logical
+CPU look in /sys/devices/system/cpu/cpu*/cache/index*/id
+
+Cache Bit Masks (CBM)
+---------------------
+For cache resources we describe the portion of the cache that is available
+for allocation using a bitmask. The maximum value of the mask is defined
+by each cpu model (and may be different for different cache levels). It
+is found using CPUID, but is also provided in the "info" directory of
+the resctrl file system in "info/{resource}/cbm_mask". Some Intel hardware
+requires that these masks have all the '1' bits in a contiguous block. So
+0x3, 0x6 and 0xC are legal 4-bit masks with two bits set, but 0x5, 0x9
+and 0xA are not. Check /sys/fs/resctrl/info/{resource}/sparse_masks
+if non-contiguous 1s value is supported. On a system with a 20-bit mask
+each bit represents 5% of the capacity of the cache. You could partition
+the cache into four equal parts with masks: 0x1f, 0x3e0, 0x7c00, 0xf8000.
+
+Notes on Sub-NUMA Cluster mode
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
+When SNC mode is enabled, Linux may load balance tasks between Sub-NUMA
+nodes much more readily than between regular NUMA nodes since the CPUs
+on Sub-NUMA nodes share the same L3 cache and the system may report
+the NUMA distance between Sub-NUMA nodes with a lower value than used
+for regular NUMA nodes.
+
+The top-level monitoring files in each "mon_L3_XX" directory provide
+the sum of data across all SNC nodes sharing an L3 cache instance.
+Users who bind tasks to the CPUs of a specific Sub-NUMA node can read
+the "llc_occupancy", "mbm_total_bytes", and "mbm_local_bytes" in the
+"mon_sub_L3_YY" directories to get node local data.
+
+Memory bandwidth allocation is still performed at the L3 cache
+level. I.e. throttling controls are applied to all SNC nodes.
+
+L3 cache allocation bitmaps also apply to all SNC nodes. But note that
+the amount of L3 cache represented by each bit is divided by the number
+of SNC nodes per L3 cache. E.g. with a 100MB cache on a system with 10-bit
+allocation masks each bit normally represents 10MB. With SNC mode enabled
+with two SNC nodes per L3 cache, each bit only represents 5MB.
+
+Memory bandwidth Allocation and monitoring
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+For Memory bandwidth resource, by default the user controls the resource
+by indicating the percentage of total memory bandwidth.
+
+The minimum bandwidth percentage value for each cpu model is predefined
+and can be looked up through "info/MB/min_bandwidth". The bandwidth
+granularity that is allocated is also dependent on the cpu model and can
+be looked up at "info/MB/bandwidth_gran". The available bandwidth
+control steps are: min_bw + N * bw_gran. Intermediate values are rounded
+to the next control step available on the hardware.
+
+The bandwidth throttling is a core specific mechanism on some of Intel
+SKUs. Using a high bandwidth and a low bandwidth setting on two threads
+sharing a core may result in both threads being throttled to use the
+low bandwidth (see "thread_throttle_mode").
+
+The fact that Memory bandwidth allocation(MBA) may be a core
+specific mechanism where as memory bandwidth monitoring(MBM) is done at
+the package level may lead to confusion when users try to apply control
+via the MBA and then monitor the bandwidth to see if the controls are
+effective. Below are such scenarios:
+
+1. User may *not* see increase in actual bandwidth when percentage
+   values are increased:
+
+This can occur when aggregate L2 external bandwidth is more than L3
+external bandwidth. Consider an SKL SKU with 24 cores on a package and
+where L2 external  is 10GBps (hence aggregate L2 external bandwidth is
+240GBps) and L3 external bandwidth is 100GBps. Now a workload with '20
+threads, having 50% bandwidth, each consuming 5GBps' consumes the max L3
+bandwidth of 100GBps although the percentage value specified is only 50%
+<< 100%. Hence increasing the bandwidth percentage will not yield any
+more bandwidth. This is because although the L2 external bandwidth still
+has capacity, the L3 external bandwidth is fully used. Also note that
+this would be dependent on number of cores the benchmark is run on.
+
+2. Same bandwidth percentage may mean different actual bandwidth
+   depending on # of threads:
+
+For the same SKU in #1, a 'single thread, with 10% bandwidth' and '4
+thread, with 10% bandwidth' can consume upto 10GBps and 40GBps although
+they have same percentage bandwidth of 10%. This is simply because as
+threads start using more cores in an rdtgroup, the actual bandwidth may
+increase or vary although user specified bandwidth percentage is same.
+
+In order to mitigate this and make the interface more user friendly,
+resctrl added support for specifying the bandwidth in MiBps as well.  The
+kernel underneath would use a software feedback mechanism or a "Software
+Controller(mba_sc)" which reads the actual bandwidth using MBM counters
+and adjust the memory bandwidth percentages to ensure::
+
+	"actual bandwidth < user specified bandwidth".
+
+By default, the schemata would take the bandwidth percentage values
+where as user can switch to the "MBA software controller" mode using
+a mount option 'mba_MBps'. The schemata format is specified in the below
+sections.
+
+L3 schemata file details (code and data prioritization disabled)
+----------------------------------------------------------------
+With CDP disabled the L3 schemata format is::
+
+	L3:<cache_id0>=3D<cbm>;<cache_id1>=3D<cbm>;...
+
+L3 schemata file details (CDP enabled via mount option to resctrl)
+------------------------------------------------------------------
+When CDP is enabled L3 control is split into two separate resources
+so you can specify independent masks for code and data like this::
+
+	L3DATA:<cache_id0>=3D<cbm>;<cache_id1>=3D<cbm>;...
+	L3CODE:<cache_id0>=3D<cbm>;<cache_id1>=3D<cbm>;...
+
+L2 schemata file details
+------------------------
+CDP is supported at L2 using the 'cdpl2' mount option. The schemata
+format is either::
+
+	L2:<cache_id0>=3D<cbm>;<cache_id1>=3D<cbm>;...
+
+or
+
+	L2DATA:<cache_id0>=3D<cbm>;<cache_id1>=3D<cbm>;...
+	L2CODE:<cache_id0>=3D<cbm>;<cache_id1>=3D<cbm>;...
+
+
+Memory bandwidth Allocation (default mode)
+------------------------------------------
+
+Memory b/w domain is L3 cache.
+::
+
+	MB:<cache_id0>=3Dbandwidth0;<cache_id1>=3Dbandwidth1;...
+
+Memory bandwidth Allocation specified in MiBps
+----------------------------------------------
+
+Memory bandwidth domain is L3 cache.
+::
+
+	MB:<cache_id0>=3Dbw_MiBps0;<cache_id1>=3Dbw_MiBps1;...
+
+Slow Memory Bandwidth Allocation (SMBA)
+---------------------------------------
+AMD hardware supports Slow Memory Bandwidth Allocation (SMBA).
+CXL.memory is the only supported "slow" memory device. With the
+support of SMBA, the hardware enables bandwidth allocation on
+the slow memory devices. If there are multiple such devices in
+the system, the throttling logic groups all the slow sources
+together and applies the limit on them as a whole.
+
+The presence of SMBA (with CXL.memory) is independent of slow memory
+devices presence. If there are no such devices on the system, then
+configuring SMBA will have no impact on the performance of the system.
+
+The bandwidth domain for slow memory is L3 cache. Its schemata file
+is formatted as:
+::
+
+	SMBA:<cache_id0>=3Dbandwidth0;<cache_id1>=3Dbandwidth1;...
+
+Reading/writing the schemata file
+---------------------------------
+Reading the schemata file will show the state of all resources
+on all domains. When writing you only need to specify those values
+which you wish to change.  E.g.
+::
+
+  # cat schemata
+  L3DATA:0=3Dfffff;1=3Dfffff;2=3Dfffff;3=3Dfffff
+  L3CODE:0=3Dfffff;1=3Dfffff;2=3Dfffff;3=3Dfffff
+  # echo "L3DATA:2=3D3c0;" > schemata
+  # cat schemata
+  L3DATA:0=3Dfffff;1=3Dfffff;2=3D3c0;3=3Dfffff
+  L3CODE:0=3Dfffff;1=3Dfffff;2=3Dfffff;3=3Dfffff
+
+Reading/writing the schemata file (on AMD systems)
+--------------------------------------------------
+Reading the schemata file will show the current bandwidth limit on all
+domains. The allocated resources are in multiples of one eighth GB/s.
+When writing to the file, you need to specify what cache id you wish to
+configure the bandwidth limit.
+
+For example, to allocate 2GB/s limit on the first cache id:
+
+::
+
+  # cat schemata
+    MB:0=3D2048;1=3D2048;2=3D2048;3=3D2048
+    L3:0=3Dffff;1=3Dffff;2=3Dffff;3=3Dffff
+
+  # echo "MB:1=3D16" > schemata
+  # cat schemata
+    MB:0=3D2048;1=3D  16;2=3D2048;3=3D2048
+    L3:0=3Dffff;1=3Dffff;2=3Dffff;3=3Dffff
+
+Reading/writing the schemata file (on AMD systems) with SMBA feature
+--------------------------------------------------------------------
+Reading and writing the schemata file is the same as without SMBA in
+above section.
+
+For example, to allocate 8GB/s limit on the first cache id:
+
+::
+
+  # cat schemata
+    SMBA:0=3D2048;1=3D2048;2=3D2048;3=3D2048
+      MB:0=3D2048;1=3D2048;2=3D2048;3=3D2048
+      L3:0=3Dffff;1=3Dffff;2=3Dffff;3=3Dffff
+
+  # echo "SMBA:1=3D64" > schemata
+  # cat schemata
+    SMBA:0=3D2048;1=3D  64;2=3D2048;3=3D2048
+      MB:0=3D2048;1=3D2048;2=3D2048;3=3D2048
+      L3:0=3Dffff;1=3Dffff;2=3Dffff;3=3Dffff
+
+Cache Pseudo-Locking
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+CAT enables a user to specify the amount of cache space that an
+application can fill. Cache pseudo-locking builds on the fact that a
+CPU can still read and write data pre-allocated outside its current
+allocated area on a cache hit. With cache pseudo-locking, data can be
+preloaded into a reserved portion of cache that no application can
+fill, and from that point on will only serve cache hits. The cache
+pseudo-locked memory is made accessible to user space where an
+application can map it into its virtual address space and thus have
+a region of memory with reduced average read latency.
+
+The creation of a cache pseudo-locked region is triggered by a request
+from the user to do so that is accompanied by a schemata of the region
+to be pseudo-locked. The cache pseudo-locked region is created as follows:
+
+- Create a CAT allocation CLOSNEW with a CBM matching the schemata
+  from the user of the cache region that will contain the pseudo-locked
+  memory. This region must not overlap with any current CAT allocation/CLOS
+  on the system and no future overlap with this cache region is allowed
+  while the pseudo-locked region exists.
+- Create a contiguous region of memory of the same size as the cache
+  region.
+- Flush the cache, disable hardware prefetchers, disable preemption.
+- Make CLOSNEW the active CLOS and touch the allocated memory to load
+  it into the cache.
+- Set the previous CLOS as active.
+- At this point the closid CLOSNEW can be released - the cache
+  pseudo-locked region is protected as long as its CBM does not appear in
+  any CAT allocation. Even though the cache pseudo-locked region will from
+  this point on not appear in any CBM of any CLOS an application running with
+  any CLOS will be able to access the memory in the pseudo-locked region sin=
ce
+  the region continues to serve cache hits.
+- The contiguous region of memory loaded into the cache is exposed to
+  user-space as a character device.
+
+Cache pseudo-locking increases the probability that data will remain
+in the cache via carefully configuring the CAT feature and controlling
+application behavior. There is no guarantee that data is placed in
+cache. Instructions like INVD, WBINVD, CLFLUSH, etc. can still evict
+=E2=80=9Clocked=E2=80=9D data from cache. Power management C-states may shri=
nk or
+power off cache. Deeper C-states will automatically be restricted on
+pseudo-locked region creation.
+
+It is required that an application using a pseudo-locked region runs
+with affinity to the cores (or a subset of the cores) associated
+with the cache on which the pseudo-locked region resides. A sanity check
+within the code will not allow an application to map pseudo-locked memory
+unless it runs with affinity to cores associated with the cache on which the
+pseudo-locked region resides. The sanity check is only done during the
+initial mmap() handling, there is no enforcement afterwards and the
+application self needs to ensure it remains affine to the correct cores.
+
+Pseudo-locking is accomplished in two stages:
+
+1) During the first stage the system administrator allocates a portion
+   of cache that should be dedicated to pseudo-locking. At this time an
+   equivalent portion of memory is allocated, loaded into allocated
+   cache portion, and exposed as a character device.
+2) During the second stage a user-space application maps (mmap()) the
+   pseudo-locked memory into its address space.
+
+Cache Pseudo-Locking Interface
+------------------------------
+A pseudo-locked region is created using the resctrl interface as follows:
+
+1) Create a new resource group by creating a new directory in /sys/fs/resctr=
l.
+2) Change the new resource group's mode to "pseudo-locksetup" by writing
+   "pseudo-locksetup" to the "mode" file.
+3) Write the schemata of the pseudo-locked region to the "schemata" file. All
+   bits within the schemata should be "unused" according to the "bit_usage"
+   file.
+
+On successful pseudo-locked region creation the "mode" file will contain
+"pseudo-locked" and a new character device with the same name as the resource
+group will exist in /dev/pseudo_lock. This character device can be mmap()'ed
+by user space in order to obtain access to the pseudo-locked memory region.
+
+An example of cache pseudo-locked region creation and usage can be found bel=
ow.
+
+Cache Pseudo-Locking Debugging Interface
+----------------------------------------
+The pseudo-locking debugging interface is enabled by default (if
+CONFIG_DEBUG_FS is enabled) and can be found in /sys/kernel/debug/resctrl.
+
+There is no explicit way for the kernel to test if a provided memory
+location is present in the cache. The pseudo-locking debugging interface uses
+the tracing infrastructure to provide two ways to measure cache residency of
+the pseudo-locked region:
+
+1) Memory access latency using the pseudo_lock_mem_latency tracepoint. Data
+   from these measurements are best visualized using a hist trigger (see
+   example below). In this test the pseudo-locked region is traversed at
+   a stride of 32 bytes while hardware prefetchers and preemption
+   are disabled. This also provides a substitute visualization of cache
+   hits and misses.
+2) Cache hit and miss measurements using model specific precision counters if
+   available. Depending on the levels of cache on the system the pseudo_lock=
_l2
+   and pseudo_lock_l3 tracepoints are available.
+
+When a pseudo-locked region is created a new debugfs directory is created for
+it in debugfs as /sys/kernel/debug/resctrl/<newdir>. A single
+write-only file, pseudo_lock_measure, is present in this directory. The
+measurement of the pseudo-locked region depends on the number written to this
+debugfs file:
+
+1:
+     writing "1" to the pseudo_lock_measure file will trigger the latency
+     measurement captured in the pseudo_lock_mem_latency tracepoint. See
+     example below.
+2:
+     writing "2" to the pseudo_lock_measure file will trigger the L2 cache
+     residency (cache hits and misses) measurement captured in the
+     pseudo_lock_l2 tracepoint. See example below.
+3:
+     writing "3" to the pseudo_lock_measure file will trigger the L3 cache
+     residency (cache hits and misses) measurement captured in the
+     pseudo_lock_l3 tracepoint.
+
+All measurements are recorded with the tracing infrastructure. This requires
+the relevant tracepoints to be enabled before the measurement is triggered.
+
+Example of latency debugging interface
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+In this example a pseudo-locked region named "newlock" was created. Here is
+how we can measure the latency in cycles of reading from this region and
+visualize this data with a histogram that is available if CONFIG_HIST_TRIGGE=
RS
+is set::
+
+  # :> /sys/kernel/tracing/trace
+  # echo 'hist:keys=3Dlatency' > /sys/kernel/tracing/events/resctrl/pseudo_l=
ock_mem_latency/trigger
+  # echo 1 > /sys/kernel/tracing/events/resctrl/pseudo_lock_mem_latency/enab=
le
+  # echo 1 > /sys/kernel/debug/resctrl/newlock/pseudo_lock_measure
+  # echo 0 > /sys/kernel/tracing/events/resctrl/pseudo_lock_mem_latency/enab=
le
+  # cat /sys/kernel/tracing/events/resctrl/pseudo_lock_mem_latency/hist
+
+  # event histogram
+  #
+  # trigger info: hist:keys=3Dlatency:vals=3Dhitcount:sort=3Dhitcount:size=
=3D2048 [active]
+  #
+
+  { latency:        456 } hitcount:          1
+  { latency:         50 } hitcount:         83
+  { latency:         36 } hitcount:         96
+  { latency:         44 } hitcount:        174
+  { latency:         48 } hitcount:        195
+  { latency:         46 } hitcount:        262
+  { latency:         42 } hitcount:        693
+  { latency:         40 } hitcount:       3204
+  { latency:         38 } hitcount:       3484
+
+  Totals:
+      Hits: 8192
+      Entries: 9
+    Dropped: 0
+
+Example of cache hits/misses debugging
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+In this example a pseudo-locked region named "newlock" was created on the L2
+cache of a platform. Here is how we can obtain details of the cache hits
+and misses using the platform's precision counters.
+::
+
+  # :> /sys/kernel/tracing/trace
+  # echo 1 > /sys/kernel/tracing/events/resctrl/pseudo_lock_l2/enable
+  # echo 2 > /sys/kernel/debug/resctrl/newlock/pseudo_lock_measure
+  # echo 0 > /sys/kernel/tracing/events/resctrl/pseudo_lock_l2/enable
+  # cat /sys/kernel/tracing/trace
+
+  # tracer: nop
+  #
+  #                              _-----=3D> irqs-off
+  #                             / _----=3D> need-resched
+  #                            | / _---=3D> hardirq/softirq
+  #                            || / _--=3D> preempt-depth
+  #                            ||| /     delay
+  #           TASK-PID   CPU#  ||||    TIMESTAMP  FUNCTION
+  #              | |       |   ||||       |         |
+  pseudo_lock_mea-1672  [002] ....  3132.860500: pseudo_lock_l2: hits=3D4097=
 miss=3D0
+
+
+Examples for RDT allocation usage
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+1) Example 1
+
+On a two socket machine (one L3 cache per socket) with just four bits
+for cache bit masks, minimum b/w of 10% with a memory bandwidth
+granularity of 10%.
+::
+
+  # mount -t resctrl resctrl /sys/fs/resctrl
+  # cd /sys/fs/resctrl
+  # mkdir p0 p1
+  # echo "L3:0=3D3;1=3Dc\nMB:0=3D50;1=3D50" > /sys/fs/resctrl/p0/schemata
+  # echo "L3:0=3D3;1=3D3\nMB:0=3D50;1=3D50" > /sys/fs/resctrl/p1/schemata
+
+The default resource group is unmodified, so we have access to all parts
+of all caches (its schemata file reads "L3:0=3Df;1=3Df").
+
+Tasks that are under the control of group "p0" may only allocate from the
+"lower" 50% on cache ID 0, and the "upper" 50% of cache ID 1.
+Tasks in group "p1" use the "lower" 50% of cache on both sockets.
+
+Similarly, tasks that are under the control of group "p0" may use a
+maximum memory b/w of 50% on socket0 and 50% on socket 1.
+Tasks in group "p1" may also use 50% memory b/w on both sockets.
+Note that unlike cache masks, memory b/w cannot specify whether these
+allocations can overlap or not. The allocations specifies the maximum
+b/w that the group may be able to use and the system admin can configure
+the b/w accordingly.
+
+If resctrl is using the software controller (mba_sc) then user can enter the
+max b/w in MB rather than the percentage values.
+::
+
+  # echo "L3:0=3D3;1=3Dc\nMB:0=3D1024;1=3D500" > /sys/fs/resctrl/p0/schemata
+  # echo "L3:0=3D3;1=3D3\nMB:0=3D1024;1=3D500" > /sys/fs/resctrl/p1/schemata
+
+In the above example the tasks in "p1" and "p0" on socket 0 would use a max =
b/w
+of 1024MB where as on socket 1 they would use 500MB.
+
+2) Example 2
+
+Again two sockets, but this time with a more realistic 20-bit mask.
+
+Two real time tasks pid=3D1234 running on processor 0 and pid=3D5678 running=
 on
+processor 1 on socket 0 on a 2-socket and dual core machine. To avoid noisy
+neighbors, each of the two real-time tasks exclusively occupies one quarter
+of L3 cache on socket 0.
+::
+
+  # mount -t resctrl resctrl /sys/fs/resctrl
+  # cd /sys/fs/resctrl
+
+First we reset the schemata for the default group so that the "upper"
+50% of the L3 cache on socket 0 and 50% of memory b/w cannot be used by
+ordinary tasks::
+
+  # echo "L3:0=3D3ff;1=3Dfffff\nMB:0=3D50;1=3D100" > schemata
+
+Next we make a resource group for our first real time task and give
+it access to the "top" 25% of the cache on socket 0.
+::
+
+  # mkdir p0
+  # echo "L3:0=3Df8000;1=3Dfffff" > p0/schemata
+
+Finally we move our first real time task into this resource group. We
+also use taskset(1) to ensure the task always runs on a dedicated CPU
+on socket 0. Most uses of resource groups will also constrain which
+processors tasks run on.
+::
+
+  # echo 1234 > p0/tasks
+  # taskset -cp 1 1234
+
+Ditto for the second real time task (with the remaining 25% of cache)::
+
+  # mkdir p1
+  # echo "L3:0=3D7c00;1=3Dfffff" > p1/schemata
+  # echo 5678 > p1/tasks
+  # taskset -cp 2 5678
+
+For the same 2 socket system with memory b/w resource and CAT L3 the
+schemata would look like(Assume min_bandwidth 10 and bandwidth_gran is
+10):
+
+For our first real time task this would request 20% memory b/w on socket 0.
+::
+
+  # echo -e "L3:0=3Df8000;1=3Dfffff\nMB:0=3D20;1=3D100" > p0/schemata
+
+For our second real time task this would request an other 20% memory b/w
+on socket 0.
+::
+
+  # echo -e "L3:0=3Df8000;1=3Dfffff\nMB:0=3D20;1=3D100" > p0/schemata
+
+3) Example 3
+
+A single socket system which has real-time tasks running on core 4-7 and
+non real-time workload assigned to core 0-3. The real-time tasks share text
+and data, so a per task association is not required and due to interaction
+with the kernel it's desired that the kernel on these cores shares L3 with
+the tasks.
+::
+
+  # mount -t resctrl resctrl /sys/fs/resctrl
+  # cd /sys/fs/resctrl
+
+First we reset the schemata for the default group so that the "upper"
+50% of the L3 cache on socket 0, and 50% of memory bandwidth on socket 0
+cannot be used by ordinary tasks::
+
+  # echo "L3:0=3D3ff\nMB:0=3D50" > schemata
+
+Next we make a resource group for our real time cores and give it access
+to the "top" 50% of the cache on socket 0 and 50% of memory bandwidth on
+socket 0.
+::
+
+  # mkdir p0
+  # echo "L3:0=3Dffc00\nMB:0=3D50" > p0/schemata
+
+Finally we move core 4-7 over to the new group and make sure that the
+kernel and the tasks running there get 50% of the cache. They should
+also get 50% of memory bandwidth assuming that the cores 4-7 are SMT
+siblings and only the real time threads are scheduled on the cores 4-7.
+::
+
+  # echo F0 > p0/cpus
+
+4) Example 4
+
+The resource groups in previous examples were all in the default "shareable"
+mode allowing sharing of their cache allocations. If one resource group
+configures a cache allocation then nothing prevents another resource group
+to overlap with that allocation.
+
+In this example a new exclusive resource group will be created on a L2 CAT
+system with two L2 cache instances that can be configured with an 8-bit
+capacity bitmask. The new exclusive resource group will be configured to use
+25% of each cache instance.
+::
+
+  # mount -t resctrl resctrl /sys/fs/resctrl/
+  # cd /sys/fs/resctrl
+
+First, we observe that the default group is configured to allocate to all L2
+cache::
+
+  # cat schemata
+  L2:0=3Dff;1=3Dff
+
+We could attempt to create the new resource group at this point, but it will
+fail because of the overlap with the schemata of the default group::
+
+  # mkdir p0
+  # echo 'L2:0=3D0x3;1=3D0x3' > p0/schemata
+  # cat p0/mode
+  shareable
+  # echo exclusive > p0/mode
+  -sh: echo: write error: Invalid argument
+  # cat info/last_cmd_status
+  schemata overlaps
+
+To ensure that there is no overlap with another resource group the default
+resource group's schemata has to change, making it possible for the new
+resource group to become exclusive.
+::
+
+  # echo 'L2:0=3D0xfc;1=3D0xfc' > schemata
+  # echo exclusive > p0/mode
+  # grep . p0/*
+  p0/cpus:0
+  p0/mode:exclusive
+  p0/schemata:L2:0=3D03;1=3D03
+  p0/size:L2:0=3D262144;1=3D262144
+
+A new resource group will on creation not overlap with an exclusive resource
+group::
+
+  # mkdir p1
+  # grep . p1/*
+  p1/cpus:0
+  p1/mode:shareable
+  p1/schemata:L2:0=3Dfc;1=3Dfc
+  p1/size:L2:0=3D786432;1=3D786432
+
+The bit_usage will reflect how the cache is used::
+
+  # cat info/L2/bit_usage
+  0=3DSSSSSSEE;1=3DSSSSSSEE
+
+A resource group cannot be forced to overlap with an exclusive resource grou=
p::
+
+  # echo 'L2:0=3D0x1;1=3D0x1' > p1/schemata
+  -sh: echo: write error: Invalid argument
+  # cat info/last_cmd_status
+  overlaps with exclusive group
+
+Example of Cache Pseudo-Locking
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+Lock portion of L2 cache from cache id 1 using CBM 0x3. Pseudo-locked
+region is exposed at /dev/pseudo_lock/newlock that can be provided to
+application for argument to mmap().
+::
+
+  # mount -t resctrl resctrl /sys/fs/resctrl/
+  # cd /sys/fs/resctrl
+
+Ensure that there are bits available that can be pseudo-locked, since only
+unused bits can be pseudo-locked the bits to be pseudo-locked needs to be
+removed from the default resource group's schemata::
+
+  # cat info/L2/bit_usage
+  0=3DSSSSSSSS;1=3DSSSSSSSS
+  # echo 'L2:1=3D0xfc' > schemata
+  # cat info/L2/bit_usage
+  0=3DSSSSSSSS;1=3DSSSSSS00
+
+Create a new resource group that will be associated with the pseudo-locked
+region, indicate that it will be used for a pseudo-locked region, and
+configure the requested pseudo-locked region capacity bitmask::
+
+  # mkdir newlock
+  # echo pseudo-locksetup > newlock/mode
+  # echo 'L2:1=3D0x3' > newlock/schemata
+
+On success the resource group's mode will change to pseudo-locked, the
+bit_usage will reflect the pseudo-locked region, and the character device
+exposing the pseudo-locked region will exist::
+
+  # cat newlock/mode
+  pseudo-locked
+  # cat info/L2/bit_usage
+  0=3DSSSSSSSS;1=3DSSSSSSPP
+  # ls -l /dev/pseudo_lock/newlock
+  crw------- 1 root root 243, 0 Apr  3 05:01 /dev/pseudo_lock/newlock
+
+::
+
+  /*
+  * Example code to access one page of pseudo-locked cache region
+  * from user space.
+  */
+  #define _GNU_SOURCE
+  #include <fcntl.h>
+  #include <sched.h>
+  #include <stdio.h>
+  #include <stdlib.h>
+  #include <unistd.h>
+  #include <sys/mman.h>
+
+  /*
+  * It is required that the application runs with affinity to only
+  * cores associated with the pseudo-locked region. Here the cpu
+  * is hardcoded for convenience of example.
+  */
+  static int cpuid =3D 2;
+
+  int main(int argc, char *argv[])
+  {
+    cpu_set_t cpuset;
+    long page_size;
+    void *mapping;
+    int dev_fd;
+    int ret;
+
+    page_size =3D sysconf(_SC_PAGESIZE);
+
+    CPU_ZERO(&cpuset);
+    CPU_SET(cpuid, &cpuset);
+    ret =3D sched_setaffinity(0, sizeof(cpuset), &cpuset);
+    if (ret < 0) {
+      perror("sched_setaffinity");
+      exit(EXIT_FAILURE);
+    }
+
+    dev_fd =3D open("/dev/pseudo_lock/newlock", O_RDWR);
+    if (dev_fd < 0) {
+      perror("open");
+      exit(EXIT_FAILURE);
+    }
+
+    mapping =3D mmap(0, page_size, PROT_READ | PROT_WRITE, MAP_SHARED,
+            dev_fd, 0);
+    if (mapping =3D=3D MAP_FAILED) {
+      perror("mmap");
+      close(dev_fd);
+      exit(EXIT_FAILURE);
+    }
+
+    /* Application interacts with pseudo-locked memory @mapping */
+
+    ret =3D munmap(mapping, page_size);
+    if (ret < 0) {
+      perror("munmap");
+      close(dev_fd);
+      exit(EXIT_FAILURE);
+    }
+
+    close(dev_fd);
+    exit(EXIT_SUCCESS);
+  }
+
+Locking between applications
+----------------------------
+
+Certain operations on the resctrl filesystem, composed of read/writes
+to/from multiple files, must be atomic.
+
+As an example, the allocation of an exclusive reservation of L3 cache
+involves:
+
+  1. Read the cbmmasks from each directory or the per-resource "bit_usage"
+  2. Find a contiguous set of bits in the global CBM bitmask that is clear
+     in any of the directory cbmmasks
+  3. Create a new directory
+  4. Set the bits found in step 2 to the new directory "schemata" file
+
+If two applications attempt to allocate space concurrently then they can
+end up allocating the same bits so the reservations are shared instead of
+exclusive.
+
+To coordinate atomic operations on the resctrlfs and to avoid the problem
+above, the following locking procedure is recommended:
+
+Locking is based on flock, which is available in libc and also as a shell
+script command
+
+Write lock:
+
+ A) Take flock(LOCK_EX) on /sys/fs/resctrl
+ B) Read/write the directory structure.
+ C) funlock
+
+Read lock:
+
+ A) Take flock(LOCK_SH) on /sys/fs/resctrl
+ B) If success read the directory structure.
+ C) funlock
+
+Example with bash::
+
+  # Atomically read directory structure
+  $ flock -s /sys/fs/resctrl/ find /sys/fs/resctrl
+
+  # Read directory contents and create new subdirectory
+
+  $ cat create-dir.sh
+  find /sys/fs/resctrl/ > output.txt
+  mask =3D function-of(output.txt)
+  mkdir /sys/fs/resctrl/newres/
+  echo mask > /sys/fs/resctrl/newres/schemata
+
+  $ flock /sys/fs/resctrl/ ./create-dir.sh
+
+Example with C::
+
+  /*
+  * Example code do take advisory locks
+  * before accessing resctrl filesystem
+  */
+  #include <sys/file.h>
+  #include <stdlib.h>
+
+  void resctrl_take_shared_lock(int fd)
+  {
+    int ret;
+
+    /* take shared lock on resctrl filesystem */
+    ret =3D flock(fd, LOCK_SH);
+    if (ret) {
+      perror("flock");
+      exit(-1);
+    }
+  }
+
+  void resctrl_take_exclusive_lock(int fd)
+  {
+    int ret;
+
+    /* release lock on resctrl filesystem */
+    ret =3D flock(fd, LOCK_EX);
+    if (ret) {
+      perror("flock");
+      exit(-1);
+    }
+  }
+
+  void resctrl_release_lock(int fd)
+  {
+    int ret;
+
+    /* take shared lock on resctrl filesystem */
+    ret =3D flock(fd, LOCK_UN);
+    if (ret) {
+      perror("flock");
+      exit(-1);
+    }
+  }
+
+  void main(void)
+  {
+    int fd, ret;
+
+    fd =3D open("/sys/fs/resctrl", O_DIRECTORY);
+    if (fd =3D=3D -1) {
+      perror("open");
+      exit(-1);
+    }
+    resctrl_take_shared_lock(fd);
+    /* code to read directory contents */
+    resctrl_release_lock(fd);
+
+    resctrl_take_exclusive_lock(fd);
+    /* code to read and write directory contents */
+    resctrl_release_lock(fd);
+  }
+
+Examples for RDT Monitoring along with allocation usage
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
+Reading monitored data
+----------------------
+Reading an event file (for ex: mon_data/mon_L3_00/llc_occupancy) would
+show the current snapshot of LLC occupancy of the corresponding MON
+group or CTRL_MON group.
+
+
+Example 1 (Monitor CTRL_MON group and subset of tasks in CTRL_MON group)
+------------------------------------------------------------------------
+On a two socket machine (one L3 cache per socket) with just four bits
+for cache bit masks::
+
+  # mount -t resctrl resctrl /sys/fs/resctrl
+  # cd /sys/fs/resctrl
+  # mkdir p0 p1
+  # echo "L3:0=3D3;1=3Dc" > /sys/fs/resctrl/p0/schemata
+  # echo "L3:0=3D3;1=3D3" > /sys/fs/resctrl/p1/schemata
+  # echo 5678 > p1/tasks
+  # echo 5679 > p1/tasks
+
+The default resource group is unmodified, so we have access to all parts
+of all caches (its schemata file reads "L3:0=3Df;1=3Df").
+
+Tasks that are under the control of group "p0" may only allocate from the
+"lower" 50% on cache ID 0, and the "upper" 50% of cache ID 1.
+Tasks in group "p1" use the "lower" 50% of cache on both sockets.
+
+Create monitor groups and assign a subset of tasks to each monitor group.
+::
+
+  # cd /sys/fs/resctrl/p1/mon_groups
+  # mkdir m11 m12
+  # echo 5678 > m11/tasks
+  # echo 5679 > m12/tasks
+
+fetch data (data shown in bytes)
+::
+
+  # cat m11/mon_data/mon_L3_00/llc_occupancy
+  16234000
+  # cat m11/mon_data/mon_L3_01/llc_occupancy
+  14789000
+  # cat m12/mon_data/mon_L3_00/llc_occupancy
+  16789000
+
+The parent ctrl_mon group shows the aggregated data.
+::
+
+  # cat /sys/fs/resctrl/p1/mon_data/mon_l3_00/llc_occupancy
+  31234000
+
+Example 2 (Monitor a task from its creation)
+--------------------------------------------
+On a two socket machine (one L3 cache per socket)::
+
+  # mount -t resctrl resctrl /sys/fs/resctrl
+  # cd /sys/fs/resctrl
+  # mkdir p0 p1
+
+An RMID is allocated to the group once its created and hence the <cmd>
+below is monitored from its creation.
+::
+
+  # echo $$ > /sys/fs/resctrl/p1/tasks
+  # <cmd>
+
+Fetch the data::
+
+  # cat /sys/fs/resctrl/p1/mon_data/mon_l3_00/llc_occupancy
+  31789000
+
+Example 3 (Monitor without CAT support or before creating CAT groups)
+---------------------------------------------------------------------
+
+Assume a system like HSW has only CQM and no CAT support. In this case
+the resctrl will still mount but cannot create CTRL_MON directories.
+But user can create different MON groups within the root group thereby
+able to monitor all tasks including kernel threads.
+
+This can also be used to profile jobs cache size footprint before being
+able to allocate them to different allocation groups.
+::
+
+  # mount -t resctrl resctrl /sys/fs/resctrl
+  # cd /sys/fs/resctrl
+  # mkdir mon_groups/m01
+  # mkdir mon_groups/m02
+
+  # echo 3478 > /sys/fs/resctrl/mon_groups/m01/tasks
+  # echo 2467 > /sys/fs/resctrl/mon_groups/m02/tasks
+
+Monitor the groups separately and also get per domain data. From the
+below its apparent that the tasks are mostly doing work on
+domain(socket) 0.
+::
+
+  # cat /sys/fs/resctrl/mon_groups/m01/mon_L3_00/llc_occupancy
+  31234000
+  # cat /sys/fs/resctrl/mon_groups/m01/mon_L3_01/llc_occupancy
+  34555
+  # cat /sys/fs/resctrl/mon_groups/m02/mon_L3_00/llc_occupancy
+  31234000
+  # cat /sys/fs/resctrl/mon_groups/m02/mon_L3_01/llc_occupancy
+  32789
+
+
+Example 4 (Monitor real time tasks)
+-----------------------------------
+
+A single socket system which has real time tasks running on cores 4-7
+and non real time tasks on other cpus. We want to monitor the cache
+occupancy of the real time threads on these cores.
+::
+
+  # mount -t resctrl resctrl /sys/fs/resctrl
+  # cd /sys/fs/resctrl
+  # mkdir p1
+
+Move the cpus 4-7 over to p1::
+
+  # echo f0 > p1/cpus
+
+View the llc occupancy snapshot::
+
+  # cat /sys/fs/resctrl/p1/mon_data/mon_L3_00/llc_occupancy
+  11234000
+
+Intel RDT Errata
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Intel MBM Counters May Report System Memory Bandwidth Incorrectly
+-----------------------------------------------------------------
+
+Errata SKX99 for Skylake server and BDF102 for Broadwell server.
+
+Problem: Intel Memory Bandwidth Monitoring (MBM) counters track metrics
+according to the assigned Resource Monitor ID (RMID) for that logical
+core. The IA32_QM_CTR register (MSR 0xC8E), used to report these
+metrics, may report incorrect system bandwidth for certain RMID values.
+
+Implication: Due to the errata, system memory bandwidth may not match
+what is reported.
+
+Workaround: MBM total and local readings are corrected according to the
+following correction factor table:
+
++---------------+---------------+---------------+-----------------+
+|core count	|rmid count	|rmid threshold	|correction factor|
++---------------+---------------+---------------+-----------------+
+|1		|8		|0		|1.000000	  |
++---------------+---------------+---------------+-----------------+
+|2		|16		|0		|1.000000	  |
++---------------+---------------+---------------+-----------------+
+|3		|24		|15		|0.969650	  |
++---------------+---------------+---------------+-----------------+
+|4		|32		|0		|1.000000	  |
++---------------+---------------+---------------+-----------------+
+|6		|48		|31		|0.969650	  |
++---------------+---------------+---------------+-----------------+
+|7		|56		|47		|1.142857	  |
++---------------+---------------+---------------+-----------------+
+|8		|64		|0		|1.000000	  |
++---------------+---------------+---------------+-----------------+
+|9		|72		|63		|1.185115	  |
++---------------+---------------+---------------+-----------------+
+|10		|80		|63		|1.066553	  |
++---------------+---------------+---------------+-----------------+
+|11		|88		|79		|1.454545	  |
++---------------+---------------+---------------+-----------------+
+|12		|96		|0		|1.000000	  |
++---------------+---------------+---------------+-----------------+
+|13		|104		|95		|1.230769	  |
++---------------+---------------+---------------+-----------------+
+|14		|112		|95		|1.142857	  |
++---------------+---------------+---------------+-----------------+
+|15		|120		|95		|1.066667	  |
++---------------+---------------+---------------+-----------------+
+|16		|128		|0		|1.000000	  |
++---------------+---------------+---------------+-----------------+
+|17		|136		|127		|1.254863	  |
++---------------+---------------+---------------+-----------------+
+|18		|144		|127		|1.185255	  |
++---------------+---------------+---------------+-----------------+
+|19		|152		|0		|1.000000	  |
++---------------+---------------+---------------+-----------------+
+|20		|160		|127		|1.066667	  |
++---------------+---------------+---------------+-----------------+
+|21		|168		|0		|1.000000	  |
++---------------+---------------+---------------+-----------------+
+|22		|176		|159		|1.454334	  |
++---------------+---------------+---------------+-----------------+
+|23		|184		|0		|1.000000	  |
++---------------+---------------+---------------+-----------------+
+|24		|192		|127		|0.969744	  |
++---------------+---------------+---------------+-----------------+
+|25		|200		|191		|1.280246	  |
++---------------+---------------+---------------+-----------------+
+|26		|208		|191		|1.230921	  |
++---------------+---------------+---------------+-----------------+
+|27		|216		|0		|1.000000	  |
++---------------+---------------+---------------+-----------------+
+|28		|224		|191		|1.143118	  |
++---------------+---------------+---------------+-----------------+
+
+If rmid > rmid threshold, MBM total and local values should be multiplied
+by the correction factor.
+
+See:
+
+1. Erratum SKX99 in Intel Xeon Processor Scalable Family Specification Updat=
e:
+http://web.archive.org/web/20200716124958/https://www.intel.com/content/www/=
us/en/processors/xeon/scalable/xeon-scalable-spec-update.html
+
+2. Erratum BDF102 in Intel Xeon E5-2600 v4 Processor Product Family Specific=
ation Update:
+http://web.archive.org/web/20191125200531/https://www.intel.com/content/dam/=
www/public/us/en/documents/specification-updates/xeon-e5-v4-spec-update.pdf
+
+3. The errata in Intel Resource Director Technology (Intel RDT) on 2nd Gener=
ation Intel Xeon Scalable Processors Reference Manual:
+https://software.intel.com/content/www/us/en/develop/articles/intel-resource=
-director-technology-rdt-reference-manual.html
+
+for further information.
diff --git a/MAINTAINERS b/MAINTAINERS
index ed96cc7..c56ab7d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20424,7 +20424,7 @@ M:	Tony Luck <tony.luck@intel.com>
 M:	Reinette Chatre <reinette.chatre@intel.com>
 L:	linux-kernel@vger.kernel.org
 S:	Supported
-F:	Documentation/arch/x86/resctrl*
+F:	Documentation/filesystems/resctrl.rst
 F:	arch/x86/include/asm/resctrl.h
 F:	arch/x86/kernel/cpu/resctrl/
 F:	fs/resctrl/
diff --git a/arch/x86/kernel/cpu/resctrl/Makefile b/arch/x86/kernel/cpu/resct=
rl/Makefile
index 909be78..d8a04b1 100644
--- a/arch/x86/kernel/cpu/resctrl/Makefile
+++ b/arch/x86/kernel/cpu/resctrl/Makefile
@@ -5,4 +5,3 @@ obj-$(CONFIG_RESCTRL_FS_PSEUDO_LOCK)	+=3D pseudo_lock.o
=20
 # To allow define_trace.h's recursive include:
 CFLAGS_pseudo_lock.o =3D -I$(src)
-CFLAGS_monitor.o =3D -I$(src)
diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/=
resctrl/ctrlmondata.c
index 110b534..1189c0d 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -16,277 +16,9 @@
 #define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
=20
 #include <linux/cpu.h>
-#include <linux/kernfs.h>
-#include <linux/seq_file.h>
-#include <linux/slab.h>
-#include <linux/tick.h>
=20
 #include "internal.h"
=20
-struct rdt_parse_data {
-	struct rdtgroup		*rdtgrp;
-	char			*buf;
-};
-
-typedef int (ctrlval_parser_t)(struct rdt_parse_data *data,
-			       struct resctrl_schema *s,
-			       struct rdt_ctrl_domain *d);
-
-/*
- * Check whether MBA bandwidth percentage value is correct. The value is
- * checked against the minimum and max bandwidth values specified by the
- * hardware. The allocated bandwidth percentage is rounded to the next
- * control step available on the hardware.
- */
-static bool bw_validate(char *buf, u32 *data, struct rdt_resource *r)
-{
-	int ret;
-	u32 bw;
-
-	/*
-	 * Only linear delay values is supported for current Intel SKUs.
-	 */
-	if (!r->membw.delay_linear && r->membw.arch_needs_linear) {
-		rdt_last_cmd_puts("No support for non-linear MB domains\n");
-		return false;
-	}
-
-	ret =3D kstrtou32(buf, 10, &bw);
-	if (ret) {
-		rdt_last_cmd_printf("Invalid MB value %s\n", buf);
-		return false;
-	}
-
-	/* Nothing else to do if software controller is enabled. */
-	if (is_mba_sc(r)) {
-		*data =3D bw;
-		return true;
-	}
-
-	if (bw < r->membw.min_bw || bw > r->membw.max_bw) {
-		rdt_last_cmd_printf("MB value %u out of range [%d,%d]\n",
-				    bw, r->membw.min_bw, r->membw.max_bw);
-		return false;
-	}
-
-	*data =3D roundup(bw, (unsigned long)r->membw.bw_gran);
-	return true;
-}
-
-static int parse_bw(struct rdt_parse_data *data, struct resctrl_schema *s,
-		    struct rdt_ctrl_domain *d)
-{
-	struct resctrl_staged_config *cfg;
-	u32 closid =3D data->rdtgrp->closid;
-	struct rdt_resource *r =3D s->res;
-	u32 bw_val;
-
-	cfg =3D &d->staged_config[s->conf_type];
-	if (cfg->have_new_ctrl) {
-		rdt_last_cmd_printf("Duplicate domain %d\n", d->hdr.id);
-		return -EINVAL;
-	}
-
-	if (!bw_validate(data->buf, &bw_val, r))
-		return -EINVAL;
-
-	if (is_mba_sc(r)) {
-		d->mbps_val[closid] =3D bw_val;
-		return 0;
-	}
-
-	cfg->new_ctrl =3D bw_val;
-	cfg->have_new_ctrl =3D true;
-
-	return 0;
-}
-
-/*
- * Check whether a cache bit mask is valid.
- * On Intel CPUs, non-contiguous 1s value support is indicated by CPUID:
- *   - CPUID.0x10.1:ECX[3]: L3 non-contiguous 1s value supported if 1
- *   - CPUID.0x10.2:ECX[3]: L2 non-contiguous 1s value supported if 1
- *
- * Haswell does not support a non-contiguous 1s value and additionally
- * requires at least two bits set.
- * AMD allows non-contiguous bitmasks.
- */
-static bool cbm_validate(char *buf, u32 *data, struct rdt_resource *r)
-{
-	u32 supported_bits =3D BIT_MASK(r->cache.cbm_len) - 1;
-	unsigned int cbm_len =3D r->cache.cbm_len;
-	unsigned long first_bit, zero_bit, val;
-	int ret;
-
-	ret =3D kstrtoul(buf, 16, &val);
-	if (ret) {
-		rdt_last_cmd_printf("Non-hex character in the mask %s\n", buf);
-		return false;
-	}
-
-	if ((r->cache.min_cbm_bits > 0 && val =3D=3D 0) || val > supported_bits) {
-		rdt_last_cmd_puts("Mask out of range\n");
-		return false;
-	}
-
-	first_bit =3D find_first_bit(&val, cbm_len);
-	zero_bit =3D find_next_zero_bit(&val, cbm_len, first_bit);
-
-	/* Are non-contiguous bitmasks allowed? */
-	if (!r->cache.arch_has_sparse_bitmasks &&
-	    (find_next_bit(&val, cbm_len, zero_bit) < cbm_len)) {
-		rdt_last_cmd_printf("The mask %lx has non-consecutive 1-bits\n", val);
-		return false;
-	}
-
-	if ((zero_bit - first_bit) < r->cache.min_cbm_bits) {
-		rdt_last_cmd_printf("Need at least %d bits in the mask\n",
-				    r->cache.min_cbm_bits);
-		return false;
-	}
-
-	*data =3D val;
-	return true;
-}
-
-/*
- * Read one cache bit mask (hex). Check that it is valid for the current
- * resource type.
- */
-static int parse_cbm(struct rdt_parse_data *data, struct resctrl_schema *s,
-		     struct rdt_ctrl_domain *d)
-{
-	struct rdtgroup *rdtgrp =3D data->rdtgrp;
-	struct resctrl_staged_config *cfg;
-	struct rdt_resource *r =3D s->res;
-	u32 cbm_val;
-
-	cfg =3D &d->staged_config[s->conf_type];
-	if (cfg->have_new_ctrl) {
-		rdt_last_cmd_printf("Duplicate domain %d\n", d->hdr.id);
-		return -EINVAL;
-	}
-
-	/*
-	 * Cannot set up more than one pseudo-locked region in a cache
-	 * hierarchy.
-	 */
-	if (rdtgrp->mode =3D=3D RDT_MODE_PSEUDO_LOCKSETUP &&
-	    rdtgroup_pseudo_locked_in_hierarchy(d)) {
-		rdt_last_cmd_puts("Pseudo-locked region in hierarchy\n");
-		return -EINVAL;
-	}
-
-	if (!cbm_validate(data->buf, &cbm_val, r))
-		return -EINVAL;
-
-	if ((rdtgrp->mode =3D=3D RDT_MODE_EXCLUSIVE ||
-	     rdtgrp->mode =3D=3D RDT_MODE_SHAREABLE) &&
-	    rdtgroup_cbm_overlaps_pseudo_locked(d, cbm_val)) {
-		rdt_last_cmd_puts("CBM overlaps with pseudo-locked region\n");
-		return -EINVAL;
-	}
-
-	/*
-	 * The CBM may not overlap with the CBM of another closid if
-	 * either is exclusive.
-	 */
-	if (rdtgroup_cbm_overlaps(s, d, cbm_val, rdtgrp->closid, true)) {
-		rdt_last_cmd_puts("Overlaps with exclusive group\n");
-		return -EINVAL;
-	}
-
-	if (rdtgroup_cbm_overlaps(s, d, cbm_val, rdtgrp->closid, false)) {
-		if (rdtgrp->mode =3D=3D RDT_MODE_EXCLUSIVE ||
-		    rdtgrp->mode =3D=3D RDT_MODE_PSEUDO_LOCKSETUP) {
-			rdt_last_cmd_puts("Overlaps with other group\n");
-			return -EINVAL;
-		}
-	}
-
-	cfg->new_ctrl =3D cbm_val;
-	cfg->have_new_ctrl =3D true;
-
-	return 0;
-}
-
-/*
- * For each domain in this resource we expect to find a series of:
- *	id=3Dmask
- * separated by ";". The "id" is in decimal, and must match one of
- * the "id"s for this resource.
- */
-static int parse_line(char *line, struct resctrl_schema *s,
-		      struct rdtgroup *rdtgrp)
-{
-	enum resctrl_conf_type t =3D s->conf_type;
-	ctrlval_parser_t *parse_ctrlval =3D NULL;
-	struct resctrl_staged_config *cfg;
-	struct rdt_resource *r =3D s->res;
-	struct rdt_parse_data data;
-	struct rdt_ctrl_domain *d;
-	char *dom =3D NULL, *id;
-	unsigned long dom_id;
-
-	/* Walking r->domains, ensure it can't race with cpuhp */
-	lockdep_assert_cpus_held();
-
-	switch (r->schema_fmt) {
-	case RESCTRL_SCHEMA_BITMAP:
-		parse_ctrlval =3D &parse_cbm;
-		break;
-	case RESCTRL_SCHEMA_RANGE:
-		parse_ctrlval =3D &parse_bw;
-		break;
-	}
-
-	if (WARN_ON_ONCE(!parse_ctrlval))
-		return -EINVAL;
-
-	if (rdtgrp->mode =3D=3D RDT_MODE_PSEUDO_LOCKSETUP &&
-	    (r->rid =3D=3D RDT_RESOURCE_MBA || r->rid =3D=3D RDT_RESOURCE_SMBA)) {
-		rdt_last_cmd_puts("Cannot pseudo-lock MBA resource\n");
-		return -EINVAL;
-	}
-
-next:
-	if (!line || line[0] =3D=3D '\0')
-		return 0;
-	dom =3D strsep(&line, ";");
-	id =3D strsep(&dom, "=3D");
-	if (!dom || kstrtoul(id, 10, &dom_id)) {
-		rdt_last_cmd_puts("Missing '=3D' or non-numeric domain\n");
-		return -EINVAL;
-	}
-	dom =3D strim(dom);
-	list_for_each_entry(d, &r->ctrl_domains, hdr.list) {
-		if (d->hdr.id =3D=3D dom_id) {
-			data.buf =3D dom;
-			data.rdtgrp =3D rdtgrp;
-			if (parse_ctrlval(&data, s, d))
-				return -EINVAL;
-			if (rdtgrp->mode =3D=3D  RDT_MODE_PSEUDO_LOCKSETUP) {
-				cfg =3D &d->staged_config[t];
-				/*
-				 * In pseudo-locking setup mode and just
-				 * parsed a valid CBM that should be
-				 * pseudo-locked. Only one locked region per
-				 * resource group and domain so just do
-				 * the required initialization for single
-				 * region and return.
-				 */
-				rdtgrp->plr->s =3D s;
-				rdtgrp->plr->d =3D d;
-				rdtgrp->plr->cbm =3D cfg->new_ctrl;
-				d->plr =3D rdtgrp->plr;
-				return 0;
-			}
-			goto next;
-		}
-	}
-	return -EINVAL;
-}
-
 int resctrl_arch_update_one(struct rdt_resource *r, struct rdt_ctrl_domain *=
d,
 			    u32 closid, enum resctrl_conf_type t, u32 cfg_val)
 {
@@ -351,100 +83,6 @@ int resctrl_arch_update_domains(struct rdt_resource *r, =
u32 closid)
 	return 0;
 }
=20
-static int rdtgroup_parse_resource(char *resname, char *tok,
-				   struct rdtgroup *rdtgrp)
-{
-	struct resctrl_schema *s;
-
-	list_for_each_entry(s, &resctrl_schema_all, list) {
-		if (!strcmp(resname, s->name) && rdtgrp->closid < s->num_closid)
-			return parse_line(tok, s, rdtgrp);
-	}
-	rdt_last_cmd_printf("Unknown or unsupported resource name '%s'\n", resname);
-	return -EINVAL;
-}
-
-ssize_t rdtgroup_schemata_write(struct kernfs_open_file *of,
-				char *buf, size_t nbytes, loff_t off)
-{
-	struct resctrl_schema *s;
-	struct rdtgroup *rdtgrp;
-	struct rdt_resource *r;
-	char *tok, *resname;
-	int ret =3D 0;
-
-	/* Valid input requires a trailing newline */
-	if (nbytes =3D=3D 0 || buf[nbytes - 1] !=3D '\n')
-		return -EINVAL;
-	buf[nbytes - 1] =3D '\0';
-
-	rdtgrp =3D rdtgroup_kn_lock_live(of->kn);
-	if (!rdtgrp) {
-		rdtgroup_kn_unlock(of->kn);
-		return -ENOENT;
-	}
-	rdt_last_cmd_clear();
-
-	/*
-	 * No changes to pseudo-locked region allowed. It has to be removed
-	 * and re-created instead.
-	 */
-	if (rdtgrp->mode =3D=3D RDT_MODE_PSEUDO_LOCKED) {
-		ret =3D -EINVAL;
-		rdt_last_cmd_puts("Resource group is pseudo-locked\n");
-		goto out;
-	}
-
-	rdt_staged_configs_clear();
-
-	while ((tok =3D strsep(&buf, "\n")) !=3D NULL) {
-		resname =3D strim(strsep(&tok, ":"));
-		if (!tok) {
-			rdt_last_cmd_puts("Missing ':'\n");
-			ret =3D -EINVAL;
-			goto out;
-		}
-		if (tok[0] =3D=3D '\0') {
-			rdt_last_cmd_printf("Missing '%s' value\n", resname);
-			ret =3D -EINVAL;
-			goto out;
-		}
-		ret =3D rdtgroup_parse_resource(resname, tok, rdtgrp);
-		if (ret)
-			goto out;
-	}
-
-	list_for_each_entry(s, &resctrl_schema_all, list) {
-		r =3D s->res;
-
-		/*
-		 * Writes to mba_sc resources update the software controller,
-		 * not the control MSR.
-		 */
-		if (is_mba_sc(r))
-			continue;
-
-		ret =3D resctrl_arch_update_domains(r, rdtgrp->closid);
-		if (ret)
-			goto out;
-	}
-
-	if (rdtgrp->mode =3D=3D RDT_MODE_PSEUDO_LOCKSETUP) {
-		/*
-		 * If pseudo-locking fails we keep the resource group in
-		 * mode RDT_MODE_PSEUDO_LOCKSETUP with its class of service
-		 * active and updated for just the domain the pseudo-locked
-		 * region was requested for.
-		 */
-		ret =3D rdtgroup_pseudo_lock_create(rdtgrp);
-	}
-
-out:
-	rdt_staged_configs_clear();
-	rdtgroup_kn_unlock(of->kn);
-	return ret ?: nbytes;
-}
-
 u32 resctrl_arch_get_config(struct rdt_resource *r, struct rdt_ctrl_domain *=
d,
 			    u32 closid, enum resctrl_conf_type type)
 {
@@ -453,282 +91,3 @@ u32 resctrl_arch_get_config(struct rdt_resource *r, stru=
ct rdt_ctrl_domain *d,
=20
 	return hw_dom->ctrl_val[idx];
 }
-
-static void show_doms(struct seq_file *s, struct resctrl_schema *schema, int=
 closid)
-{
-	struct rdt_resource *r =3D schema->res;
-	struct rdt_ctrl_domain *dom;
-	bool sep =3D false;
-	u32 ctrl_val;
-
-	/* Walking r->domains, ensure it can't race with cpuhp */
-	lockdep_assert_cpus_held();
-
-	seq_printf(s, "%*s:", max_name_width, schema->name);
-	list_for_each_entry(dom, &r->ctrl_domains, hdr.list) {
-		if (sep)
-			seq_puts(s, ";");
-
-		if (is_mba_sc(r))
-			ctrl_val =3D dom->mbps_val[closid];
-		else
-			ctrl_val =3D resctrl_arch_get_config(r, dom, closid,
-							   schema->conf_type);
-
-		seq_printf(s, schema->fmt_str, dom->hdr.id, ctrl_val);
-		sep =3D true;
-	}
-	seq_puts(s, "\n");
-}
-
-int rdtgroup_schemata_show(struct kernfs_open_file *of,
-			   struct seq_file *s, void *v)
-{
-	struct resctrl_schema *schema;
-	struct rdtgroup *rdtgrp;
-	int ret =3D 0;
-	u32 closid;
-
-	rdtgrp =3D rdtgroup_kn_lock_live(of->kn);
-	if (rdtgrp) {
-		if (rdtgrp->mode =3D=3D RDT_MODE_PSEUDO_LOCKSETUP) {
-			list_for_each_entry(schema, &resctrl_schema_all, list) {
-				seq_printf(s, "%s:uninitialized\n", schema->name);
-			}
-		} else if (rdtgrp->mode =3D=3D RDT_MODE_PSEUDO_LOCKED) {
-			if (!rdtgrp->plr->d) {
-				rdt_last_cmd_clear();
-				rdt_last_cmd_puts("Cache domain offline\n");
-				ret =3D -ENODEV;
-			} else {
-				seq_printf(s, "%s:%d=3D%x\n",
-					   rdtgrp->plr->s->res->name,
-					   rdtgrp->plr->d->hdr.id,
-					   rdtgrp->plr->cbm);
-			}
-		} else {
-			closid =3D rdtgrp->closid;
-			list_for_each_entry(schema, &resctrl_schema_all, list) {
-				if (closid < schema->num_closid)
-					show_doms(s, schema, closid);
-			}
-		}
-	} else {
-		ret =3D -ENOENT;
-	}
-	rdtgroup_kn_unlock(of->kn);
-	return ret;
-}
-
-static int smp_mon_event_count(void *arg)
-{
-	mon_event_count(arg);
-
-	return 0;
-}
-
-ssize_t rdtgroup_mba_mbps_event_write(struct kernfs_open_file *of,
-				      char *buf, size_t nbytes, loff_t off)
-{
-	struct rdtgroup *rdtgrp;
-	int ret =3D 0;
-
-	/* Valid input requires a trailing newline */
-	if (nbytes =3D=3D 0 || buf[nbytes - 1] !=3D '\n')
-		return -EINVAL;
-	buf[nbytes - 1] =3D '\0';
-
-	rdtgrp =3D rdtgroup_kn_lock_live(of->kn);
-	if (!rdtgrp) {
-		rdtgroup_kn_unlock(of->kn);
-		return -ENOENT;
-	}
-	rdt_last_cmd_clear();
-
-	if (!strcmp(buf, "mbm_local_bytes")) {
-		if (resctrl_arch_is_mbm_local_enabled())
-			rdtgrp->mba_mbps_event =3D QOS_L3_MBM_LOCAL_EVENT_ID;
-		else
-			ret =3D -EINVAL;
-	} else if (!strcmp(buf, "mbm_total_bytes")) {
-		if (resctrl_arch_is_mbm_total_enabled())
-			rdtgrp->mba_mbps_event =3D QOS_L3_MBM_TOTAL_EVENT_ID;
-		else
-			ret =3D -EINVAL;
-	} else {
-		ret =3D -EINVAL;
-	}
-
-	if (ret)
-		rdt_last_cmd_printf("Unsupported event id '%s'\n", buf);
-
-	rdtgroup_kn_unlock(of->kn);
-
-	return ret ?: nbytes;
-}
-
-int rdtgroup_mba_mbps_event_show(struct kernfs_open_file *of,
-				 struct seq_file *s, void *v)
-{
-	struct rdtgroup *rdtgrp;
-	int ret =3D 0;
-
-	rdtgrp =3D rdtgroup_kn_lock_live(of->kn);
-
-	if (rdtgrp) {
-		switch (rdtgrp->mba_mbps_event) {
-		case QOS_L3_MBM_LOCAL_EVENT_ID:
-			seq_puts(s, "mbm_local_bytes\n");
-			break;
-		case QOS_L3_MBM_TOTAL_EVENT_ID:
-			seq_puts(s, "mbm_total_bytes\n");
-			break;
-		default:
-			pr_warn_once("Bad event %d\n", rdtgrp->mba_mbps_event);
-			ret =3D -EINVAL;
-			break;
-		}
-	} else {
-		ret =3D -ENOENT;
-	}
-
-	rdtgroup_kn_unlock(of->kn);
-
-	return ret;
-}
-
-struct rdt_domain_hdr *resctrl_find_domain(struct list_head *h, int id,
-					   struct list_head **pos)
-{
-	struct rdt_domain_hdr *d;
-	struct list_head *l;
-
-	list_for_each(l, h) {
-		d =3D list_entry(l, struct rdt_domain_hdr, list);
-		/* When id is found, return its domain. */
-		if (id =3D=3D d->id)
-			return d;
-		/* Stop searching when finding id's position in sorted list. */
-		if (id < d->id)
-			break;
-	}
-
-	if (pos)
-		*pos =3D l;
-
-	return NULL;
-}
-
-void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
-		    struct rdt_mon_domain *d, struct rdtgroup *rdtgrp,
-		    cpumask_t *cpumask, int evtid, int first)
-{
-	int cpu;
-
-	/* When picking a CPU from cpu_mask, ensure it can't race with cpuhp */
-	lockdep_assert_cpus_held();
-
-	/*
-	 * Setup the parameters to pass to mon_event_count() to read the data.
-	 */
-	rr->rgrp =3D rdtgrp;
-	rr->evtid =3D evtid;
-	rr->r =3D r;
-	rr->d =3D d;
-	rr->first =3D first;
-	rr->arch_mon_ctx =3D resctrl_arch_mon_ctx_alloc(r, evtid);
-	if (IS_ERR(rr->arch_mon_ctx)) {
-		rr->err =3D -EINVAL;
-		return;
-	}
-
-	cpu =3D cpumask_any_housekeeping(cpumask, RESCTRL_PICK_ANY_CPU);
-
-	/*
-	 * cpumask_any_housekeeping() prefers housekeeping CPUs, but
-	 * are all the CPUs nohz_full? If yes, pick a CPU to IPI.
-	 * MPAM's resctrl_arch_rmid_read() is unable to read the
-	 * counters on some platforms if its called in IRQ context.
-	 */
-	if (tick_nohz_full_cpu(cpu))
-		smp_call_function_any(cpumask, mon_event_count, rr, 1);
-	else
-		smp_call_on_cpu(cpu, smp_mon_event_count, rr, false);
-
-	resctrl_arch_mon_ctx_free(r, evtid, rr->arch_mon_ctx);
-}
-
-int rdtgroup_mondata_show(struct seq_file *m, void *arg)
-{
-	struct kernfs_open_file *of =3D m->private;
-	enum resctrl_res_level resid;
-	enum resctrl_event_id evtid;
-	struct rdt_domain_hdr *hdr;
-	struct rmid_read rr =3D {0};
-	struct rdt_mon_domain *d;
-	struct rdtgroup *rdtgrp;
-	struct rdt_resource *r;
-	struct mon_data *md;
-	int domid, ret =3D 0;
-
-	rdtgrp =3D rdtgroup_kn_lock_live(of->kn);
-	if (!rdtgrp) {
-		ret =3D -ENOENT;
-		goto out;
-	}
-
-	md =3D of->kn->priv;
-	if (WARN_ON_ONCE(!md)) {
-		ret =3D -EIO;
-		goto out;
-	}
-
-	resid =3D md->rid;
-	domid =3D md->domid;
-	evtid =3D md->evtid;
-	r =3D resctrl_arch_get_resource(resid);
-
-	if (md->sum) {
-		/*
-		 * This file requires summing across all domains that share
-		 * the L3 cache id that was provided in the "domid" field of the
-		 * struct mon_data. Search all domains in the resource for
-		 * one that matches this cache id.
-		 */
-		list_for_each_entry(d, &r->mon_domains, hdr.list) {
-			if (d->ci->id =3D=3D domid) {
-				rr.ci =3D d->ci;
-				mon_event_read(&rr, r, NULL, rdtgrp,
-					       &d->ci->shared_cpu_map, evtid, false);
-				goto checkresult;
-			}
-		}
-		ret =3D -ENOENT;
-		goto out;
-	} else {
-		/*
-		 * This file provides data from a single domain. Search
-		 * the resource to find the domain with "domid".
-		 */
-		hdr =3D resctrl_find_domain(&r->mon_domains, domid, NULL);
-		if (!hdr || WARN_ON_ONCE(hdr->type !=3D RESCTRL_MON_DOMAIN)) {
-			ret =3D -ENOENT;
-			goto out;
-		}
-		d =3D container_of(hdr, struct rdt_mon_domain, hdr);
-		mon_event_read(&rr, r, d, rdtgrp, &d->hdr.cpu_mask, evtid, false);
-	}
-
-checkresult:
-
-	if (rr.err =3D=3D -EIO)
-		seq_puts(m, "Error\n");
-	else if (rr.err =3D=3D -EINVAL)
-		seq_puts(m, "Unavailable\n");
-	else
-		seq_printf(m, "%llu\n", rr.val);
-
-out:
-	rdtgroup_kn_unlock(of->kn);
-	return ret;
-}
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/res=
ctrl/internal.h
index dc63ac5..5e3c41b 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -3,24 +3,21 @@
 #define _ASM_X86_RESCTRL_INTERNAL_H
=20
 #include <linux/resctrl.h>
-#include <linux/sched.h>
-#include <linux/kernfs.h>
-#include <linux/fs_context.h>
-#include <linux/jump_label.h>
-#include <linux/tick.h>
=20
 #define L3_QOS_CDP_ENABLE		0x01ULL
=20
 #define L2_QOS_CDP_ENABLE		0x01ULL
=20
-#define CQM_LIMBOCHECK_INTERVAL	1000
-
 #define MBM_CNTR_WIDTH_BASE		24
+
 #define MBA_IS_LINEAR			0x4
+
 #define MBM_CNTR_WIDTH_OFFSET_AMD	20
=20
 #define RMID_VAL_ERROR			BIT_ULL(63)
+
 #define RMID_VAL_UNAVAIL		BIT_ULL(62)
+
 /*
  * With the above fields in use 62 bits remain in MSR_IA32_QM_CTR for
  * data to be returned. The counter width is discovered from the hardware
@@ -29,263 +26,6 @@
 #define MBM_CNTR_WIDTH_OFFSET_MAX (62 - MBM_CNTR_WIDTH_BASE)
=20
 /**
- * cpumask_any_housekeeping() - Choose any CPU in @mask, preferring those th=
at
- *			        aren't marked nohz_full
- * @mask:	The mask to pick a CPU from.
- * @exclude_cpu:The CPU to avoid picking.
- *
- * Returns a CPU from @mask, but not @exclude_cpu. If there are housekeeping
- * CPUs that don't use nohz_full, these are preferred. Pass
- * RESCTRL_PICK_ANY_CPU to avoid excluding any CPUs.
- *
- * When a CPU is excluded, returns >=3D nr_cpu_ids if no CPUs are available.
- */
-static inline unsigned int
-cpumask_any_housekeeping(const struct cpumask *mask, int exclude_cpu)
-{
-	unsigned int cpu;
-
-	/* Try to find a CPU that isn't nohz_full to use in preference */
-	if (tick_nohz_full_enabled()) {
-		cpu =3D cpumask_any_andnot_but(mask, tick_nohz_full_mask, exclude_cpu);
-		if (cpu < nr_cpu_ids)
-			return cpu;
-	}
-
-	return cpumask_any_but(mask, exclude_cpu);
-}
-
-struct rdt_fs_context {
-	struct kernfs_fs_context	kfc;
-	bool				enable_cdpl2;
-	bool				enable_cdpl3;
-	bool				enable_mba_mbps;
-	bool				enable_debug;
-};
-
-static inline struct rdt_fs_context *rdt_fc2context(struct fs_context *fc)
-{
-	struct kernfs_fs_context *kfc =3D fc->fs_private;
-
-	return container_of(kfc, struct rdt_fs_context, kfc);
-}
-
-/**
- * struct mon_evt - Entry in the event list of a resource
- * @evtid:		event id
- * @name:		name of the event
- * @configurable:	true if the event is configurable
- * @list:		entry in &rdt_resource->evt_list
- */
-struct mon_evt {
-	enum resctrl_event_id	evtid;
-	char			*name;
-	bool			configurable;
-	struct list_head	list;
-};
-
-/**
- * struct mon_data - Monitoring details for each event file.
- * @list:            Member of the global @mon_data_kn_priv_list list.
- * @rid:             Resource id associated with the event file.
- * @evtid:           Event id associated with the event file.
- * @sum:             Set when event must be summed across multiple
- *                   domains.
- * @domid:           When @sum is zero this is the domain to which
- *                   the event file belongs. When @sum is one this
- *                   is the id of the L3 cache that all domains to be
- *                   summed share.
- *
- * Pointed to by the kernfs kn->priv field of monitoring event files.
- * Readers and writers must hold rdtgroup_mutex.
- */
-struct mon_data {
-	struct list_head	list;
-	enum resctrl_res_level	rid;
-	enum resctrl_event_id	evtid;
-	int			domid;
-	bool			sum;
-};
-
-/**
- * struct rmid_read - Data passed across smp_call*() to read event count.
- * @rgrp:  Resource group for which the counter is being read. If it is a pa=
rent
- *	   resource group then its event count is summed with the count from all
- *	   its child resource groups.
- * @r:	   Resource describing the properties of the event being read.
- * @d:	   Domain that the counter should be read from. If NULL then sum all
- *	   domains in @r sharing L3 @ci.id
- * @evtid: Which monitor event to read.
- * @first: Initialize MBM counter when true.
- * @ci:    Cacheinfo for L3. Only set when @d is NULL. Used when summing dom=
ains.
- * @err:   Error encountered when reading counter.
- * @val:   Returned value of event counter. If @rgrp is a parent resource gr=
oup,
- *	   @val includes the sum of event counts from its child resource groups.
- *	   If @d is NULL, @val includes the sum of all domains in @r sharing @ci.=
id,
- *	   (summed across child resource groups if @rgrp is a parent resource gro=
up).
- * @arch_mon_ctx: Hardware monitor allocated for this read request (MPAM onl=
y).
- */
-struct rmid_read {
-	struct rdtgroup		*rgrp;
-	struct rdt_resource	*r;
-	struct rdt_mon_domain	*d;
-	enum resctrl_event_id	evtid;
-	bool			first;
-	struct cacheinfo	*ci;
-	int			err;
-	u64			val;
-	void			*arch_mon_ctx;
-};
-
-extern struct list_head resctrl_schema_all;
-extern bool resctrl_mounted;
-
-enum rdt_group_type {
-	RDTCTRL_GROUP =3D 0,
-	RDTMON_GROUP,
-	RDT_NUM_GROUP,
-};
-
-/**
- * enum rdtgrp_mode - Mode of a RDT resource group
- * @RDT_MODE_SHAREABLE: This resource group allows sharing of its allocations
- * @RDT_MODE_EXCLUSIVE: No sharing of this resource group's allocations allo=
wed
- * @RDT_MODE_PSEUDO_LOCKSETUP: Resource group will be used for Pseudo-Locking
- * @RDT_MODE_PSEUDO_LOCKED: No sharing of this resource group's allocations
- *                          allowed AND the allocations are Cache Pseudo-Loc=
ked
- * @RDT_NUM_MODES: Total number of modes
- *
- * The mode of a resource group enables control over the allowed overlap
- * between allocations associated with different resource groups (classes
- * of service). User is able to modify the mode of a resource group by
- * writing to the "mode" resctrl file associated with the resource group.
- *
- * The "shareable", "exclusive", and "pseudo-locksetup" modes are set by
- * writing the appropriate text to the "mode" file. A resource group enters
- * "pseudo-locked" mode after the schemata is written while the resource
- * group is in "pseudo-locksetup" mode.
- */
-enum rdtgrp_mode {
-	RDT_MODE_SHAREABLE =3D 0,
-	RDT_MODE_EXCLUSIVE,
-	RDT_MODE_PSEUDO_LOCKSETUP,
-	RDT_MODE_PSEUDO_LOCKED,
-
-	/* Must be last */
-	RDT_NUM_MODES,
-};
-
-/**
- * struct mongroup - store mon group's data in resctrl fs.
- * @mon_data_kn:		kernfs node for the mon_data directory
- * @parent:			parent rdtgrp
- * @crdtgrp_list:		child rdtgroup node list
- * @rmid:			rmid for this rdtgroup
- */
-struct mongroup {
-	struct kernfs_node	*mon_data_kn;
-	struct rdtgroup		*parent;
-	struct list_head	crdtgrp_list;
-	u32			rmid;
-};
-
-/**
- * struct rdtgroup - store rdtgroup's data in resctrl file system.
- * @kn:				kernfs node
- * @rdtgroup_list:		linked list for all rdtgroups
- * @closid:			closid for this rdtgroup
- * @cpu_mask:			CPUs assigned to this rdtgroup
- * @flags:			status bits
- * @waitcount:			how many cpus expect to find this
- *				group when they acquire rdtgroup_mutex
- * @type:			indicates type of this rdtgroup - either
- *				monitor only or ctrl_mon group
- * @mon:			mongroup related data
- * @mode:			mode of resource group
- * @mba_mbps_event:		input monitoring event id when mba_sc is enabled
- * @plr:			pseudo-locked region
- */
-struct rdtgroup {
-	struct kernfs_node		*kn;
-	struct list_head		rdtgroup_list;
-	u32				closid;
-	struct cpumask			cpu_mask;
-	int				flags;
-	atomic_t			waitcount;
-	enum rdt_group_type		type;
-	struct mongroup			mon;
-	enum rdtgrp_mode		mode;
-	enum resctrl_event_id		mba_mbps_event;
-	struct pseudo_lock_region	*plr;
-};
-
-/* rdtgroup.flags */
-#define	RDT_DELETED		1
-
-/* rftype.flags */
-#define RFTYPE_FLAGS_CPUS_LIST	1
-
-/*
- * Define the file type flags for base and info directories.
- */
-#define RFTYPE_INFO			BIT(0)
-#define RFTYPE_BASE			BIT(1)
-#define RFTYPE_CTRL			BIT(4)
-#define RFTYPE_MON			BIT(5)
-#define RFTYPE_TOP			BIT(6)
-#define RFTYPE_RES_CACHE		BIT(8)
-#define RFTYPE_RES_MB			BIT(9)
-#define RFTYPE_DEBUG			BIT(10)
-#define RFTYPE_CTRL_INFO		(RFTYPE_INFO | RFTYPE_CTRL)
-#define RFTYPE_MON_INFO			(RFTYPE_INFO | RFTYPE_MON)
-#define RFTYPE_TOP_INFO			(RFTYPE_INFO | RFTYPE_TOP)
-#define RFTYPE_CTRL_BASE		(RFTYPE_BASE | RFTYPE_CTRL)
-#define RFTYPE_MON_BASE			(RFTYPE_BASE | RFTYPE_MON)
-
-/* List of all resource groups */
-extern struct list_head rdt_all_groups;
-
-extern int max_name_width;
-
-/**
- * struct rftype - describe each file in the resctrl file system
- * @name:	File name
- * @mode:	Access mode
- * @kf_ops:	File operations
- * @flags:	File specific RFTYPE_FLAGS_* flags
- * @fflags:	File specific RFTYPE_* flags
- * @seq_show:	Show content of the file
- * @write:	Write to the file
- */
-struct rftype {
-	char			*name;
-	umode_t			mode;
-	const struct kernfs_ops	*kf_ops;
-	unsigned long		flags;
-	unsigned long		fflags;
-
-	int (*seq_show)(struct kernfs_open_file *of,
-			struct seq_file *sf, void *v);
-	/*
-	 * write() is the generic write callback which maps directly to
-	 * kernfs write operation and overrides all other operations.
-	 * Maximum write size is determined by ->max_write_len.
-	 */
-	ssize_t (*write)(struct kernfs_open_file *of,
-			 char *buf, size_t nbytes, loff_t off);
-};
-
-/**
- * struct mbm_state - status for each MBM counter in each domain
- * @prev_bw_bytes: Previous bytes value read for bandwidth calculation
- * @prev_bw:	The most recent bandwidth in MBps
- */
-struct mbm_state {
-	u64	prev_bw_bytes;
-	u32	prev_bw;
-};
-
-/**
  * struct arch_mbm_state - values used to compute resctrl_arch_rmid_read()s
  *			   return value.
  * @chunks:	Total data moved (multiply by rdt_group.mon_scale to get bytes)
@@ -382,17 +122,7 @@ static inline struct rdt_hw_resource *resctrl_to_arch_re=
s(struct rdt_resource *r
 	return container_of(r, struct rdt_hw_resource, r_resctrl);
 }
=20
-extern struct mutex rdtgroup_mutex;
-
-static inline const char *rdt_kn_name(const struct kernfs_node *kn)
-{
-	return rcu_dereference_check(kn->name, lockdep_is_held(&rdtgroup_mutex));
-}
-
 extern struct rdt_hw_resource rdt_resources_all[];
-extern struct rdtgroup rdtgroup_default;
-extern struct dentry *debugfs_resctrl;
-extern enum resctrl_event_id mba_mbps_default_event;
=20
 void arch_mon_domain_online(struct rdt_resource *r, struct rdt_mon_domain *d=
);
=20
@@ -429,99 +159,14 @@ union cpuid_0x10_x_edx {
 	unsigned int full;
 };
=20
-void rdt_last_cmd_clear(void);
-void rdt_last_cmd_puts(const char *s);
-__printf(1, 2)
-void rdt_last_cmd_printf(const char *fmt, ...);
-
 void rdt_ctrl_update(void *arg);
-struct rdtgroup *rdtgroup_kn_lock_live(struct kernfs_node *kn);
-void rdtgroup_kn_unlock(struct kernfs_node *kn);
-int rdtgroup_kn_mode_restrict(struct rdtgroup *r, const char *name);
-int rdtgroup_kn_mode_restore(struct rdtgroup *r, const char *name,
-			     umode_t mask);
-ssize_t rdtgroup_schemata_write(struct kernfs_open_file *of,
-				char *buf, size_t nbytes, loff_t off);
-int rdtgroup_schemata_show(struct kernfs_open_file *of,
-			   struct seq_file *s, void *v);
-ssize_t rdtgroup_mba_mbps_event_write(struct kernfs_open_file *of,
-				      char *buf, size_t nbytes, loff_t off);
-int rdtgroup_mba_mbps_event_show(struct kernfs_open_file *of,
-				 struct seq_file *s, void *v);
-bool rdtgroup_cbm_overlaps(struct resctrl_schema *s, struct rdt_ctrl_domain =
*d,
-			   unsigned long cbm, int closid, bool exclusive);
-unsigned int rdtgroup_cbm_to_size(struct rdt_resource *r, struct rdt_ctrl_do=
main *d,
-				  unsigned long cbm);
-enum rdtgrp_mode rdtgroup_mode_by_closid(int closid);
-int rdtgroup_tasks_assigned(struct rdtgroup *r);
-int closids_supported(void);
-void closid_free(int closid);
-int alloc_rmid(u32 closid);
-void free_rmid(u32 closid, u32 rmid);
-int rdt_get_mon_l3_config(struct rdt_resource *r);
-void resctrl_mon_resource_exit(void);
-bool rdt_cpu_has(int flag);
-void mon_event_count(void *info);
-int rdtgroup_mondata_show(struct seq_file *m, void *arg);
-void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
-		    struct rdt_mon_domain *d, struct rdtgroup *rdtgrp,
-		    cpumask_t *cpumask, int evtid, int first);
-int resctrl_mon_resource_init(void);
-void mbm_setup_overflow_handler(struct rdt_mon_domain *dom,
-				unsigned long delay_ms,
-				int exclude_cpu);
-void mbm_handle_overflow(struct work_struct *work);
-void __init intel_rdt_mbm_apply_quirk(void);
-bool is_mba_sc(struct rdt_resource *r);
-void cqm_setup_limbo_handler(struct rdt_mon_domain *dom, unsigned long delay=
_ms,
-			     int exclude_cpu);
-void cqm_handle_limbo(struct work_struct *work);
-bool has_busy_rmid(struct rdt_mon_domain *d);
-void __check_limbo(struct rdt_mon_domain *d, bool force_free);
-void rdt_domain_reconfigure_cdp(struct rdt_resource *r);
-void resctrl_file_fflags_init(const char *config, unsigned long fflags);
-void rdt_staged_configs_clear(void);
-bool closid_allocated(unsigned int closid);
-int resctrl_find_cleanest_closid(void);
-
-#ifdef CONFIG_RESCTRL_FS_PSEUDO_LOCK
-int rdtgroup_locksetup_enter(struct rdtgroup *rdtgrp);
-int rdtgroup_locksetup_exit(struct rdtgroup *rdtgrp);
-bool rdtgroup_cbm_overlaps_pseudo_locked(struct rdt_ctrl_domain *d, unsigned=
 long cbm);
-bool rdtgroup_pseudo_locked_in_hierarchy(struct rdt_ctrl_domain *d);
-int rdt_pseudo_lock_init(void);
-void rdt_pseudo_lock_release(void);
-int rdtgroup_pseudo_lock_create(struct rdtgroup *rdtgrp);
-void rdtgroup_pseudo_lock_remove(struct rdtgroup *rdtgrp);
-#else
-static inline int rdtgroup_locksetup_enter(struct rdtgroup *rdtgrp)
-{
-	return -EOPNOTSUPP;
-}
=20
-static inline int rdtgroup_locksetup_exit(struct rdtgroup *rdtgrp)
-{
-	return -EOPNOTSUPP;
-}
-
-static inline bool rdtgroup_cbm_overlaps_pseudo_locked(struct rdt_ctrl_domai=
n *d, unsigned long cbm)
-{
-	return false;
-}
+int rdt_get_mon_l3_config(struct rdt_resource *r);
=20
-static inline bool rdtgroup_pseudo_locked_in_hierarchy(struct rdt_ctrl_domai=
n *d)
-{
-	return false;
-}
+bool rdt_cpu_has(int flag);
=20
-static inline int rdt_pseudo_lock_init(void) { return 0; }
-static inline void rdt_pseudo_lock_release(void) { }
-static inline int rdtgroup_pseudo_lock_create(struct rdtgroup *rdtgrp)
-{
-	return -EOPNOTSUPP;
-}
+void __init intel_rdt_mbm_apply_quirk(void);
=20
-static inline void rdtgroup_pseudo_lock_remove(struct rdtgroup *rdtgrp) { }
-#endif /* CONFIG_RESCTRL_FS_PSEUDO_LOCK */
+void rdt_domain_reconfigure_cdp(struct rdt_resource *r);
=20
 #endif /* _ASM_X86_RESCTRL_INTERNAL_H */
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resc=
trl/monitor.c
index 8847c23..3fc4d9f 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -18,65 +18,12 @@
 #define pr_fmt(fmt)	"resctrl: " fmt
=20
 #include <linux/cpu.h>
-#include <linux/module.h>
 #include <linux/resctrl.h>
-#include <linux/sizes.h>
-#include <linux/slab.h>
=20
 #include <asm/cpu_device_id.h>
=20
 #include "internal.h"
=20
-#define CREATE_TRACE_POINTS
-#include "monitor_trace.h"
-
-/**
- * struct rmid_entry - dirty tracking for all RMID.
- * @closid:	The CLOSID for this entry.
- * @rmid:	The RMID for this entry.
- * @busy:	The number of domains with cached data using this RMID.
- * @list:	Member of the rmid_free_lru list when busy =3D=3D 0.
- *
- * Depending on the architecture the correct monitor is accessed using
- * both @closid and @rmid, or @rmid only.
- *
- * Take the rdtgroup_mutex when accessing.
- */
-struct rmid_entry {
-	u32				closid;
-	u32				rmid;
-	int				busy;
-	struct list_head		list;
-};
-
-/*
- * @rmid_free_lru - A least recently used list of free RMIDs
- *     These RMIDs are guaranteed to have an occupancy less than the
- *     threshold occupancy
- */
-static LIST_HEAD(rmid_free_lru);
-
-/*
- * @closid_num_dirty_rmid    The number of dirty RMID each CLOSID has.
- *     Only allocated when CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID is defined.
- *     Indexed by CLOSID. Protected by rdtgroup_mutex.
- */
-static u32 *closid_num_dirty_rmid;
-
-/*
- * @rmid_limbo_count - count of currently unused but (potentially)
- *     dirty RMIDs.
- *     This counts RMIDs that no one is currently using but that
- *     may have a occupancy value > resctrl_rmid_realloc_threshold. User can
- *     change the threshold occupancy value.
- */
-static unsigned int rmid_limbo_count;
-
-/*
- * @rmid_entry - The entry in the limbo and free lists.
- */
-static struct rmid_entry	*rmid_ptrs;
-
 /*
  * Global boolean for rdt_monitor which is true if any
  * resource monitoring is enabled.
@@ -88,23 +35,12 @@ bool rdt_mon_capable;
  */
 unsigned int rdt_mon_features;
=20
-/*
- * This is the threshold cache occupancy in bytes at which we will consider =
an
- * RMID available for re-allocation.
- */
-unsigned int resctrl_rmid_realloc_threshold;
-
-/*
- * This is the maximum value for the reallocation threshold, in bytes.
- */
-unsigned int resctrl_rmid_realloc_limit;
-
 #define CF(cf)	((unsigned long)(1048576 * (cf) + 0.5))
=20
 static int snc_nodes_per_l3_cache =3D 1;
=20
 /*
- * The correction factor table is documented in Documentation/arch/x86/resct=
rl.rst.
+ * The correction factor table is documented in Documentation/filesystems/re=
sctrl.rst.
  * If rmid > rmid threshold, MBM total and local values should be multiplied
  * by the correction factor.
  *
@@ -153,6 +89,7 @@ static const struct mbm_correction_factor_table {
 };
=20
 static u32 mbm_cf_rmidthreshold __read_mostly =3D UINT_MAX;
+
 static u64 mbm_cf __read_mostly;
=20
 static inline u64 get_corrected_mbm_count(u32 rmid, unsigned long val)
@@ -165,33 +102,6 @@ static inline u64 get_corrected_mbm_count(u32 rmid, unsi=
gned long val)
 }
=20
 /*
- * x86 and arm64 differ in their handling of monitoring.
- * x86's RMID are independent numbers, there is only one source of traffic
- * with an RMID value of '1'.
- * arm64's PMG extends the PARTID/CLOSID space, there are multiple sources of
- * traffic with a PMG value of '1', one for each CLOSID, meaning the RMID
- * value is no longer unique.
- * To account for this, resctrl uses an index. On x86 this is just the RMID,
- * on arm64 it encodes the CLOSID and RMID. This gives a unique number.
- *
- * The domain's rmid_busy_llc and rmid_ptrs[] are sized by index. The arch c=
ode
- * must accept an attempt to read every index.
- */
-static inline struct rmid_entry *__rmid_entry(u32 idx)
-{
-	struct rmid_entry *entry;
-	u32 closid, rmid;
-
-	entry =3D &rmid_ptrs[idx];
-	resctrl_arch_rmid_idx_decode(idx, &closid, &rmid);
-
-	WARN_ON_ONCE(entry->closid !=3D closid);
-	WARN_ON_ONCE(entry->rmid !=3D rmid);
-
-	return entry;
-}
-
-/*
  * When Sub-NUMA Cluster (SNC) mode is not enabled (as indicated by
  * "snc_nodes_per_l3_cache =3D=3D 1") no translation of the RMID value is
  * needed. The physical RMID is the same as the logical RMID.
@@ -347,769 +257,6 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, stru=
ct rdt_mon_domain *d,
 	return 0;
 }
=20
-static void limbo_release_entry(struct rmid_entry *entry)
-{
-	lockdep_assert_held(&rdtgroup_mutex);
-
-	rmid_limbo_count--;
-	list_add_tail(&entry->list, &rmid_free_lru);
-
-	if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID))
-		closid_num_dirty_rmid[entry->closid]--;
-}
-
-/*
- * Check the RMIDs that are marked as busy for this domain. If the
- * reported LLC occupancy is below the threshold clear the busy bit and
- * decrement the count. If the busy count gets to zero on an RMID, we
- * free the RMID
- */
-void __check_limbo(struct rdt_mon_domain *d, bool force_free)
-{
-	struct rdt_resource *r =3D resctrl_arch_get_resource(RDT_RESOURCE_L3);
-	u32 idx_limit =3D resctrl_arch_system_num_rmid_idx();
-	struct rmid_entry *entry;
-	u32 idx, cur_idx =3D 1;
-	void *arch_mon_ctx;
-	bool rmid_dirty;
-	u64 val =3D 0;
-
-	arch_mon_ctx =3D resctrl_arch_mon_ctx_alloc(r, QOS_L3_OCCUP_EVENT_ID);
-	if (IS_ERR(arch_mon_ctx)) {
-		pr_warn_ratelimited("Failed to allocate monitor context: %ld",
-				    PTR_ERR(arch_mon_ctx));
-		return;
-	}
-
-	/*
-	 * Skip RMID 0 and start from RMID 1 and check all the RMIDs that
-	 * are marked as busy for occupancy < threshold. If the occupancy
-	 * is less than the threshold decrement the busy counter of the
-	 * RMID and move it to the free list when the counter reaches 0.
-	 */
-	for (;;) {
-		idx =3D find_next_bit(d->rmid_busy_llc, idx_limit, cur_idx);
-		if (idx >=3D idx_limit)
-			break;
-
-		entry =3D __rmid_entry(idx);
-		if (resctrl_arch_rmid_read(r, d, entry->closid, entry->rmid,
-					   QOS_L3_OCCUP_EVENT_ID, &val,
-					   arch_mon_ctx)) {
-			rmid_dirty =3D true;
-		} else {
-			rmid_dirty =3D (val >=3D resctrl_rmid_realloc_threshold);
-
-			/*
-			 * x86's CLOSID and RMID are independent numbers, so the entry's
-			 * CLOSID is an empty CLOSID (X86_RESCTRL_EMPTY_CLOSID). On Arm the
-			 * RMID (PMG) extends the CLOSID (PARTID) space with bits that aren't
-			 * used to select the configuration. It is thus necessary to track both
-			 * CLOSID and RMID because there may be dependencies between them
-			 * on some architectures.
-			 */
-			trace_mon_llc_occupancy_limbo(entry->closid, entry->rmid, d->hdr.id, val);
-		}
-
-		if (force_free || !rmid_dirty) {
-			clear_bit(idx, d->rmid_busy_llc);
-			if (!--entry->busy)
-				limbo_release_entry(entry);
-		}
-		cur_idx =3D idx + 1;
-	}
-
-	resctrl_arch_mon_ctx_free(r, QOS_L3_OCCUP_EVENT_ID, arch_mon_ctx);
-}
-
-bool has_busy_rmid(struct rdt_mon_domain *d)
-{
-	u32 idx_limit =3D resctrl_arch_system_num_rmid_idx();
-
-	return find_first_bit(d->rmid_busy_llc, idx_limit) !=3D idx_limit;
-}
-
-static struct rmid_entry *resctrl_find_free_rmid(u32 closid)
-{
-	struct rmid_entry *itr;
-	u32 itr_idx, cmp_idx;
-
-	if (list_empty(&rmid_free_lru))
-		return rmid_limbo_count ? ERR_PTR(-EBUSY) : ERR_PTR(-ENOSPC);
-
-	list_for_each_entry(itr, &rmid_free_lru, list) {
-		/*
-		 * Get the index of this free RMID, and the index it would need
-		 * to be if it were used with this CLOSID.
-		 * If the CLOSID is irrelevant on this architecture, the two
-		 * index values are always the same on every entry and thus the
-		 * very first entry will be returned.
-		 */
-		itr_idx =3D resctrl_arch_rmid_idx_encode(itr->closid, itr->rmid);
-		cmp_idx =3D resctrl_arch_rmid_idx_encode(closid, itr->rmid);
-
-		if (itr_idx =3D=3D cmp_idx)
-			return itr;
-	}
-
-	return ERR_PTR(-ENOSPC);
-}
-
-/**
- * resctrl_find_cleanest_closid() - Find a CLOSID where all the associated
- *                                  RMID are clean, or the CLOSID that has
- *                                  the most clean RMID.
- *
- * MPAM's equivalent of RMID are per-CLOSID, meaning a freshly allocated CLO=
SID
- * may not be able to allocate clean RMID. To avoid this the allocator will
- * choose the CLOSID with the most clean RMID.
- *
- * When the CLOSID and RMID are independent numbers, the first free CLOSID w=
ill
- * be returned.
- */
-int resctrl_find_cleanest_closid(void)
-{
-	u32 cleanest_closid =3D ~0;
-	int i =3D 0;
-
-	lockdep_assert_held(&rdtgroup_mutex);
-
-	if (!IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID))
-		return -EIO;
-
-	for (i =3D 0; i < closids_supported(); i++) {
-		int num_dirty;
-
-		if (closid_allocated(i))
-			continue;
-
-		num_dirty =3D closid_num_dirty_rmid[i];
-		if (num_dirty =3D=3D 0)
-			return i;
-
-		if (cleanest_closid =3D=3D ~0)
-			cleanest_closid =3D i;
-
-		if (num_dirty < closid_num_dirty_rmid[cleanest_closid])
-			cleanest_closid =3D i;
-	}
-
-	if (cleanest_closid =3D=3D ~0)
-		return -ENOSPC;
-
-	return cleanest_closid;
-}
-
-/*
- * For MPAM the RMID value is not unique, and has to be considered with
- * the CLOSID. The (CLOSID, RMID) pair is allocated on all domains, which
- * allows all domains to be managed by a single free list.
- * Each domain also has a rmid_busy_llc to reduce the work of the limbo hand=
ler.
- */
-int alloc_rmid(u32 closid)
-{
-	struct rmid_entry *entry;
-
-	lockdep_assert_held(&rdtgroup_mutex);
-
-	entry =3D resctrl_find_free_rmid(closid);
-	if (IS_ERR(entry))
-		return PTR_ERR(entry);
-
-	list_del(&entry->list);
-	return entry->rmid;
-}
-
-static void add_rmid_to_limbo(struct rmid_entry *entry)
-{
-	struct rdt_resource *r =3D resctrl_arch_get_resource(RDT_RESOURCE_L3);
-	struct rdt_mon_domain *d;
-	u32 idx;
-
-	lockdep_assert_held(&rdtgroup_mutex);
-
-	/* Walking r->domains, ensure it can't race with cpuhp */
-	lockdep_assert_cpus_held();
-
-	idx =3D resctrl_arch_rmid_idx_encode(entry->closid, entry->rmid);
-
-	entry->busy =3D 0;
-	list_for_each_entry(d, &r->mon_domains, hdr.list) {
-		/*
-		 * For the first limbo RMID in the domain,
-		 * setup up the limbo worker.
-		 */
-		if (!has_busy_rmid(d))
-			cqm_setup_limbo_handler(d, CQM_LIMBOCHECK_INTERVAL,
-						RESCTRL_PICK_ANY_CPU);
-		set_bit(idx, d->rmid_busy_llc);
-		entry->busy++;
-	}
-
-	rmid_limbo_count++;
-	if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID))
-		closid_num_dirty_rmid[entry->closid]++;
-}
-
-void free_rmid(u32 closid, u32 rmid)
-{
-	u32 idx =3D resctrl_arch_rmid_idx_encode(closid, rmid);
-	struct rmid_entry *entry;
-
-	lockdep_assert_held(&rdtgroup_mutex);
-
-	/*
-	 * Do not allow the default rmid to be free'd. Comparing by index
-	 * allows architectures that ignore the closid parameter to avoid an
-	 * unnecessary check.
-	 */
-	if (!resctrl_arch_mon_capable() ||
-	    idx =3D=3D resctrl_arch_rmid_idx_encode(RESCTRL_RESERVED_CLOSID,
-						RESCTRL_RESERVED_RMID))
-		return;
-
-	entry =3D __rmid_entry(idx);
-
-	if (resctrl_arch_is_llc_occupancy_enabled())
-		add_rmid_to_limbo(entry);
-	else
-		list_add_tail(&entry->list, &rmid_free_lru);
-}
-
-static struct mbm_state *get_mbm_state(struct rdt_mon_domain *d, u32 closid,
-				       u32 rmid, enum resctrl_event_id evtid)
-{
-	u32 idx =3D resctrl_arch_rmid_idx_encode(closid, rmid);
-
-	switch (evtid) {
-	case QOS_L3_MBM_TOTAL_EVENT_ID:
-		return &d->mbm_total[idx];
-	case QOS_L3_MBM_LOCAL_EVENT_ID:
-		return &d->mbm_local[idx];
-	default:
-		return NULL;
-	}
-}
-
-static int __mon_event_count(u32 closid, u32 rmid, struct rmid_read *rr)
-{
-	int cpu =3D smp_processor_id();
-	struct rdt_mon_domain *d;
-	struct mbm_state *m;
-	int err, ret;
-	u64 tval =3D 0;
-
-	if (rr->first) {
-		resctrl_arch_reset_rmid(rr->r, rr->d, closid, rmid, rr->evtid);
-		m =3D get_mbm_state(rr->d, closid, rmid, rr->evtid);
-		if (m)
-			memset(m, 0, sizeof(struct mbm_state));
-		return 0;
-	}
-
-	if (rr->d) {
-		/* Reading a single domain, must be on a CPU in that domain. */
-		if (!cpumask_test_cpu(cpu, &rr->d->hdr.cpu_mask))
-			return -EINVAL;
-		rr->err =3D resctrl_arch_rmid_read(rr->r, rr->d, closid, rmid,
-						 rr->evtid, &tval, rr->arch_mon_ctx);
-		if (rr->err)
-			return rr->err;
-
-		rr->val +=3D tval;
-
-		return 0;
-	}
-
-	/* Summing domains that share a cache, must be on a CPU for that cache. */
-	if (!cpumask_test_cpu(cpu, &rr->ci->shared_cpu_map))
-		return -EINVAL;
-
-	/*
-	 * Legacy files must report the sum of an event across all
-	 * domains that share the same L3 cache instance.
-	 * Report success if a read from any domain succeeds, -EINVAL
-	 * (translated to "Unavailable" for user space) if reading from
-	 * all domains fail for any reason.
-	 */
-	ret =3D -EINVAL;
-	list_for_each_entry(d, &rr->r->mon_domains, hdr.list) {
-		if (d->ci->id !=3D rr->ci->id)
-			continue;
-		err =3D resctrl_arch_rmid_read(rr->r, d, closid, rmid,
-					     rr->evtid, &tval, rr->arch_mon_ctx);
-		if (!err) {
-			rr->val +=3D tval;
-			ret =3D 0;
-		}
-	}
-
-	if (ret)
-		rr->err =3D ret;
-
-	return ret;
-}
-
-/*
- * mbm_bw_count() - Update bw count from values previously read by
- *		    __mon_event_count().
- * @closid:	The closid used to identify the cached mbm_state.
- * @rmid:	The rmid used to identify the cached mbm_state.
- * @rr:		The struct rmid_read populated by __mon_event_count().
- *
- * Supporting function to calculate the memory bandwidth
- * and delta bandwidth in MBps. The chunks value previously read by
- * __mon_event_count() is compared with the chunks value from the previous
- * invocation. This must be called once per second to maintain values in MBp=
s.
- */
-static void mbm_bw_count(u32 closid, u32 rmid, struct rmid_read *rr)
-{
-	u64 cur_bw, bytes, cur_bytes;
-	struct mbm_state *m;
-
-	m =3D get_mbm_state(rr->d, closid, rmid, rr->evtid);
-	if (WARN_ON_ONCE(!m))
-		return;
-
-	cur_bytes =3D rr->val;
-	bytes =3D cur_bytes - m->prev_bw_bytes;
-	m->prev_bw_bytes =3D cur_bytes;
-
-	cur_bw =3D bytes / SZ_1M;
-
-	m->prev_bw =3D cur_bw;
-}
-
-/*
- * This is scheduled by mon_event_read() to read the CQM/MBM counters
- * on a domain.
- */
-void mon_event_count(void *info)
-{
-	struct rdtgroup *rdtgrp, *entry;
-	struct rmid_read *rr =3D info;
-	struct list_head *head;
-	int ret;
-
-	rdtgrp =3D rr->rgrp;
-
-	ret =3D __mon_event_count(rdtgrp->closid, rdtgrp->mon.rmid, rr);
-
-	/*
-	 * For Ctrl groups read data from child monitor groups and
-	 * add them together. Count events which are read successfully.
-	 * Discard the rmid_read's reporting errors.
-	 */
-	head =3D &rdtgrp->mon.crdtgrp_list;
-
-	if (rdtgrp->type =3D=3D RDTCTRL_GROUP) {
-		list_for_each_entry(entry, head, mon.crdtgrp_list) {
-			if (__mon_event_count(entry->closid, entry->mon.rmid,
-					      rr) =3D=3D 0)
-				ret =3D 0;
-		}
-	}
-
-	/*
-	 * __mon_event_count() calls for newly created monitor groups may
-	 * report -EINVAL/Unavailable if the monitor hasn't seen any traffic.
-	 * Discard error if any of the monitor event reads succeeded.
-	 */
-	if (ret =3D=3D 0)
-		rr->err =3D 0;
-}
-
-static struct rdt_ctrl_domain *get_ctrl_domain_from_cpu(int cpu,
-							struct rdt_resource *r)
-{
-	struct rdt_ctrl_domain *d;
-
-	lockdep_assert_cpus_held();
-
-	list_for_each_entry(d, &r->ctrl_domains, hdr.list) {
-		/* Find the domain that contains this CPU */
-		if (cpumask_test_cpu(cpu, &d->hdr.cpu_mask))
-			return d;
-	}
-
-	return NULL;
-}
-
-/*
- * Feedback loop for MBA software controller (mba_sc)
- *
- * mba_sc is a feedback loop where we periodically read MBM counters and
- * adjust the bandwidth percentage values via the IA32_MBA_THRTL_MSRs so
- * that:
- *
- *   current bandwidth(cur_bw) < user specified bandwidth(user_bw)
- *
- * This uses the MBM counters to measure the bandwidth and MBA throttle
- * MSRs to control the bandwidth for a particular rdtgrp. It builds on the
- * fact that resctrl rdtgroups have both monitoring and control.
- *
- * The frequency of the checks is 1s and we just tag along the MBM overflow
- * timer. Having 1s interval makes the calculation of bandwidth simpler.
- *
- * Although MBA's goal is to restrict the bandwidth to a maximum, there may
- * be a need to increase the bandwidth to avoid unnecessarily restricting
- * the L2 <-> L3 traffic.
- *
- * Since MBA controls the L2 external bandwidth where as MBM measures the
- * L3 external bandwidth the following sequence could lead to such a
- * situation.
- *
- * Consider an rdtgroup which had high L3 <-> memory traffic in initial
- * phases -> mba_sc kicks in and reduced bandwidth percentage values -> but
- * after some time rdtgroup has mostly L2 <-> L3 traffic.
- *
- * In this case we may restrict the rdtgroup's L2 <-> L3 traffic as its
- * throttle MSRs already have low percentage values.  To avoid
- * unnecessarily restricting such rdtgroups, we also increase the bandwidth.
- */
-static void update_mba_bw(struct rdtgroup *rgrp, struct rdt_mon_domain *dom_=
mbm)
-{
-	u32 closid, rmid, cur_msr_val, new_msr_val;
-	struct mbm_state *pmbm_data, *cmbm_data;
-	struct rdt_ctrl_domain *dom_mba;
-	enum resctrl_event_id evt_id;
-	struct rdt_resource *r_mba;
-	struct list_head *head;
-	struct rdtgroup *entry;
-	u32 cur_bw, user_bw;
-
-	r_mba =3D resctrl_arch_get_resource(RDT_RESOURCE_MBA);
-	evt_id =3D rgrp->mba_mbps_event;
-
-	closid =3D rgrp->closid;
-	rmid =3D rgrp->mon.rmid;
-	pmbm_data =3D get_mbm_state(dom_mbm, closid, rmid, evt_id);
-	if (WARN_ON_ONCE(!pmbm_data))
-		return;
-
-	dom_mba =3D get_ctrl_domain_from_cpu(smp_processor_id(), r_mba);
-	if (!dom_mba) {
-		pr_warn_once("Failure to get domain for MBA update\n");
-		return;
-	}
-
-	cur_bw =3D pmbm_data->prev_bw;
-	user_bw =3D dom_mba->mbps_val[closid];
-
-	/* MBA resource doesn't support CDP */
-	cur_msr_val =3D resctrl_arch_get_config(r_mba, dom_mba, closid, CDP_NONE);
-
-	/*
-	 * For Ctrl groups read data from child monitor groups.
-	 */
-	head =3D &rgrp->mon.crdtgrp_list;
-	list_for_each_entry(entry, head, mon.crdtgrp_list) {
-		cmbm_data =3D get_mbm_state(dom_mbm, entry->closid, entry->mon.rmid, evt_i=
d);
-		if (WARN_ON_ONCE(!cmbm_data))
-			return;
-		cur_bw +=3D cmbm_data->prev_bw;
-	}
-
-	/*
-	 * Scale up/down the bandwidth linearly for the ctrl group.  The
-	 * bandwidth step is the bandwidth granularity specified by the
-	 * hardware.
-	 * Always increase throttling if current bandwidth is above the
-	 * target set by user.
-	 * But avoid thrashing up and down on every poll by checking
-	 * whether a decrease in throttling is likely to push the group
-	 * back over target. E.g. if currently throttling to 30% of bandwidth
-	 * on a system with 10% granularity steps, check whether moving to
-	 * 40% would go past the limit by multiplying current bandwidth by
-	 * "(30 + 10) / 30".
-	 */
-	if (cur_msr_val > r_mba->membw.min_bw && user_bw < cur_bw) {
-		new_msr_val =3D cur_msr_val - r_mba->membw.bw_gran;
-	} else if (cur_msr_val < MAX_MBA_BW &&
-		   (user_bw > (cur_bw * (cur_msr_val + r_mba->membw.min_bw) / cur_msr_val)=
)) {
-		new_msr_val =3D cur_msr_val + r_mba->membw.bw_gran;
-	} else {
-		return;
-	}
-
-	resctrl_arch_update_one(r_mba, dom_mba, closid, CDP_NONE, new_msr_val);
-}
-
-static void mbm_update_one_event(struct rdt_resource *r, struct rdt_mon_doma=
in *d,
-				 u32 closid, u32 rmid, enum resctrl_event_id evtid)
-{
-	struct rmid_read rr =3D {0};
-
-	rr.r =3D r;
-	rr.d =3D d;
-	rr.evtid =3D evtid;
-	rr.arch_mon_ctx =3D resctrl_arch_mon_ctx_alloc(rr.r, rr.evtid);
-	if (IS_ERR(rr.arch_mon_ctx)) {
-		pr_warn_ratelimited("Failed to allocate monitor context: %ld",
-				    PTR_ERR(rr.arch_mon_ctx));
-		return;
-	}
-
-	__mon_event_count(closid, rmid, &rr);
-
-	/*
-	 * If the software controller is enabled, compute the
-	 * bandwidth for this event id.
-	 */
-	if (is_mba_sc(NULL))
-		mbm_bw_count(closid, rmid, &rr);
-
-	resctrl_arch_mon_ctx_free(rr.r, rr.evtid, rr.arch_mon_ctx);
-}
-
-static void mbm_update(struct rdt_resource *r, struct rdt_mon_domain *d,
-		       u32 closid, u32 rmid)
-{
-	/*
-	 * This is protected from concurrent reads from user as both
-	 * the user and overflow handler hold the global mutex.
-	 */
-	if (resctrl_arch_is_mbm_total_enabled())
-		mbm_update_one_event(r, d, closid, rmid, QOS_L3_MBM_TOTAL_EVENT_ID);
-
-	if (resctrl_arch_is_mbm_local_enabled())
-		mbm_update_one_event(r, d, closid, rmid, QOS_L3_MBM_LOCAL_EVENT_ID);
-}
-
-/*
- * Handler to scan the limbo list and move the RMIDs
- * to free list whose occupancy < threshold_occupancy.
- */
-void cqm_handle_limbo(struct work_struct *work)
-{
-	unsigned long delay =3D msecs_to_jiffies(CQM_LIMBOCHECK_INTERVAL);
-	struct rdt_mon_domain *d;
-
-	cpus_read_lock();
-	mutex_lock(&rdtgroup_mutex);
-
-	d =3D container_of(work, struct rdt_mon_domain, cqm_limbo.work);
-
-	__check_limbo(d, false);
-
-	if (has_busy_rmid(d)) {
-		d->cqm_work_cpu =3D cpumask_any_housekeeping(&d->hdr.cpu_mask,
-							   RESCTRL_PICK_ANY_CPU);
-		schedule_delayed_work_on(d->cqm_work_cpu, &d->cqm_limbo,
-					 delay);
-	}
-
-	mutex_unlock(&rdtgroup_mutex);
-	cpus_read_unlock();
-}
-
-/**
- * cqm_setup_limbo_handler() - Schedule the limbo handler to run for this
- *                             domain.
- * @dom:           The domain the limbo handler should run for.
- * @delay_ms:      How far in the future the handler should run.
- * @exclude_cpu:   Which CPU the handler should not run on,
- *		   RESCTRL_PICK_ANY_CPU to pick any CPU.
- */
-void cqm_setup_limbo_handler(struct rdt_mon_domain *dom, unsigned long delay=
_ms,
-			     int exclude_cpu)
-{
-	unsigned long delay =3D msecs_to_jiffies(delay_ms);
-	int cpu;
-
-	cpu =3D cpumask_any_housekeeping(&dom->hdr.cpu_mask, exclude_cpu);
-	dom->cqm_work_cpu =3D cpu;
-
-	if (cpu < nr_cpu_ids)
-		schedule_delayed_work_on(cpu, &dom->cqm_limbo, delay);
-}
-
-void mbm_handle_overflow(struct work_struct *work)
-{
-	unsigned long delay =3D msecs_to_jiffies(MBM_OVERFLOW_INTERVAL);
-	struct rdtgroup *prgrp, *crgrp;
-	struct rdt_mon_domain *d;
-	struct list_head *head;
-	struct rdt_resource *r;
-
-	cpus_read_lock();
-	mutex_lock(&rdtgroup_mutex);
-
-	/*
-	 * If the filesystem has been unmounted this work no longer needs to
-	 * run.
-	 */
-	if (!resctrl_mounted || !resctrl_arch_mon_capable())
-		goto out_unlock;
-
-	r =3D resctrl_arch_get_resource(RDT_RESOURCE_L3);
-	d =3D container_of(work, struct rdt_mon_domain, mbm_over.work);
-
-	list_for_each_entry(prgrp, &rdt_all_groups, rdtgroup_list) {
-		mbm_update(r, d, prgrp->closid, prgrp->mon.rmid);
-
-		head =3D &prgrp->mon.crdtgrp_list;
-		list_for_each_entry(crgrp, head, mon.crdtgrp_list)
-			mbm_update(r, d, crgrp->closid, crgrp->mon.rmid);
-
-		if (is_mba_sc(NULL))
-			update_mba_bw(prgrp, d);
-	}
-
-	/*
-	 * Re-check for housekeeping CPUs. This allows the overflow handler to
-	 * move off a nohz_full CPU quickly.
-	 */
-	d->mbm_work_cpu =3D cpumask_any_housekeeping(&d->hdr.cpu_mask,
-						   RESCTRL_PICK_ANY_CPU);
-	schedule_delayed_work_on(d->mbm_work_cpu, &d->mbm_over, delay);
-
-out_unlock:
-	mutex_unlock(&rdtgroup_mutex);
-	cpus_read_unlock();
-}
-
-/**
- * mbm_setup_overflow_handler() - Schedule the overflow handler to run for t=
his
- *                                domain.
- * @dom:           The domain the overflow handler should run for.
- * @delay_ms:      How far in the future the handler should run.
- * @exclude_cpu:   Which CPU the handler should not run on,
- *		   RESCTRL_PICK_ANY_CPU to pick any CPU.
- */
-void mbm_setup_overflow_handler(struct rdt_mon_domain *dom, unsigned long de=
lay_ms,
-				int exclude_cpu)
-{
-	unsigned long delay =3D msecs_to_jiffies(delay_ms);
-	int cpu;
-
-	/*
-	 * When a domain comes online there is no guarantee the filesystem is
-	 * mounted. If not, there is no need to catch counter overflow.
-	 */
-	if (!resctrl_mounted || !resctrl_arch_mon_capable())
-		return;
-	cpu =3D cpumask_any_housekeeping(&dom->hdr.cpu_mask, exclude_cpu);
-	dom->mbm_work_cpu =3D cpu;
-
-	if (cpu < nr_cpu_ids)
-		schedule_delayed_work_on(cpu, &dom->mbm_over, delay);
-}
-
-static int dom_data_init(struct rdt_resource *r)
-{
-	u32 idx_limit =3D resctrl_arch_system_num_rmid_idx();
-	u32 num_closid =3D resctrl_arch_get_num_closid(r);
-	struct rmid_entry *entry =3D NULL;
-	int err =3D 0, i;
-	u32 idx;
-
-	mutex_lock(&rdtgroup_mutex);
-	if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID)) {
-		u32 *tmp;
-
-		/*
-		 * If the architecture hasn't provided a sanitised value here,
-		 * this may result in larger arrays than necessary. Resctrl will
-		 * use a smaller system wide value based on the resources in
-		 * use.
-		 */
-		tmp =3D kcalloc(num_closid, sizeof(*tmp), GFP_KERNEL);
-		if (!tmp) {
-			err =3D -ENOMEM;
-			goto out_unlock;
-		}
-
-		closid_num_dirty_rmid =3D tmp;
-	}
-
-	rmid_ptrs =3D kcalloc(idx_limit, sizeof(struct rmid_entry), GFP_KERNEL);
-	if (!rmid_ptrs) {
-		if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID)) {
-			kfree(closid_num_dirty_rmid);
-			closid_num_dirty_rmid =3D NULL;
-		}
-		err =3D -ENOMEM;
-		goto out_unlock;
-	}
-
-	for (i =3D 0; i < idx_limit; i++) {
-		entry =3D &rmid_ptrs[i];
-		INIT_LIST_HEAD(&entry->list);
-
-		resctrl_arch_rmid_idx_decode(i, &entry->closid, &entry->rmid);
-		list_add_tail(&entry->list, &rmid_free_lru);
-	}
-
-	/*
-	 * RESCTRL_RESERVED_CLOSID and RESCTRL_RESERVED_RMID are special and
-	 * are always allocated. These are used for the rdtgroup_default
-	 * control group, which will be setup later in resctrl_init().
-	 */
-	idx =3D resctrl_arch_rmid_idx_encode(RESCTRL_RESERVED_CLOSID,
-					   RESCTRL_RESERVED_RMID);
-	entry =3D __rmid_entry(idx);
-	list_del(&entry->list);
-
-out_unlock:
-	mutex_unlock(&rdtgroup_mutex);
-
-	return err;
-}
-
-static void dom_data_exit(struct rdt_resource *r)
-{
-	mutex_lock(&rdtgroup_mutex);
-
-	if (!r->mon_capable)
-		goto out_unlock;
-
-	if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID)) {
-		kfree(closid_num_dirty_rmid);
-		closid_num_dirty_rmid =3D NULL;
-	}
-
-	kfree(rmid_ptrs);
-	rmid_ptrs =3D NULL;
-
-out_unlock:
-	mutex_unlock(&rdtgroup_mutex);
-}
-
-static struct mon_evt llc_occupancy_event =3D {
-	.name		=3D "llc_occupancy",
-	.evtid		=3D QOS_L3_OCCUP_EVENT_ID,
-};
-
-static struct mon_evt mbm_total_event =3D {
-	.name		=3D "mbm_total_bytes",
-	.evtid		=3D QOS_L3_MBM_TOTAL_EVENT_ID,
-};
-
-static struct mon_evt mbm_local_event =3D {
-	.name		=3D "mbm_local_bytes",
-	.evtid		=3D QOS_L3_MBM_LOCAL_EVENT_ID,
-};
-
-/*
- * Initialize the event list for the resource.
- *
- * Note that MBM events are also part of RDT_RESOURCE_L3 resource
- * because as per the SDM the total and local memory bandwidth
- * are enumerated as part of L3 monitoring.
- */
-static void l3_mon_evt_init(struct rdt_resource *r)
-{
-	INIT_LIST_HEAD(&r->evt_list);
-
-	if (resctrl_arch_is_llc_occupancy_enabled())
-		list_add_tail(&llc_occupancy_event.list, &r->evt_list);
-	if (resctrl_arch_is_mbm_total_enabled())
-		list_add_tail(&mbm_total_event.list, &r->evt_list);
-	if (resctrl_arch_is_mbm_local_enabled())
-		list_add_tail(&mbm_local_event.list, &r->evt_list);
-}
-
 /*
  * The power-on reset value of MSR_RMID_SNC_CONFIG is 0x1
  * which indicates that RMIDs are configured in legacy mode.
@@ -1193,51 +340,6 @@ static __init int snc_get_config(void)
 	return ret;
 }
=20
-/**
- * resctrl_mon_resource_init() - Initialise global monitoring structures.
- *
- * Allocate and initialise global monitor resources that do not belong to a
- * specific domain. i.e. the rmid_ptrs[] used for the limbo and free lists.
- * Called once during boot after the struct rdt_resource's have been configu=
red
- * but before the filesystem is mounted.
- * Resctrl's cpuhp callbacks may be called before this point to bring a doma=
in
- * online.
- *
- * Returns 0 for success, or -ENOMEM.
- */
-int resctrl_mon_resource_init(void)
-{
-	struct rdt_resource *r =3D resctrl_arch_get_resource(RDT_RESOURCE_L3);
-	int ret;
-
-	if (!r->mon_capable)
-		return 0;
-
-	ret =3D dom_data_init(r);
-	if (ret)
-		return ret;
-
-	l3_mon_evt_init(r);
-
-	if (resctrl_arch_is_evt_configurable(QOS_L3_MBM_TOTAL_EVENT_ID)) {
-		mbm_total_event.configurable =3D true;
-		resctrl_file_fflags_init("mbm_total_bytes_config",
-					 RFTYPE_MON_INFO | RFTYPE_RES_CACHE);
-	}
-	if (resctrl_arch_is_evt_configurable(QOS_L3_MBM_LOCAL_EVENT_ID)) {
-		mbm_local_event.configurable =3D true;
-		resctrl_file_fflags_init("mbm_local_bytes_config",
-					 RFTYPE_MON_INFO | RFTYPE_RES_CACHE);
-	}
-
-	if (resctrl_arch_is_mbm_local_enabled())
-		mba_mbps_default_event =3D QOS_L3_MBM_LOCAL_EVENT_ID;
-	else if (resctrl_arch_is_mbm_total_enabled())
-		mba_mbps_default_event =3D QOS_L3_MBM_TOTAL_EVENT_ID;
-
-	return 0;
-}
-
 int __init rdt_get_mon_l3_config(struct rdt_resource *r)
 {
 	unsigned int mbm_offset =3D boot_cpu_data.x86_cache_mbm_width_offset;
@@ -1285,13 +387,6 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
 	return 0;
 }
=20
-void resctrl_mon_resource_exit(void)
-{
-	struct rdt_resource *r =3D resctrl_arch_get_resource(RDT_RESOURCE_L3);
-
-	dom_data_exit(r);
-}
-
 void __init intel_rdt_mbm_apply_quirk(void)
 {
 	int cf_index;
diff --git a/arch/x86/kernel/cpu/resctrl/monitor_trace.h b/arch/x86/kernel/cp=
u/resctrl/monitor_trace.h
deleted file mode 100644
index ade67da..0000000
--- a/arch/x86/kernel/cpu/resctrl/monitor_trace.h
+++ /dev/null
@@ -1,31 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#undef TRACE_SYSTEM
-#define TRACE_SYSTEM resctrl
-
-#if !defined(_FS_RESCTRL_MONITOR_TRACE_H) || defined(TRACE_HEADER_MULTI_READ)
-#define _FS_RESCTRL_MONITOR_TRACE_H
-
-#include <linux/tracepoint.h>
-
-TRACE_EVENT(mon_llc_occupancy_limbo,
-	    TP_PROTO(u32 ctrl_hw_id, u32 mon_hw_id, int domain_id, u64 llc_occupanc=
y_bytes),
-	    TP_ARGS(ctrl_hw_id, mon_hw_id, domain_id, llc_occupancy_bytes),
-	    TP_STRUCT__entry(__field(u32, ctrl_hw_id)
-			     __field(u32, mon_hw_id)
-			     __field(int, domain_id)
-			     __field(u64, llc_occupancy_bytes)),
-	    TP_fast_assign(__entry->ctrl_hw_id =3D ctrl_hw_id;
-			   __entry->mon_hw_id =3D mon_hw_id;
-			   __entry->domain_id =3D domain_id;
-			   __entry->llc_occupancy_bytes =3D llc_occupancy_bytes;),
-	    TP_printk("ctrl_hw_id=3D%u mon_hw_id=3D%u domain_id=3D%d llc_occupancy_=
bytes=3D%llu",
-		      __entry->ctrl_hw_id, __entry->mon_hw_id, __entry->domain_id,
-		      __entry->llc_occupancy_bytes)
-	   );
-
-#endif /* _FS_RESCTRL_MONITOR_TRACE_H */
-
-#undef TRACE_INCLUDE_PATH
-#define TRACE_INCLUDE_PATH .
-#define TRACE_INCLUDE_FILE monitor_trace
-#include <trace/define_trace.h>
diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/=
resctrl/pseudo_lock.c
index bb39ffd..241d0d7 100644
--- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
+++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
@@ -12,17 +12,10 @@
 #define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
=20
 #include <linux/cacheflush.h>
-#include <linux/cacheinfo.h>
 #include <linux/cpu.h>
-#include <linux/cpumask.h>
-#include <linux/debugfs.h>
-#include <linux/kthread.h>
-#include <linux/mman.h>
 #include <linux/perf_event.h>
 #include <linux/pm_qos.h>
 #include <linux/resctrl.h>
-#include <linux/slab.h>
-#include <linux/uaccess.h>
=20
 #include <asm/cpu_device_id.h>
 #include <asm/perf_event.h>
@@ -31,6 +24,7 @@
 #include "internal.h"
=20
 #define CREATE_TRACE_POINTS
+
 #include "pseudo_lock_trace.h"
=20
 /*
@@ -39,29 +33,6 @@
  */
 static u64 prefetch_disable_bits;
=20
-/*
- * Major number assigned to and shared by all devices exposing
- * pseudo-locked regions.
- */
-static unsigned int pseudo_lock_major;
-static unsigned long pseudo_lock_minor_avail =3D GENMASK(MINORBITS, 0);
-
-static char *pseudo_lock_devnode(const struct device *dev, umode_t *mode)
-{
-	const struct rdtgroup *rdtgrp;
-
-	rdtgrp =3D dev_get_drvdata(dev);
-	if (mode)
-		*mode =3D 0600;
-	guard(mutex)(&rdtgroup_mutex);
-	return kasprintf(GFP_KERNEL, "pseudo_lock/%s", rdt_kn_name(rdtgrp->kn));
-}
-
-static const struct class pseudo_lock_class =3D {
-	.name =3D "pseudo_lock",
-	.devnode =3D pseudo_lock_devnode,
-};
-
 /**
  * resctrl_arch_get_prefetch_disable_bits - prefetch disable bits of support=
ed
  *                                          platforms
@@ -123,298 +94,6 @@ u64 resctrl_arch_get_prefetch_disable_bits(void)
 }
=20
 /**
- * pseudo_lock_minor_get - Obtain available minor number
- * @minor: Pointer to where new minor number will be stored
- *
- * A bitmask is used to track available minor numbers. Here the next free
- * minor number is marked as unavailable and returned.
- *
- * Return: 0 on success, <0 on failure.
- */
-static int pseudo_lock_minor_get(unsigned int *minor)
-{
-	unsigned long first_bit;
-
-	first_bit =3D find_first_bit(&pseudo_lock_minor_avail, MINORBITS);
-
-	if (first_bit =3D=3D MINORBITS)
-		return -ENOSPC;
-
-	__clear_bit(first_bit, &pseudo_lock_minor_avail);
-	*minor =3D first_bit;
-
-	return 0;
-}
-
-/**
- * pseudo_lock_minor_release - Return minor number to available
- * @minor: The minor number made available
- */
-static void pseudo_lock_minor_release(unsigned int minor)
-{
-	__set_bit(minor, &pseudo_lock_minor_avail);
-}
-
-/**
- * region_find_by_minor - Locate a pseudo-lock region by inode minor number
- * @minor: The minor number of the device representing pseudo-locked region
- *
- * When the character device is accessed we need to determine which
- * pseudo-locked region it belongs to. This is done by matching the minor
- * number of the device to the pseudo-locked region it belongs.
- *
- * Minor numbers are assigned at the time a pseudo-locked region is associat=
ed
- * with a cache instance.
- *
- * Return: On success return pointer to resource group owning the pseudo-loc=
ked
- *         region, NULL on failure.
- */
-static struct rdtgroup *region_find_by_minor(unsigned int minor)
-{
-	struct rdtgroup *rdtgrp, *rdtgrp_match =3D NULL;
-
-	list_for_each_entry(rdtgrp, &rdt_all_groups, rdtgroup_list) {
-		if (rdtgrp->plr && rdtgrp->plr->minor =3D=3D minor) {
-			rdtgrp_match =3D rdtgrp;
-			break;
-		}
-	}
-	return rdtgrp_match;
-}
-
-/**
- * struct pseudo_lock_pm_req - A power management QoS request list entry
- * @list:	Entry within the @pm_reqs list for a pseudo-locked region
- * @req:	PM QoS request
- */
-struct pseudo_lock_pm_req {
-	struct list_head list;
-	struct dev_pm_qos_request req;
-};
-
-static void pseudo_lock_cstates_relax(struct pseudo_lock_region *plr)
-{
-	struct pseudo_lock_pm_req *pm_req, *next;
-
-	list_for_each_entry_safe(pm_req, next, &plr->pm_reqs, list) {
-		dev_pm_qos_remove_request(&pm_req->req);
-		list_del(&pm_req->list);
-		kfree(pm_req);
-	}
-}
-
-/**
- * pseudo_lock_cstates_constrain - Restrict cores from entering C6
- * @plr: Pseudo-locked region
- *
- * To prevent the cache from being affected by power management entering
- * C6 has to be avoided. This is accomplished by requesting a latency
- * requirement lower than lowest C6 exit latency of all supported
- * platforms as found in the cpuidle state tables in the intel_idle driver.
- * At this time it is possible to do so with a single latency requirement
- * for all supported platforms.
- *
- * Since Goldmont is supported, which is affected by X86_BUG_MONITOR,
- * the ACPI latencies need to be considered while keeping in mind that C2
- * may be set to map to deeper sleep states. In this case the latency
- * requirement needs to prevent entering C2 also.
- *
- * Return: 0 on success, <0 on failure
- */
-static int pseudo_lock_cstates_constrain(struct pseudo_lock_region *plr)
-{
-	struct pseudo_lock_pm_req *pm_req;
-	int cpu;
-	int ret;
-
-	for_each_cpu(cpu, &plr->d->hdr.cpu_mask) {
-		pm_req =3D kzalloc(sizeof(*pm_req), GFP_KERNEL);
-		if (!pm_req) {
-			rdt_last_cmd_puts("Failure to allocate memory for PM QoS\n");
-			ret =3D -ENOMEM;
-			goto out_err;
-		}
-		ret =3D dev_pm_qos_add_request(get_cpu_device(cpu),
-					     &pm_req->req,
-					     DEV_PM_QOS_RESUME_LATENCY,
-					     30);
-		if (ret < 0) {
-			rdt_last_cmd_printf("Failed to add latency req CPU%d\n",
-					    cpu);
-			kfree(pm_req);
-			ret =3D -1;
-			goto out_err;
-		}
-		list_add(&pm_req->list, &plr->pm_reqs);
-	}
-
-	return 0;
-
-out_err:
-	pseudo_lock_cstates_relax(plr);
-	return ret;
-}
-
-/**
- * pseudo_lock_region_clear - Reset pseudo-lock region data
- * @plr: pseudo-lock region
- *
- * All content of the pseudo-locked region is reset - any memory allocated
- * freed.
- *
- * Return: void
- */
-static void pseudo_lock_region_clear(struct pseudo_lock_region *plr)
-{
-	plr->size =3D 0;
-	plr->line_size =3D 0;
-	kfree(plr->kmem);
-	plr->kmem =3D NULL;
-	plr->s =3D NULL;
-	if (plr->d)
-		plr->d->plr =3D NULL;
-	plr->d =3D NULL;
-	plr->cbm =3D 0;
-	plr->debugfs_dir =3D NULL;
-}
-
-/**
- * pseudo_lock_region_init - Initialize pseudo-lock region information
- * @plr: pseudo-lock region
- *
- * Called after user provided a schemata to be pseudo-locked. From the
- * schemata the &struct pseudo_lock_region is on entry already initialized
- * with the resource, domain, and capacity bitmask. Here the information
- * required for pseudo-locking is deduced from this data and &struct
- * pseudo_lock_region initialized further. This information includes:
- * - size in bytes of the region to be pseudo-locked
- * - cache line size to know the stride with which data needs to be accessed
- *   to be pseudo-locked
- * - a cpu associated with the cache instance on which the pseudo-locking
- *   flow can be executed
- *
- * Return: 0 on success, <0 on failure. Descriptive error will be written
- * to last_cmd_status buffer.
- */
-static int pseudo_lock_region_init(struct pseudo_lock_region *plr)
-{
-	enum resctrl_scope scope =3D plr->s->res->ctrl_scope;
-	struct cacheinfo *ci;
-	int ret;
-
-	if (WARN_ON_ONCE(scope !=3D RESCTRL_L2_CACHE && scope !=3D RESCTRL_L3_CACHE=
))
-		return -ENODEV;
-
-	/* Pick the first cpu we find that is associated with the cache. */
-	plr->cpu =3D cpumask_first(&plr->d->hdr.cpu_mask);
-
-	if (!cpu_online(plr->cpu)) {
-		rdt_last_cmd_printf("CPU %u associated with cache not online\n",
-				    plr->cpu);
-		ret =3D -ENODEV;
-		goto out_region;
-	}
-
-	ci =3D get_cpu_cacheinfo_level(plr->cpu, scope);
-	if (ci) {
-		plr->line_size =3D ci->coherency_line_size;
-		plr->size =3D rdtgroup_cbm_to_size(plr->s->res, plr->d, plr->cbm);
-		return 0;
-	}
-
-	ret =3D -1;
-	rdt_last_cmd_puts("Unable to determine cache line size\n");
-out_region:
-	pseudo_lock_region_clear(plr);
-	return ret;
-}
-
-/**
- * pseudo_lock_init - Initialize a pseudo-lock region
- * @rdtgrp: resource group to which new pseudo-locked region will belong
- *
- * A pseudo-locked region is associated with a resource group. When this
- * association is created the pseudo-locked region is initialized. The
- * details of the pseudo-locked region are not known at this time so only
- * allocation is done and association established.
- *
- * Return: 0 on success, <0 on failure
- */
-static int pseudo_lock_init(struct rdtgroup *rdtgrp)
-{
-	struct pseudo_lock_region *plr;
-
-	plr =3D kzalloc(sizeof(*plr), GFP_KERNEL);
-	if (!plr)
-		return -ENOMEM;
-
-	init_waitqueue_head(&plr->lock_thread_wq);
-	INIT_LIST_HEAD(&plr->pm_reqs);
-	rdtgrp->plr =3D plr;
-	return 0;
-}
-
-/**
- * pseudo_lock_region_alloc - Allocate kernel memory that will be pseudo-loc=
ked
- * @plr: pseudo-lock region
- *
- * Initialize the details required to set up the pseudo-locked region and
- * allocate the contiguous memory that will be pseudo-locked to the cache.
- *
- * Return: 0 on success, <0 on failure.  Descriptive error will be written
- * to last_cmd_status buffer.
- */
-static int pseudo_lock_region_alloc(struct pseudo_lock_region *plr)
-{
-	int ret;
-
-	ret =3D pseudo_lock_region_init(plr);
-	if (ret < 0)
-		return ret;
-
-	/*
-	 * We do not yet support contiguous regions larger than
-	 * KMALLOC_MAX_SIZE.
-	 */
-	if (plr->size > KMALLOC_MAX_SIZE) {
-		rdt_last_cmd_puts("Requested region exceeds maximum size\n");
-		ret =3D -E2BIG;
-		goto out_region;
-	}
-
-	plr->kmem =3D kzalloc(plr->size, GFP_KERNEL);
-	if (!plr->kmem) {
-		rdt_last_cmd_puts("Unable to allocate memory\n");
-		ret =3D -ENOMEM;
-		goto out_region;
-	}
-
-	ret =3D 0;
-	goto out;
-out_region:
-	pseudo_lock_region_clear(plr);
-out:
-	return ret;
-}
-
-/**
- * pseudo_lock_free - Free a pseudo-locked region
- * @rdtgrp: resource group to which pseudo-locked region belonged
- *
- * The pseudo-locked region's resources have already been released, or not
- * yet created at this point. Now it can be freed and disassociated from the
- * resource group.
- *
- * Return: void
- */
-static void pseudo_lock_free(struct rdtgroup *rdtgrp)
-{
-	pseudo_lock_region_clear(rdtgrp->plr);
-	kfree(rdtgrp->plr);
-	rdtgrp->plr =3D NULL;
-}
-
-/**
  * resctrl_arch_pseudo_lock_fn - Load kernel memory into cache
  * @_plr: the pseudo-lock region descriptor
  *
@@ -544,340 +223,6 @@ int resctrl_arch_pseudo_lock_fn(void *_plr)
 }
=20
 /**
- * rdtgroup_monitor_in_progress - Test if monitoring in progress
- * @rdtgrp: resource group being queried
- *
- * Return: 1 if monitor groups have been created for this resource
- * group, 0 otherwise.
- */
-static int rdtgroup_monitor_in_progress(struct rdtgroup *rdtgrp)
-{
-	return !list_empty(&rdtgrp->mon.crdtgrp_list);
-}
-
-/**
- * rdtgroup_locksetup_user_restrict - Restrict user access to group
- * @rdtgrp: resource group needing access restricted
- *
- * A resource group used for cache pseudo-locking cannot have cpus or tasks
- * assigned to it. This is communicated to the user by restricting access
- * to all the files that can be used to make such changes.
- *
- * Permissions restored with rdtgroup_locksetup_user_restore()
- *
- * Return: 0 on success, <0 on failure. If a failure occurs during the
- * restriction of access an attempt will be made to restore permissions but
- * the state of the mode of these files will be uncertain when a failure
- * occurs.
- */
-static int rdtgroup_locksetup_user_restrict(struct rdtgroup *rdtgrp)
-{
-	int ret;
-
-	ret =3D rdtgroup_kn_mode_restrict(rdtgrp, "tasks");
-	if (ret)
-		return ret;
-
-	ret =3D rdtgroup_kn_mode_restrict(rdtgrp, "cpus");
-	if (ret)
-		goto err_tasks;
-
-	ret =3D rdtgroup_kn_mode_restrict(rdtgrp, "cpus_list");
-	if (ret)
-		goto err_cpus;
-
-	if (resctrl_arch_mon_capable()) {
-		ret =3D rdtgroup_kn_mode_restrict(rdtgrp, "mon_groups");
-		if (ret)
-			goto err_cpus_list;
-	}
-
-	ret =3D 0;
-	goto out;
-
-err_cpus_list:
-	rdtgroup_kn_mode_restore(rdtgrp, "cpus_list", 0777);
-err_cpus:
-	rdtgroup_kn_mode_restore(rdtgrp, "cpus", 0777);
-err_tasks:
-	rdtgroup_kn_mode_restore(rdtgrp, "tasks", 0777);
-out:
-	return ret;
-}
-
-/**
- * rdtgroup_locksetup_user_restore - Restore user access to group
- * @rdtgrp: resource group needing access restored
- *
- * Restore all file access previously removed using
- * rdtgroup_locksetup_user_restrict()
- *
- * Return: 0 on success, <0 on failure.  If a failure occurs during the
- * restoration of access an attempt will be made to restrict permissions
- * again but the state of the mode of these files will be uncertain when
- * a failure occurs.
- */
-static int rdtgroup_locksetup_user_restore(struct rdtgroup *rdtgrp)
-{
-	int ret;
-
-	ret =3D rdtgroup_kn_mode_restore(rdtgrp, "tasks", 0777);
-	if (ret)
-		return ret;
-
-	ret =3D rdtgroup_kn_mode_restore(rdtgrp, "cpus", 0777);
-	if (ret)
-		goto err_tasks;
-
-	ret =3D rdtgroup_kn_mode_restore(rdtgrp, "cpus_list", 0777);
-	if (ret)
-		goto err_cpus;
-
-	if (resctrl_arch_mon_capable()) {
-		ret =3D rdtgroup_kn_mode_restore(rdtgrp, "mon_groups", 0777);
-		if (ret)
-			goto err_cpus_list;
-	}
-
-	ret =3D 0;
-	goto out;
-
-err_cpus_list:
-	rdtgroup_kn_mode_restrict(rdtgrp, "cpus_list");
-err_cpus:
-	rdtgroup_kn_mode_restrict(rdtgrp, "cpus");
-err_tasks:
-	rdtgroup_kn_mode_restrict(rdtgrp, "tasks");
-out:
-	return ret;
-}
-
-/**
- * rdtgroup_locksetup_enter - Resource group enters locksetup mode
- * @rdtgrp: resource group requested to enter locksetup mode
- *
- * A resource group enters locksetup mode to reflect that it would be used
- * to represent a pseudo-locked region and is in the process of being set
- * up to do so. A resource group used for a pseudo-locked region would
- * lose the closid associated with it so we cannot allow it to have any
- * tasks or cpus assigned nor permit tasks or cpus to be assigned in the
- * future. Monitoring of a pseudo-locked region is not allowed either.
- *
- * The above and more restrictions on a pseudo-locked region are checked
- * for and enforced before the resource group enters the locksetup mode.
- *
- * Returns: 0 if the resource group successfully entered locksetup mode, <0
- * on failure. On failure the last_cmd_status buffer is updated with text to
- * communicate details of failure to the user.
- */
-int rdtgroup_locksetup_enter(struct rdtgroup *rdtgrp)
-{
-	int ret;
-
-	/*
-	 * The default resource group can neither be removed nor lose the
-	 * default closid associated with it.
-	 */
-	if (rdtgrp =3D=3D &rdtgroup_default) {
-		rdt_last_cmd_puts("Cannot pseudo-lock default group\n");
-		return -EINVAL;
-	}
-
-	/*
-	 * Cache Pseudo-locking not supported when CDP is enabled.
-	 *
-	 * Some things to consider if you would like to enable this
-	 * support (using L3 CDP as example):
-	 * - When CDP is enabled two separate resources are exposed,
-	 *   L3DATA and L3CODE, but they are actually on the same cache.
-	 *   The implication for pseudo-locking is that if a
-	 *   pseudo-locked region is created on a domain of one
-	 *   resource (eg. L3CODE), then a pseudo-locked region cannot
-	 *   be created on that same domain of the other resource
-	 *   (eg. L3DATA). This is because the creation of a
-	 *   pseudo-locked region involves a call to wbinvd that will
-	 *   affect all cache allocations on particular domain.
-	 * - Considering the previous, it may be possible to only
-	 *   expose one of the CDP resources to pseudo-locking and
-	 *   hide the other. For example, we could consider to only
-	 *   expose L3DATA and since the L3 cache is unified it is
-	 *   still possible to place instructions there are execute it.
-	 * - If only one region is exposed to pseudo-locking we should
-	 *   still keep in mind that availability of a portion of cache
-	 *   for pseudo-locking should take into account both resources.
-	 *   Similarly, if a pseudo-locked region is created in one
-	 *   resource, the portion of cache used by it should be made
-	 *   unavailable to all future allocations from both resources.
-	 */
-	if (resctrl_arch_get_cdp_enabled(RDT_RESOURCE_L3) ||
-	    resctrl_arch_get_cdp_enabled(RDT_RESOURCE_L2)) {
-		rdt_last_cmd_puts("CDP enabled\n");
-		return -EINVAL;
-	}
-
-	/*
-	 * Not knowing the bits to disable prefetching implies that this
-	 * platform does not support Cache Pseudo-Locking.
-	 */
-	if (resctrl_arch_get_prefetch_disable_bits() =3D=3D 0) {
-		rdt_last_cmd_puts("Pseudo-locking not supported\n");
-		return -EINVAL;
-	}
-
-	if (rdtgroup_monitor_in_progress(rdtgrp)) {
-		rdt_last_cmd_puts("Monitoring in progress\n");
-		return -EINVAL;
-	}
-
-	if (rdtgroup_tasks_assigned(rdtgrp)) {
-		rdt_last_cmd_puts("Tasks assigned to resource group\n");
-		return -EINVAL;
-	}
-
-	if (!cpumask_empty(&rdtgrp->cpu_mask)) {
-		rdt_last_cmd_puts("CPUs assigned to resource group\n");
-		return -EINVAL;
-	}
-
-	if (rdtgroup_locksetup_user_restrict(rdtgrp)) {
-		rdt_last_cmd_puts("Unable to modify resctrl permissions\n");
-		return -EIO;
-	}
-
-	ret =3D pseudo_lock_init(rdtgrp);
-	if (ret) {
-		rdt_last_cmd_puts("Unable to init pseudo-lock region\n");
-		goto out_release;
-	}
-
-	/*
-	 * If this system is capable of monitoring a rmid would have been
-	 * allocated when the control group was created. This is not needed
-	 * anymore when this group would be used for pseudo-locking. This
-	 * is safe to call on platforms not capable of monitoring.
-	 */
-	free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
-
-	ret =3D 0;
-	goto out;
-
-out_release:
-	rdtgroup_locksetup_user_restore(rdtgrp);
-out:
-	return ret;
-}
-
-/**
- * rdtgroup_locksetup_exit - resource group exist locksetup mode
- * @rdtgrp: resource group
- *
- * When a resource group exits locksetup mode the earlier restrictions are
- * lifted.
- *
- * Return: 0 on success, <0 on failure
- */
-int rdtgroup_locksetup_exit(struct rdtgroup *rdtgrp)
-{
-	int ret;
-
-	if (resctrl_arch_mon_capable()) {
-		ret =3D alloc_rmid(rdtgrp->closid);
-		if (ret < 0) {
-			rdt_last_cmd_puts("Out of RMIDs\n");
-			return ret;
-		}
-		rdtgrp->mon.rmid =3D ret;
-	}
-
-	ret =3D rdtgroup_locksetup_user_restore(rdtgrp);
-	if (ret) {
-		free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
-		return ret;
-	}
-
-	pseudo_lock_free(rdtgrp);
-	return 0;
-}
-
-/**
- * rdtgroup_cbm_overlaps_pseudo_locked - Test if CBM or portion is pseudo-lo=
cked
- * @d: RDT domain
- * @cbm: CBM to test
- *
- * @d represents a cache instance and @cbm a capacity bitmask that is
- * considered for it. Determine if @cbm overlaps with any existing
- * pseudo-locked region on @d.
- *
- * @cbm is unsigned long, even if only 32 bits are used, to make the
- * bitmap functions work correctly.
- *
- * Return: true if @cbm overlaps with pseudo-locked region on @d, false
- * otherwise.
- */
-bool rdtgroup_cbm_overlaps_pseudo_locked(struct rdt_ctrl_domain *d, unsigned=
 long cbm)
-{
-	unsigned int cbm_len;
-	unsigned long cbm_b;
-
-	if (d->plr) {
-		cbm_len =3D d->plr->s->res->cache.cbm_len;
-		cbm_b =3D d->plr->cbm;
-		if (bitmap_intersects(&cbm, &cbm_b, cbm_len))
-			return true;
-	}
-	return false;
-}
-
-/**
- * rdtgroup_pseudo_locked_in_hierarchy - Pseudo-locked region in cache hiera=
rchy
- * @d: RDT domain under test
- *
- * The setup of a pseudo-locked region affects all cache instances within
- * the hierarchy of the region. It is thus essential to know if any
- * pseudo-locked regions exist within a cache hierarchy to prevent any
- * attempts to create new pseudo-locked regions in the same hierarchy.
- *
- * Return: true if a pseudo-locked region exists in the hierarchy of @d or
- *         if it is not possible to test due to memory allocation issue,
- *         false otherwise.
- */
-bool rdtgroup_pseudo_locked_in_hierarchy(struct rdt_ctrl_domain *d)
-{
-	struct rdt_ctrl_domain *d_i;
-	cpumask_var_t cpu_with_psl;
-	struct rdt_resource *r;
-	bool ret =3D false;
-
-	/* Walking r->domains, ensure it can't race with cpuhp */
-	lockdep_assert_cpus_held();
-
-	if (!zalloc_cpumask_var(&cpu_with_psl, GFP_KERNEL))
-		return true;
-
-	/*
-	 * First determine which cpus have pseudo-locked regions
-	 * associated with them.
-	 */
-	for_each_alloc_capable_rdt_resource(r) {
-		list_for_each_entry(d_i, &r->ctrl_domains, hdr.list) {
-			if (d_i->plr)
-				cpumask_or(cpu_with_psl, cpu_with_psl,
-					   &d_i->hdr.cpu_mask);
-		}
-	}
-
-	/*
-	 * Next test if new pseudo-locked region would intersect with
-	 * existing region.
-	 */
-	if (cpumask_intersects(&d->hdr.cpu_mask, cpu_with_psl))
-		ret =3D true;
-
-	free_cpumask_var(cpu_with_psl);
-	return ret;
-}
-
-/**
  * resctrl_arch_measure_cycles_lat_fn - Measure cycle latency to read
  *                                      pseudo-locked memory
  * @_plr: pseudo-lock region to measure
@@ -1169,433 +514,3 @@ out:
 	wake_up_interruptible(&plr->lock_thread_wq);
 	return 0;
 }
-
-/**
- * pseudo_lock_measure_cycles - Trigger latency measure to pseudo-locked reg=
ion
- * @rdtgrp: Resource group to which the pseudo-locked region belongs.
- * @sel: Selector of which measurement to perform on a pseudo-locked region.
- *
- * The measurement of latency to access a pseudo-locked region should be
- * done from a cpu that is associated with that pseudo-locked region.
- * Determine which cpu is associated with this region and start a thread on
- * that cpu to perform the measurement, wait for that thread to complete.
- *
- * Return: 0 on success, <0 on failure
- */
-static int pseudo_lock_measure_cycles(struct rdtgroup *rdtgrp, int sel)
-{
-	struct pseudo_lock_region *plr =3D rdtgrp->plr;
-	struct task_struct *thread;
-	unsigned int cpu;
-	int ret =3D -1;
-
-	cpus_read_lock();
-	mutex_lock(&rdtgroup_mutex);
-
-	if (rdtgrp->flags & RDT_DELETED) {
-		ret =3D -ENODEV;
-		goto out;
-	}
-
-	if (!plr->d) {
-		ret =3D -ENODEV;
-		goto out;
-	}
-
-	plr->thread_done =3D 0;
-	cpu =3D cpumask_first(&plr->d->hdr.cpu_mask);
-	if (!cpu_online(cpu)) {
-		ret =3D -ENODEV;
-		goto out;
-	}
-
-	plr->cpu =3D cpu;
-
-	if (sel =3D=3D 1)
-		thread =3D kthread_run_on_cpu(resctrl_arch_measure_cycles_lat_fn,
-					    plr, cpu, "pseudo_lock_measure/%u");
-	else if (sel =3D=3D 2)
-		thread =3D kthread_run_on_cpu(resctrl_arch_measure_l2_residency,
-					    plr, cpu, "pseudo_lock_measure/%u");
-	else if (sel =3D=3D 3)
-		thread =3D kthread_run_on_cpu(resctrl_arch_measure_l3_residency,
-					    plr, cpu, "pseudo_lock_measure/%u");
-	else
-		goto out;
-
-	if (IS_ERR(thread)) {
-		ret =3D PTR_ERR(thread);
-		goto out;
-	}
-
-	ret =3D wait_event_interruptible(plr->lock_thread_wq,
-				       plr->thread_done =3D=3D 1);
-	if (ret < 0)
-		goto out;
-
-	ret =3D 0;
-
-out:
-	mutex_unlock(&rdtgroup_mutex);
-	cpus_read_unlock();
-	return ret;
-}
-
-static ssize_t pseudo_lock_measure_trigger(struct file *file,
-					   const char __user *user_buf,
-					   size_t count, loff_t *ppos)
-{
-	struct rdtgroup *rdtgrp =3D file->private_data;
-	size_t buf_size;
-	char buf[32];
-	int ret;
-	int sel;
-
-	buf_size =3D min(count, (sizeof(buf) - 1));
-	if (copy_from_user(buf, user_buf, buf_size))
-		return -EFAULT;
-
-	buf[buf_size] =3D '\0';
-	ret =3D kstrtoint(buf, 10, &sel);
-	if (ret =3D=3D 0) {
-		if (sel !=3D 1 && sel !=3D 2 && sel !=3D 3)
-			return -EINVAL;
-		ret =3D debugfs_file_get(file->f_path.dentry);
-		if (ret)
-			return ret;
-		ret =3D pseudo_lock_measure_cycles(rdtgrp, sel);
-		if (ret =3D=3D 0)
-			ret =3D count;
-		debugfs_file_put(file->f_path.dentry);
-	}
-
-	return ret;
-}
-
-static const struct file_operations pseudo_measure_fops =3D {
-	.write =3D pseudo_lock_measure_trigger,
-	.open =3D simple_open,
-	.llseek =3D default_llseek,
-};
-
-/**
- * rdtgroup_pseudo_lock_create - Create a pseudo-locked region
- * @rdtgrp: resource group to which pseudo-lock region belongs
- *
- * Called when a resource group in the pseudo-locksetup mode receives a
- * valid schemata that should be pseudo-locked. Since the resource group is
- * in pseudo-locksetup mode the &struct pseudo_lock_region has already been
- * allocated and initialized with the essential information. If a failure
- * occurs the resource group remains in the pseudo-locksetup mode with the
- * &struct pseudo_lock_region associated with it, but cleared from all
- * information and ready for the user to re-attempt pseudo-locking by
- * writing the schemata again.
- *
- * Return: 0 if the pseudo-locked region was successfully pseudo-locked, <0
- * on failure. Descriptive error will be written to last_cmd_status buffer.
- */
-int rdtgroup_pseudo_lock_create(struct rdtgroup *rdtgrp)
-{
-	struct pseudo_lock_region *plr =3D rdtgrp->plr;
-	struct task_struct *thread;
-	unsigned int new_minor;
-	struct device *dev;
-	char *kn_name __free(kfree) =3D NULL;
-	int ret;
-
-	ret =3D pseudo_lock_region_alloc(plr);
-	if (ret < 0)
-		return ret;
-
-	ret =3D pseudo_lock_cstates_constrain(plr);
-	if (ret < 0) {
-		ret =3D -EINVAL;
-		goto out_region;
-	}
-	kn_name =3D kstrdup(rdt_kn_name(rdtgrp->kn), GFP_KERNEL);
-	if (!kn_name) {
-		ret =3D -ENOMEM;
-		goto out_cstates;
-	}
-
-	plr->thread_done =3D 0;
-
-	thread =3D kthread_run_on_cpu(resctrl_arch_pseudo_lock_fn, plr,
-				    plr->cpu, "pseudo_lock/%u");
-	if (IS_ERR(thread)) {
-		ret =3D PTR_ERR(thread);
-		rdt_last_cmd_printf("Locking thread returned error %d\n", ret);
-		goto out_cstates;
-	}
-
-	ret =3D wait_event_interruptible(plr->lock_thread_wq,
-				       plr->thread_done =3D=3D 1);
-	if (ret < 0) {
-		/*
-		 * If the thread does not get on the CPU for whatever
-		 * reason and the process which sets up the region is
-		 * interrupted then this will leave the thread in runnable
-		 * state and once it gets on the CPU it will dereference
-		 * the cleared, but not freed, plr struct resulting in an
-		 * empty pseudo-locking loop.
-		 */
-		rdt_last_cmd_puts("Locking thread interrupted\n");
-		goto out_cstates;
-	}
-
-	ret =3D pseudo_lock_minor_get(&new_minor);
-	if (ret < 0) {
-		rdt_last_cmd_puts("Unable to obtain a new minor number\n");
-		goto out_cstates;
-	}
-
-	/*
-	 * Unlock access but do not release the reference. The
-	 * pseudo-locked region will still be here on return.
-	 *
-	 * The mutex has to be released temporarily to avoid a potential
-	 * deadlock with the mm->mmap_lock which is obtained in the
-	 * device_create() and debugfs_create_dir() callpath below as well as
-	 * before the mmap() callback is called.
-	 */
-	mutex_unlock(&rdtgroup_mutex);
-
-	if (!IS_ERR_OR_NULL(debugfs_resctrl)) {
-		plr->debugfs_dir =3D debugfs_create_dir(kn_name, debugfs_resctrl);
-		if (!IS_ERR_OR_NULL(plr->debugfs_dir))
-			debugfs_create_file("pseudo_lock_measure", 0200,
-					    plr->debugfs_dir, rdtgrp,
-					    &pseudo_measure_fops);
-	}
-
-	dev =3D device_create(&pseudo_lock_class, NULL,
-			    MKDEV(pseudo_lock_major, new_minor),
-			    rdtgrp, "%s", kn_name);
-
-	mutex_lock(&rdtgroup_mutex);
-
-	if (IS_ERR(dev)) {
-		ret =3D PTR_ERR(dev);
-		rdt_last_cmd_printf("Failed to create character device: %d\n",
-				    ret);
-		goto out_debugfs;
-	}
-
-	/* We released the mutex - check if group was removed while we did so */
-	if (rdtgrp->flags & RDT_DELETED) {
-		ret =3D -ENODEV;
-		goto out_device;
-	}
-
-	plr->minor =3D new_minor;
-
-	rdtgrp->mode =3D RDT_MODE_PSEUDO_LOCKED;
-	closid_free(rdtgrp->closid);
-	rdtgroup_kn_mode_restore(rdtgrp, "cpus", 0444);
-	rdtgroup_kn_mode_restore(rdtgrp, "cpus_list", 0444);
-
-	ret =3D 0;
-	goto out;
-
-out_device:
-	device_destroy(&pseudo_lock_class, MKDEV(pseudo_lock_major, new_minor));
-out_debugfs:
-	debugfs_remove_recursive(plr->debugfs_dir);
-	pseudo_lock_minor_release(new_minor);
-out_cstates:
-	pseudo_lock_cstates_relax(plr);
-out_region:
-	pseudo_lock_region_clear(plr);
-out:
-	return ret;
-}
-
-/**
- * rdtgroup_pseudo_lock_remove - Remove a pseudo-locked region
- * @rdtgrp: resource group to which the pseudo-locked region belongs
- *
- * The removal of a pseudo-locked region can be initiated when the resource
- * group is removed from user space via a "rmdir" from userspace or the
- * unmount of the resctrl filesystem. On removal the resource group does
- * not go back to pseudo-locksetup mode before it is removed, instead it is
- * removed directly. There is thus asymmetry with the creation where the
- * &struct pseudo_lock_region is removed here while it was not created in
- * rdtgroup_pseudo_lock_create().
- *
- * Return: void
- */
-void rdtgroup_pseudo_lock_remove(struct rdtgroup *rdtgrp)
-{
-	struct pseudo_lock_region *plr =3D rdtgrp->plr;
-
-	if (rdtgrp->mode =3D=3D RDT_MODE_PSEUDO_LOCKSETUP) {
-		/*
-		 * Default group cannot be a pseudo-locked region so we can
-		 * free closid here.
-		 */
-		closid_free(rdtgrp->closid);
-		goto free;
-	}
-
-	pseudo_lock_cstates_relax(plr);
-	debugfs_remove_recursive(rdtgrp->plr->debugfs_dir);
-	device_destroy(&pseudo_lock_class, MKDEV(pseudo_lock_major, plr->minor));
-	pseudo_lock_minor_release(plr->minor);
-
-free:
-	pseudo_lock_free(rdtgrp);
-}
-
-static int pseudo_lock_dev_open(struct inode *inode, struct file *filp)
-{
-	struct rdtgroup *rdtgrp;
-
-	mutex_lock(&rdtgroup_mutex);
-
-	rdtgrp =3D region_find_by_minor(iminor(inode));
-	if (!rdtgrp) {
-		mutex_unlock(&rdtgroup_mutex);
-		return -ENODEV;
-	}
-
-	filp->private_data =3D rdtgrp;
-	atomic_inc(&rdtgrp->waitcount);
-	/* Perform a non-seekable open - llseek is not supported */
-	filp->f_mode &=3D ~(FMODE_LSEEK | FMODE_PREAD | FMODE_PWRITE);
-
-	mutex_unlock(&rdtgroup_mutex);
-
-	return 0;
-}
-
-static int pseudo_lock_dev_release(struct inode *inode, struct file *filp)
-{
-	struct rdtgroup *rdtgrp;
-
-	mutex_lock(&rdtgroup_mutex);
-	rdtgrp =3D filp->private_data;
-	WARN_ON(!rdtgrp);
-	if (!rdtgrp) {
-		mutex_unlock(&rdtgroup_mutex);
-		return -ENODEV;
-	}
-	filp->private_data =3D NULL;
-	atomic_dec(&rdtgrp->waitcount);
-	mutex_unlock(&rdtgroup_mutex);
-	return 0;
-}
-
-static int pseudo_lock_dev_mremap(struct vm_area_struct *area)
-{
-	/* Not supported */
-	return -EINVAL;
-}
-
-static const struct vm_operations_struct pseudo_mmap_ops =3D {
-	.mremap =3D pseudo_lock_dev_mremap,
-};
-
-static int pseudo_lock_dev_mmap(struct file *filp, struct vm_area_struct *vm=
a)
-{
-	unsigned long vsize =3D vma->vm_end - vma->vm_start;
-	unsigned long off =3D vma->vm_pgoff << PAGE_SHIFT;
-	struct pseudo_lock_region *plr;
-	struct rdtgroup *rdtgrp;
-	unsigned long physical;
-	unsigned long psize;
-
-	mutex_lock(&rdtgroup_mutex);
-
-	rdtgrp =3D filp->private_data;
-	WARN_ON(!rdtgrp);
-	if (!rdtgrp) {
-		mutex_unlock(&rdtgroup_mutex);
-		return -ENODEV;
-	}
-
-	plr =3D rdtgrp->plr;
-
-	if (!plr->d) {
-		mutex_unlock(&rdtgroup_mutex);
-		return -ENODEV;
-	}
-
-	/*
-	 * Task is required to run with affinity to the cpus associated
-	 * with the pseudo-locked region. If this is not the case the task
-	 * may be scheduled elsewhere and invalidate entries in the
-	 * pseudo-locked region.
-	 */
-	if (!cpumask_subset(current->cpus_ptr, &plr->d->hdr.cpu_mask)) {
-		mutex_unlock(&rdtgroup_mutex);
-		return -EINVAL;
-	}
-
-	physical =3D __pa(plr->kmem) >> PAGE_SHIFT;
-	psize =3D plr->size - off;
-
-	if (off > plr->size) {
-		mutex_unlock(&rdtgroup_mutex);
-		return -ENOSPC;
-	}
-
-	/*
-	 * Ensure changes are carried directly to the memory being mapped,
-	 * do not allow copy-on-write mapping.
-	 */
-	if (!(vma->vm_flags & VM_SHARED)) {
-		mutex_unlock(&rdtgroup_mutex);
-		return -EINVAL;
-	}
-
-	if (vsize > psize) {
-		mutex_unlock(&rdtgroup_mutex);
-		return -ENOSPC;
-	}
-
-	memset(plr->kmem + off, 0, vsize);
-
-	if (remap_pfn_range(vma, vma->vm_start, physical + vma->vm_pgoff,
-			    vsize, vma->vm_page_prot)) {
-		mutex_unlock(&rdtgroup_mutex);
-		return -EAGAIN;
-	}
-	vma->vm_ops =3D &pseudo_mmap_ops;
-	mutex_unlock(&rdtgroup_mutex);
-	return 0;
-}
-
-static const struct file_operations pseudo_lock_dev_fops =3D {
-	.owner =3D	THIS_MODULE,
-	.read =3D		NULL,
-	.write =3D	NULL,
-	.open =3D		pseudo_lock_dev_open,
-	.release =3D	pseudo_lock_dev_release,
-	.mmap =3D		pseudo_lock_dev_mmap,
-};
-
-int rdt_pseudo_lock_init(void)
-{
-	int ret;
-
-	ret =3D register_chrdev(0, "pseudo_lock", &pseudo_lock_dev_fops);
-	if (ret < 0)
-		return ret;
-
-	pseudo_lock_major =3D ret;
-
-	ret =3D class_register(&pseudo_lock_class);
-	if (ret) {
-		unregister_chrdev(pseudo_lock_major, "pseudo_lock");
-		return ret;
-	}
-
-	return 0;
-}
-
-void rdt_pseudo_lock_release(void)
-{
-	class_unregister(&pseudo_lock_class);
-	unregister_chrdev(pseudo_lock_major, "pseudo_lock");
-	pseudo_lock_major =3D 0;
-}
diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock_trace.h b/arch/x86/kerne=
l/cpu/resctrl/pseudo_lock_trace.h
index 5a0fae6..7c8aef0 100644
--- a/arch/x86/kernel/cpu/resctrl/pseudo_lock_trace.h
+++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock_trace.h
@@ -39,5 +39,7 @@ TRACE_EVENT(pseudo_lock_l3,
=20
 #undef TRACE_INCLUDE_PATH
 #define TRACE_INCLUDE_PATH .
+
 #define TRACE_INCLUDE_FILE pseudo_lock_trace
+
 #include <trace/define_trace.h>
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/res=
ctrl/rdtgroup.c
index ace86b6..c7a7f0a 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -32,4547 +32,230 @@
 #include "internal.h"
=20
 DEFINE_STATIC_KEY_FALSE(rdt_enable_key);
-DEFINE_STATIC_KEY_FALSE(rdt_mon_enable_key);
-DEFINE_STATIC_KEY_FALSE(rdt_alloc_enable_key);
-
-/* Mutex to protect rdtgroup access. */
-DEFINE_MUTEX(rdtgroup_mutex);
-
-static struct kernfs_root *rdt_root;
-struct rdtgroup rdtgroup_default;
-LIST_HEAD(rdt_all_groups);
-
-/* list of entries for the schemata file */
-LIST_HEAD(resctrl_schema_all);
-
-/*
- * List of struct mon_data containing private data of event files for use by
- * rdtgroup_mondata_show(). Protected by rdtgroup_mutex.
- */
-static LIST_HEAD(mon_data_kn_priv_list);
-
-/* The filesystem can only be mounted once. */
-bool resctrl_mounted;
-
-/* Kernel fs node for "info" directory under root */
-static struct kernfs_node *kn_info;
-
-/* Kernel fs node for "mon_groups" directory under root */
-static struct kernfs_node *kn_mongrp;
-
-/* Kernel fs node for "mon_data" directory under root */
-static struct kernfs_node *kn_mondata;
-
-/*
- * Used to store the max resource name width to display the schemata names in
- * a tabular format.
- */
-int max_name_width;
-
-static struct seq_buf last_cmd_status;
-static char last_cmd_status_buf[512];
=20
-static int rdtgroup_setup_root(struct rdt_fs_context *ctx);
-static void rdtgroup_destroy_root(void);
+DEFINE_STATIC_KEY_FALSE(rdt_mon_enable_key);
=20
-struct dentry *debugfs_resctrl;
+DEFINE_STATIC_KEY_FALSE(rdt_alloc_enable_key);
=20
 /*
- * Memory bandwidth monitoring event to use for the default CTRL_MON group
- * and each new CTRL_MON group created by the user.  Only relevant when
- * the filesystem is mounted with the "mba_MBps" option so it does not
- * matter that it remains uninitialized on systems that do not support
- * the "mba_MBps" option.
+ * This is safe against resctrl_arch_sched_in() called from __switch_to()
+ * because __switch_to() is executed with interrupts disabled. A local call
+ * from update_closid_rmid() is protected against __switch_to() because
+ * preemption is disabled.
  */
-enum resctrl_event_id mba_mbps_default_event;
-
-static bool resctrl_debug;
-
-void rdt_last_cmd_clear(void)
-{
-	lockdep_assert_held(&rdtgroup_mutex);
-	seq_buf_clear(&last_cmd_status);
-}
-
-void rdt_last_cmd_puts(const char *s)
-{
-	lockdep_assert_held(&rdtgroup_mutex);
-	seq_buf_puts(&last_cmd_status, s);
-}
-
-void rdt_last_cmd_printf(const char *fmt, ...)
-{
-	va_list ap;
-
-	va_start(ap, fmt);
-	lockdep_assert_held(&rdtgroup_mutex);
-	seq_buf_vprintf(&last_cmd_status, fmt, ap);
-	va_end(ap);
-}
-
-void rdt_staged_configs_clear(void)
+void resctrl_arch_sync_cpu_closid_rmid(void *info)
 {
-	struct rdt_ctrl_domain *dom;
-	struct rdt_resource *r;
-
-	lockdep_assert_held(&rdtgroup_mutex);
+	struct resctrl_cpu_defaults *r =3D info;
=20
-	for_each_alloc_capable_rdt_resource(r) {
-		list_for_each_entry(dom, &r->ctrl_domains, hdr.list)
-			memset(dom->staged_config, 0, sizeof(dom->staged_config));
+	if (r) {
+		this_cpu_write(pqr_state.default_closid, r->closid);
+		this_cpu_write(pqr_state.default_rmid, r->rmid);
 	}
-}
=20
-static bool resctrl_is_mbm_enabled(void)
-{
-	return (resctrl_arch_is_mbm_total_enabled() ||
-		resctrl_arch_is_mbm_local_enabled());
+	/*
+	 * We cannot unconditionally write the MSR because the current
+	 * executing task might have its own closid selected. Just reuse
+	 * the context switch code.
+	 */
+	resctrl_arch_sched_in(current);
 }
=20
-static bool resctrl_is_mbm_event(int e)
-{
-	return (e >=3D QOS_L3_MBM_TOTAL_EVENT_ID &&
-		e <=3D QOS_L3_MBM_LOCAL_EVENT_ID);
-}
+#define INVALID_CONFIG_INDEX   UINT_MAX
=20
-/*
- * Trivial allocator for CLOSIDs. Use BITMAP APIs to manipulate a bitmap
- * of free CLOSIDs.
+/**
+ * mon_event_config_index_get - get the hardware index for the
+ *                              configurable event
+ * @evtid: event id.
  *
- * Using a global CLOSID across all resources has some advantages and
- * some drawbacks:
- * + We can simply set current's closid to assign a task to a resource
- *   group.
- * + Context switch code can avoid extra memory references deciding which
- *   CLOSID to load into the PQR_ASSOC MSR
- * - We give up some options in configuring resource groups across multi-soc=
ket
- *   systems.
- * - Our choices on how to configure each resource become progressively more
- *   limited as the number of resources grows.
+ * Return: 0 for evtid =3D=3D QOS_L3_MBM_TOTAL_EVENT_ID
+ *         1 for evtid =3D=3D QOS_L3_MBM_LOCAL_EVENT_ID
+ *         INVALID_CONFIG_INDEX for invalid evtid
  */
-static unsigned long *closid_free_map;
-static int closid_free_map_len;
-
-int closids_supported(void)
-{
-	return closid_free_map_len;
-}
-
-static int closid_init(void)
+static inline unsigned int mon_event_config_index_get(u32 evtid)
 {
-	struct resctrl_schema *s;
-	u32 rdt_min_closid =3D ~0;
-
-	/* Monitor only platforms still call closid_init() */
-	if (list_empty(&resctrl_schema_all))
+	switch (evtid) {
+	case QOS_L3_MBM_TOTAL_EVENT_ID:
 		return 0;
-
-	/* Compute rdt_min_closid across all resources */
-	list_for_each_entry(s, &resctrl_schema_all, list)
-		rdt_min_closid =3D min(rdt_min_closid, s->num_closid);
-
-	closid_free_map =3D bitmap_alloc(rdt_min_closid, GFP_KERNEL);
-	if (!closid_free_map)
-		return -ENOMEM;
-	bitmap_fill(closid_free_map, rdt_min_closid);
-
-	/* RESCTRL_RESERVED_CLOSID is always reserved for the default group */
-	__clear_bit(RESCTRL_RESERVED_CLOSID, closid_free_map);
-	closid_free_map_len =3D rdt_min_closid;
-
-	return 0;
-}
-
-static void closid_exit(void)
-{
-	bitmap_free(closid_free_map);
-	closid_free_map =3D NULL;
+	case QOS_L3_MBM_LOCAL_EVENT_ID:
+		return 1;
+	default:
+		/* Should never reach here */
+		return INVALID_CONFIG_INDEX;
+	}
 }
=20
-static int closid_alloc(void)
+void resctrl_arch_mon_event_config_read(void *_config_info)
 {
-	int cleanest_closid;
-	u32 closid;
-
-	lockdep_assert_held(&rdtgroup_mutex);
+	struct resctrl_mon_config_info *config_info =3D _config_info;
+	unsigned int index;
+	u64 msrval;
=20
-	if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID) &&
-	    resctrl_arch_is_llc_occupancy_enabled()) {
-		cleanest_closid =3D resctrl_find_cleanest_closid();
-		if (cleanest_closid < 0)
-			return cleanest_closid;
-		closid =3D cleanest_closid;
-	} else {
-		closid =3D find_first_bit(closid_free_map, closid_free_map_len);
-		if (closid =3D=3D closid_free_map_len)
-			return -ENOSPC;
+	index =3D mon_event_config_index_get(config_info->evtid);
+	if (index =3D=3D INVALID_CONFIG_INDEX) {
+		pr_warn_once("Invalid event id %d\n", config_info->evtid);
+		return;
 	}
-	__clear_bit(closid, closid_free_map);
-
-	return closid;
-}
-
-void closid_free(int closid)
-{
-	lockdep_assert_held(&rdtgroup_mutex);
+	rdmsrl(MSR_IA32_EVT_CFG_BASE + index, msrval);
=20
-	__set_bit(closid, closid_free_map);
+	/* Report only the valid event configuration bits */
+	config_info->mon_config =3D msrval & MAX_EVT_CONFIG_BITS;
 }
=20
-/**
- * closid_allocated - test if provided closid is in use
- * @closid: closid to be tested
- *
- * Return: true if @closid is currently associated with a resource group,
- * false if @closid is free
- */
-bool closid_allocated(unsigned int closid)
+void resctrl_arch_mon_event_config_write(void *_config_info)
 {
-	lockdep_assert_held(&rdtgroup_mutex);
+	struct resctrl_mon_config_info *config_info =3D _config_info;
+	unsigned int index;
=20
-	return !test_bit(closid, closid_free_map);
+	index =3D mon_event_config_index_get(config_info->evtid);
+	if (index =3D=3D INVALID_CONFIG_INDEX) {
+		pr_warn_once("Invalid event id %d\n", config_info->evtid);
+		return;
+	}
+	wrmsr(MSR_IA32_EVT_CFG_BASE + index, config_info->mon_config, 0);
 }
=20
-/**
- * rdtgroup_mode_by_closid - Return mode of resource group with closid
- * @closid: closid if the resource group
- *
- * Each resource group is associated with a @closid. Here the mode
- * of a resource group can be queried by searching for it using its closid.
- *
- * Return: mode as &enum rdtgrp_mode of resource group with closid @closid
- */
-enum rdtgrp_mode rdtgroup_mode_by_closid(int closid)
+static void l3_qos_cfg_update(void *arg)
 {
-	struct rdtgroup *rdtgrp;
-
-	list_for_each_entry(rdtgrp, &rdt_all_groups, rdtgroup_list) {
-		if (rdtgrp->closid =3D=3D closid)
-			return rdtgrp->mode;
-	}
+	bool *enable =3D arg;
=20
-	return RDT_NUM_MODES;
+	wrmsrl(MSR_IA32_L3_QOS_CFG, *enable ? L3_QOS_CDP_ENABLE : 0ULL);
 }
=20
-static const char * const rdt_mode_str[] =3D {
-	[RDT_MODE_SHAREABLE]		=3D "shareable",
-	[RDT_MODE_EXCLUSIVE]		=3D "exclusive",
-	[RDT_MODE_PSEUDO_LOCKSETUP]	=3D "pseudo-locksetup",
-	[RDT_MODE_PSEUDO_LOCKED]	=3D "pseudo-locked",
-};
-
-/**
- * rdtgroup_mode_str - Return the string representation of mode
- * @mode: the resource group mode as &enum rdtgroup_mode
- *
- * Return: string representation of valid mode, "unknown" otherwise
- */
-static const char *rdtgroup_mode_str(enum rdtgrp_mode mode)
+static void l2_qos_cfg_update(void *arg)
 {
-	if (mode < RDT_MODE_SHAREABLE || mode >=3D RDT_NUM_MODES)
-		return "unknown";
+	bool *enable =3D arg;
=20
-	return rdt_mode_str[mode];
+	wrmsrl(MSR_IA32_L2_QOS_CFG, *enable ? L2_QOS_CDP_ENABLE : 0ULL);
 }
=20
-/* set uid and gid of rdtgroup dirs and files to that of the creator */
-static int rdtgroup_kn_set_ugid(struct kernfs_node *kn)
+static int set_cache_qos_cfg(int level, bool enable)
 {
-	struct iattr iattr =3D { .ia_valid =3D ATTR_UID | ATTR_GID,
-				.ia_uid =3D current_fsuid(),
-				.ia_gid =3D current_fsgid(), };
-
-	if (uid_eq(iattr.ia_uid, GLOBAL_ROOT_UID) &&
-	    gid_eq(iattr.ia_gid, GLOBAL_ROOT_GID))
-		return 0;
+	void (*update)(void *arg);
+	struct rdt_ctrl_domain *d;
+	struct rdt_resource *r_l;
+	cpumask_var_t cpu_mask;
+	int cpu;
=20
-	return kernfs_setattr(kn, &iattr);
-}
+	/* Walking r->domains, ensure it can't race with cpuhp */
+	lockdep_assert_cpus_held();
=20
-static int rdtgroup_add_file(struct kernfs_node *parent_kn, struct rftype *r=
ft)
-{
-	struct kernfs_node *kn;
-	int ret;
+	if (level =3D=3D RDT_RESOURCE_L3)
+		update =3D l3_qos_cfg_update;
+	else if (level =3D=3D RDT_RESOURCE_L2)
+		update =3D l2_qos_cfg_update;
+	else
+		return -EINVAL;
=20
-	kn =3D __kernfs_create_file(parent_kn, rft->name, rft->mode,
-				  GLOBAL_ROOT_UID, GLOBAL_ROOT_GID,
-				  0, rft->kf_ops, rft, NULL, NULL);
-	if (IS_ERR(kn))
-		return PTR_ERR(kn);
+	if (!zalloc_cpumask_var(&cpu_mask, GFP_KERNEL))
+		return -ENOMEM;
=20
-	ret =3D rdtgroup_kn_set_ugid(kn);
-	if (ret) {
-		kernfs_remove(kn);
-		return ret;
+	r_l =3D &rdt_resources_all[level].r_resctrl;
+	list_for_each_entry(d, &r_l->ctrl_domains, hdr.list) {
+		if (r_l->cache.arch_has_per_cpu_cfg)
+			/* Pick all the CPUs in the domain instance */
+			for_each_cpu(cpu, &d->hdr.cpu_mask)
+				cpumask_set_cpu(cpu, cpu_mask);
+		else
+			/* Pick one CPU from each domain instance to update MSR */
+			cpumask_set_cpu(cpumask_any(&d->hdr.cpu_mask), cpu_mask);
 	}
=20
-	return 0;
-}
+	/* Update QOS_CFG MSR on all the CPUs in cpu_mask */
+	on_each_cpu_mask(cpu_mask, update, &enable, 1);
=20
-static int rdtgroup_seqfile_show(struct seq_file *m, void *arg)
-{
-	struct kernfs_open_file *of =3D m->private;
-	struct rftype *rft =3D of->kn->priv;
+	free_cpumask_var(cpu_mask);
=20
-	if (rft->seq_show)
-		return rft->seq_show(of, m, arg);
 	return 0;
 }
=20
-static ssize_t rdtgroup_file_write(struct kernfs_open_file *of, char *buf,
-				   size_t nbytes, loff_t off)
+/* Restore the qos cfg state when a domain comes online */
+void rdt_domain_reconfigure_cdp(struct rdt_resource *r)
 {
-	struct rftype *rft =3D of->kn->priv;
-
-	if (rft->write)
-		return rft->write(of, buf, nbytes, off);
-
-	return -EINVAL;
-}
-
-static const struct kernfs_ops rdtgroup_kf_single_ops =3D {
-	.atomic_write_len	=3D PAGE_SIZE,
-	.write			=3D rdtgroup_file_write,
-	.seq_show		=3D rdtgroup_seqfile_show,
-};
+	struct rdt_hw_resource *hw_res =3D resctrl_to_arch_res(r);
=20
-static const struct kernfs_ops kf_mondata_ops =3D {
-	.atomic_write_len	=3D PAGE_SIZE,
-	.seq_show		=3D rdtgroup_mondata_show,
-};
+	if (!r->cdp_capable)
+		return;
=20
-static bool is_cpu_list(struct kernfs_open_file *of)
-{
-	struct rftype *rft =3D of->kn->priv;
+	if (r->rid =3D=3D RDT_RESOURCE_L2)
+		l2_qos_cfg_update(&hw_res->cdp_enabled);
=20
-	return rft->flags & RFTYPE_FLAGS_CPUS_LIST;
+	if (r->rid =3D=3D RDT_RESOURCE_L3)
+		l3_qos_cfg_update(&hw_res->cdp_enabled);
 }
=20
-static int rdtgroup_cpus_show(struct kernfs_open_file *of,
-			      struct seq_file *s, void *v)
+static int cdp_enable(int level)
 {
-	struct rdtgroup *rdtgrp;
-	struct cpumask *mask;
-	int ret =3D 0;
+	struct rdt_resource *r_l =3D &rdt_resources_all[level].r_resctrl;
+	int ret;
=20
-	rdtgrp =3D rdtgroup_kn_lock_live(of->kn);
+	if (!r_l->alloc_capable)
+		return -EINVAL;
=20
-	if (rdtgrp) {
-		if (rdtgrp->mode =3D=3D RDT_MODE_PSEUDO_LOCKED) {
-			if (!rdtgrp->plr->d) {
-				rdt_last_cmd_clear();
-				rdt_last_cmd_puts("Cache domain offline\n");
-				ret =3D -ENODEV;
-			} else {
-				mask =3D &rdtgrp->plr->d->hdr.cpu_mask;
-				seq_printf(s, is_cpu_list(of) ?
-					   "%*pbl\n" : "%*pb\n",
-					   cpumask_pr_args(mask));
-			}
-		} else {
-			seq_printf(s, is_cpu_list(of) ? "%*pbl\n" : "%*pb\n",
-				   cpumask_pr_args(&rdtgrp->cpu_mask));
-		}
-	} else {
-		ret =3D -ENOENT;
-	}
-	rdtgroup_kn_unlock(of->kn);
+	ret =3D set_cache_qos_cfg(level, true);
+	if (!ret)
+		rdt_resources_all[level].cdp_enabled =3D true;
=20
 	return ret;
 }
=20
-/*
- * This is safe against resctrl_arch_sched_in() called from __switch_to()
- * because __switch_to() is executed with interrupts disabled. A local call
- * from update_closid_rmid() is protected against __switch_to() because
- * preemption is disabled.
- */
-void resctrl_arch_sync_cpu_closid_rmid(void *info)
-{
-	struct resctrl_cpu_defaults *r =3D info;
-
-	if (r) {
-		this_cpu_write(pqr_state.default_closid, r->closid);
-		this_cpu_write(pqr_state.default_rmid, r->rmid);
-	}
-
-	/*
-	 * We cannot unconditionally write the MSR because the current
-	 * executing task might have its own closid selected. Just reuse
-	 * the context switch code.
-	 */
-	resctrl_arch_sched_in(current);
-}
-
-/*
- * Update the PGR_ASSOC MSR on all cpus in @cpu_mask,
- *
- * Per task closids/rmids must have been set up before calling this function.
- * @r may be NULL.
- */
-static void
-update_closid_rmid(const struct cpumask *cpu_mask, struct rdtgroup *r)
+static void cdp_disable(int level)
 {
-	struct resctrl_cpu_defaults defaults, *p =3D NULL;
+	struct rdt_hw_resource *r_hw =3D &rdt_resources_all[level];
=20
-	if (r) {
-		defaults.closid =3D r->closid;
-		defaults.rmid =3D r->mon.rmid;
-		p =3D &defaults;
+	if (r_hw->cdp_enabled) {
+		set_cache_qos_cfg(level, false);
+		r_hw->cdp_enabled =3D false;
 	}
-
-	on_each_cpu_mask(cpu_mask, resctrl_arch_sync_cpu_closid_rmid, p, 1);
 }
=20
-static int cpus_mon_write(struct rdtgroup *rdtgrp, cpumask_var_t newmask,
-			  cpumask_var_t tmpmask)
+int resctrl_arch_set_cdp_enabled(enum resctrl_res_level l, bool enable)
 {
-	struct rdtgroup *prgrp =3D rdtgrp->mon.parent, *crgrp;
-	struct list_head *head;
+	struct rdt_hw_resource *hw_res =3D &rdt_resources_all[l];
=20
-	/* Check whether cpus belong to parent ctrl group */
-	cpumask_andnot(tmpmask, newmask, &prgrp->cpu_mask);
-	if (!cpumask_empty(tmpmask)) {
-		rdt_last_cmd_puts("Can only add CPUs to mongroup that belong to parent\n");
+	if (!hw_res->r_resctrl.cdp_capable)
 		return -EINVAL;
-	}
-
-	/* Check whether cpus are dropped from this group */
-	cpumask_andnot(tmpmask, &rdtgrp->cpu_mask, newmask);
-	if (!cpumask_empty(tmpmask)) {
-		/* Give any dropped cpus to parent rdtgroup */
-		cpumask_or(&prgrp->cpu_mask, &prgrp->cpu_mask, tmpmask);
-		update_closid_rmid(tmpmask, prgrp);
-	}
=20
-	/*
-	 * If we added cpus, remove them from previous group that owned them
-	 * and update per-cpu rmid
-	 */
-	cpumask_andnot(tmpmask, newmask, &rdtgrp->cpu_mask);
-	if (!cpumask_empty(tmpmask)) {
-		head =3D &prgrp->mon.crdtgrp_list;
-		list_for_each_entry(crgrp, head, mon.crdtgrp_list) {
-			if (crgrp =3D=3D rdtgrp)
-				continue;
-			cpumask_andnot(&crgrp->cpu_mask, &crgrp->cpu_mask,
-				       tmpmask);
-		}
-		update_closid_rmid(tmpmask, rdtgrp);
-	}
+	if (enable)
+		return cdp_enable(l);
=20
-	/* Done pushing/pulling - update this group with new mask */
-	cpumask_copy(&rdtgrp->cpu_mask, newmask);
+	cdp_disable(l);
=20
 	return 0;
 }
=20
-static void cpumask_rdtgrp_clear(struct rdtgroup *r, struct cpumask *m)
+bool resctrl_arch_get_cdp_enabled(enum resctrl_res_level l)
 {
-	struct rdtgroup *crgrp;
-
-	cpumask_andnot(&r->cpu_mask, &r->cpu_mask, m);
-	/* update the child mon group masks as well*/
-	list_for_each_entry(crgrp, &r->mon.crdtgrp_list, mon.crdtgrp_list)
-		cpumask_and(&crgrp->cpu_mask, &r->cpu_mask, &crgrp->cpu_mask);
+	return rdt_resources_all[l].cdp_enabled;
 }
=20
-static int cpus_ctrl_write(struct rdtgroup *rdtgrp, cpumask_var_t newmask,
-			   cpumask_var_t tmpmask, cpumask_var_t tmpmask1)
+void resctrl_arch_reset_all_ctrls(struct rdt_resource *r)
 {
-	struct rdtgroup *r, *crgrp;
-	struct list_head *head;
+	struct rdt_hw_resource *hw_res =3D resctrl_to_arch_res(r);
+	struct rdt_hw_ctrl_domain *hw_dom;
+	struct msr_param msr_param;
+	struct rdt_ctrl_domain *d;
+	int i;
=20
-	/* Check whether cpus are dropped from this group */
-	cpumask_andnot(tmpmask, &rdtgrp->cpu_mask, newmask);
-	if (!cpumask_empty(tmpmask)) {
-		/* Can't drop from default group */
-		if (rdtgrp =3D=3D &rdtgroup_default) {
-			rdt_last_cmd_puts("Can't drop CPUs from default group\n");
-			return -EINVAL;
-		}
+	/* Walking r->domains, ensure it can't race with cpuhp */
+	lockdep_assert_cpus_held();
=20
-		/* Give any dropped cpus to rdtgroup_default */
-		cpumask_or(&rdtgroup_default.cpu_mask,
-			   &rdtgroup_default.cpu_mask, tmpmask);
-		update_closid_rmid(tmpmask, &rdtgroup_default);
-	}
+	msr_param.res =3D r;
+	msr_param.low =3D 0;
+	msr_param.high =3D hw_res->num_closid;
=20
 	/*
-	 * If we added cpus, remove them from previous group and
-	 * the prev group's child groups that owned them
-	 * and update per-cpu closid/rmid.
+	 * Disable resource control for this resource by setting all
+	 * CBMs in all ctrl_domains to the maximum mask value. Pick one CPU
+	 * from each domain to update the MSRs below.
 	 */
-	cpumask_andnot(tmpmask, newmask, &rdtgrp->cpu_mask);
-	if (!cpumask_empty(tmpmask)) {
-		list_for_each_entry(r, &rdt_all_groups, rdtgroup_list) {
-			if (r =3D=3D rdtgrp)
-				continue;
-			cpumask_and(tmpmask1, &r->cpu_mask, tmpmask);
-			if (!cpumask_empty(tmpmask1))
-				cpumask_rdtgrp_clear(r, tmpmask1);
-		}
-		update_closid_rmid(tmpmask, rdtgrp);
-	}
+	list_for_each_entry(d, &r->ctrl_domains, hdr.list) {
+		hw_dom =3D resctrl_to_arch_ctrl_dom(d);
=20
-	/* Done pushing/pulling - update this group with new mask */
-	cpumask_copy(&rdtgrp->cpu_mask, newmask);
+		for (i =3D 0; i < hw_res->num_closid; i++)
+			hw_dom->ctrl_val[i] =3D resctrl_get_default_ctrl(r);
+		msr_param.dom =3D d;
+		smp_call_function_any(&d->hdr.cpu_mask, rdt_ctrl_update, &msr_param, 1);
+	}
=20
-	/*
-	 * Clear child mon group masks since there is a new parent mask
-	 * now and update the rmid for the cpus the child lost.
-	 */
-	head =3D &rdtgrp->mon.crdtgrp_list;
-	list_for_each_entry(crgrp, head, mon.crdtgrp_list) {
-		cpumask_and(tmpmask, &rdtgrp->cpu_mask, &crgrp->cpu_mask);
-		update_closid_rmid(tmpmask, rdtgrp);
-		cpumask_clear(&crgrp->cpu_mask);
-	}
-
-	return 0;
-}
-
-static ssize_t rdtgroup_cpus_write(struct kernfs_open_file *of,
-				   char *buf, size_t nbytes, loff_t off)
-{
-	cpumask_var_t tmpmask, newmask, tmpmask1;
-	struct rdtgroup *rdtgrp;
-	int ret;
-
-	if (!buf)
-		return -EINVAL;
-
-	if (!zalloc_cpumask_var(&tmpmask, GFP_KERNEL))
-		return -ENOMEM;
-	if (!zalloc_cpumask_var(&newmask, GFP_KERNEL)) {
-		free_cpumask_var(tmpmask);
-		return -ENOMEM;
-	}
-	if (!zalloc_cpumask_var(&tmpmask1, GFP_KERNEL)) {
-		free_cpumask_var(tmpmask);
-		free_cpumask_var(newmask);
-		return -ENOMEM;
-	}
-
-	rdtgrp =3D rdtgroup_kn_lock_live(of->kn);
-	if (!rdtgrp) {
-		ret =3D -ENOENT;
-		goto unlock;
-	}
-
-	if (rdtgrp->mode =3D=3D RDT_MODE_PSEUDO_LOCKED ||
-	    rdtgrp->mode =3D=3D RDT_MODE_PSEUDO_LOCKSETUP) {
-		ret =3D -EINVAL;
-		rdt_last_cmd_puts("Pseudo-locking in progress\n");
-		goto unlock;
-	}
-
-	if (is_cpu_list(of))
-		ret =3D cpulist_parse(buf, newmask);
-	else
-		ret =3D cpumask_parse(buf, newmask);
-
-	if (ret) {
-		rdt_last_cmd_puts("Bad CPU list/mask\n");
-		goto unlock;
-	}
-
-	/* check that user didn't specify any offline cpus */
-	cpumask_andnot(tmpmask, newmask, cpu_online_mask);
-	if (!cpumask_empty(tmpmask)) {
-		ret =3D -EINVAL;
-		rdt_last_cmd_puts("Can only assign online CPUs\n");
-		goto unlock;
-	}
-
-	if (rdtgrp->type =3D=3D RDTCTRL_GROUP)
-		ret =3D cpus_ctrl_write(rdtgrp, newmask, tmpmask, tmpmask1);
-	else if (rdtgrp->type =3D=3D RDTMON_GROUP)
-		ret =3D cpus_mon_write(rdtgrp, newmask, tmpmask);
-	else
-		ret =3D -EINVAL;
-
-unlock:
-	rdtgroup_kn_unlock(of->kn);
-	free_cpumask_var(tmpmask);
-	free_cpumask_var(newmask);
-	free_cpumask_var(tmpmask1);
-
-	return ret ?: nbytes;
-}
-
-/**
- * rdtgroup_remove - the helper to remove resource group safely
- * @rdtgrp: resource group to remove
- *
- * On resource group creation via a mkdir, an extra kernfs_node reference is
- * taken to ensure that the rdtgroup structure remains accessible for the
- * rdtgroup_kn_unlock() calls where it is removed.
- *
- * Drop the extra reference here, then free the rdtgroup structure.
- *
- * Return: void
- */
-static void rdtgroup_remove(struct rdtgroup *rdtgrp)
-{
-	kernfs_put(rdtgrp->kn);
-	kfree(rdtgrp);
-}
-
-static void _update_task_closid_rmid(void *task)
-{
-	/*
-	 * If the task is still current on this CPU, update PQR_ASSOC MSR.
-	 * Otherwise, the MSR is updated when the task is scheduled in.
-	 */
-	if (task =3D=3D current)
-		resctrl_arch_sched_in(task);
-}
-
-static void update_task_closid_rmid(struct task_struct *t)
-{
-	if (IS_ENABLED(CONFIG_SMP) && task_curr(t))
-		smp_call_function_single(task_cpu(t), _update_task_closid_rmid, t, 1);
-	else
-		_update_task_closid_rmid(t);
-}
-
-static bool task_in_rdtgroup(struct task_struct *tsk, struct rdtgroup *rdtgr=
p)
-{
-	u32 closid, rmid =3D rdtgrp->mon.rmid;
-
-	if (rdtgrp->type =3D=3D RDTCTRL_GROUP)
-		closid =3D rdtgrp->closid;
-	else if (rdtgrp->type =3D=3D RDTMON_GROUP)
-		closid =3D rdtgrp->mon.parent->closid;
-	else
-		return false;
-
-	return resctrl_arch_match_closid(tsk, closid) &&
-	       resctrl_arch_match_rmid(tsk, closid, rmid);
-}
-
-static int __rdtgroup_move_task(struct task_struct *tsk,
-				struct rdtgroup *rdtgrp)
-{
-	/* If the task is already in rdtgrp, no need to move the task. */
-	if (task_in_rdtgroup(tsk, rdtgrp))
-		return 0;
-
-	/*
-	 * Set the task's closid/rmid before the PQR_ASSOC MSR can be
-	 * updated by them.
-	 *
-	 * For ctrl_mon groups, move both closid and rmid.
-	 * For monitor groups, can move the tasks only from
-	 * their parent CTRL group.
-	 */
-	if (rdtgrp->type =3D=3D RDTMON_GROUP &&
-	    !resctrl_arch_match_closid(tsk, rdtgrp->mon.parent->closid)) {
-		rdt_last_cmd_puts("Can't move task to different control group\n");
-		return -EINVAL;
-	}
-
-	if (rdtgrp->type =3D=3D RDTMON_GROUP)
-		resctrl_arch_set_closid_rmid(tsk, rdtgrp->mon.parent->closid,
-					     rdtgrp->mon.rmid);
-	else
-		resctrl_arch_set_closid_rmid(tsk, rdtgrp->closid,
-					     rdtgrp->mon.rmid);
-
-	/*
-	 * Ensure the task's closid and rmid are written before determining if
-	 * the task is current that will decide if it will be interrupted.
-	 * This pairs with the full barrier between the rq->curr update and
-	 * resctrl_arch_sched_in() during context switch.
-	 */
-	smp_mb();
-
-	/*
-	 * By now, the task's closid and rmid are set. If the task is current
-	 * on a CPU, the PQR_ASSOC MSR needs to be updated to make the resource
-	 * group go into effect. If the task is not current, the MSR will be
-	 * updated when the task is scheduled in.
-	 */
-	update_task_closid_rmid(tsk);
-
-	return 0;
-}
-
-static bool is_closid_match(struct task_struct *t, struct rdtgroup *r)
-{
-	return (resctrl_arch_alloc_capable() && (r->type =3D=3D RDTCTRL_GROUP) &&
-		resctrl_arch_match_closid(t, r->closid));
-}
-
-static bool is_rmid_match(struct task_struct *t, struct rdtgroup *r)
-{
-	return (resctrl_arch_mon_capable() && (r->type =3D=3D RDTMON_GROUP) &&
-		resctrl_arch_match_rmid(t, r->mon.parent->closid,
-					r->mon.rmid));
-}
-
-/**
- * rdtgroup_tasks_assigned - Test if tasks have been assigned to resource gr=
oup
- * @r: Resource group
- *
- * Return: 1 if tasks have been assigned to @r, 0 otherwise
- */
-int rdtgroup_tasks_assigned(struct rdtgroup *r)
-{
-	struct task_struct *p, *t;
-	int ret =3D 0;
-
-	lockdep_assert_held(&rdtgroup_mutex);
-
-	rcu_read_lock();
-	for_each_process_thread(p, t) {
-		if (is_closid_match(t, r) || is_rmid_match(t, r)) {
-			ret =3D 1;
-			break;
-		}
-	}
-	rcu_read_unlock();
-
-	return ret;
-}
-
-static int rdtgroup_task_write_permission(struct task_struct *task,
-					  struct kernfs_open_file *of)
-{
-	const struct cred *tcred =3D get_task_cred(task);
-	const struct cred *cred =3D current_cred();
-	int ret =3D 0;
-
-	/*
-	 * Even if we're attaching all tasks in the thread group, we only
-	 * need to check permissions on one of them.
-	 */
-	if (!uid_eq(cred->euid, GLOBAL_ROOT_UID) &&
-	    !uid_eq(cred->euid, tcred->uid) &&
-	    !uid_eq(cred->euid, tcred->suid)) {
-		rdt_last_cmd_printf("No permission to move task %d\n", task->pid);
-		ret =3D -EPERM;
-	}
-
-	put_cred(tcred);
-	return ret;
-}
-
-static int rdtgroup_move_task(pid_t pid, struct rdtgroup *rdtgrp,
-			      struct kernfs_open_file *of)
-{
-	struct task_struct *tsk;
-	int ret;
-
-	rcu_read_lock();
-	if (pid) {
-		tsk =3D find_task_by_vpid(pid);
-		if (!tsk) {
-			rcu_read_unlock();
-			rdt_last_cmd_printf("No task %d\n", pid);
-			return -ESRCH;
-		}
-	} else {
-		tsk =3D current;
-	}
-
-	get_task_struct(tsk);
-	rcu_read_unlock();
-
-	ret =3D rdtgroup_task_write_permission(tsk, of);
-	if (!ret)
-		ret =3D __rdtgroup_move_task(tsk, rdtgrp);
-
-	put_task_struct(tsk);
-	return ret;
-}
-
-static ssize_t rdtgroup_tasks_write(struct kernfs_open_file *of,
-				    char *buf, size_t nbytes, loff_t off)
-{
-	struct rdtgroup *rdtgrp;
-	char *pid_str;
-	int ret =3D 0;
-	pid_t pid;
-
-	rdtgrp =3D rdtgroup_kn_lock_live(of->kn);
-	if (!rdtgrp) {
-		rdtgroup_kn_unlock(of->kn);
-		return -ENOENT;
-	}
-	rdt_last_cmd_clear();
-
-	if (rdtgrp->mode =3D=3D RDT_MODE_PSEUDO_LOCKED ||
-	    rdtgrp->mode =3D=3D RDT_MODE_PSEUDO_LOCKSETUP) {
-		ret =3D -EINVAL;
-		rdt_last_cmd_puts("Pseudo-locking in progress\n");
-		goto unlock;
-	}
-
-	while (buf && buf[0] !=3D '\0' && buf[0] !=3D '\n') {
-		pid_str =3D strim(strsep(&buf, ","));
-
-		if (kstrtoint(pid_str, 0, &pid)) {
-			rdt_last_cmd_printf("Task list parsing error pid %s\n", pid_str);
-			ret =3D -EINVAL;
-			break;
-		}
-
-		if (pid < 0) {
-			rdt_last_cmd_printf("Invalid pid %d\n", pid);
-			ret =3D -EINVAL;
-			break;
-		}
-
-		ret =3D rdtgroup_move_task(pid, rdtgrp, of);
-		if (ret) {
-			rdt_last_cmd_printf("Error while processing task %d\n", pid);
-			break;
-		}
-	}
-
-unlock:
-	rdtgroup_kn_unlock(of->kn);
-
-	return ret ?: nbytes;
-}
-
-static void show_rdt_tasks(struct rdtgroup *r, struct seq_file *s)
-{
-	struct task_struct *p, *t;
-	pid_t pid;
-
-	rcu_read_lock();
-	for_each_process_thread(p, t) {
-		if (is_closid_match(t, r) || is_rmid_match(t, r)) {
-			pid =3D task_pid_vnr(t);
-			if (pid)
-				seq_printf(s, "%d\n", pid);
-		}
-	}
-	rcu_read_unlock();
-}
-
-static int rdtgroup_tasks_show(struct kernfs_open_file *of,
-			       struct seq_file *s, void *v)
-{
-	struct rdtgroup *rdtgrp;
-	int ret =3D 0;
-
-	rdtgrp =3D rdtgroup_kn_lock_live(of->kn);
-	if (rdtgrp)
-		show_rdt_tasks(rdtgrp, s);
-	else
-		ret =3D -ENOENT;
-	rdtgroup_kn_unlock(of->kn);
-
-	return ret;
-}
-
-static int rdtgroup_closid_show(struct kernfs_open_file *of,
-				struct seq_file *s, void *v)
-{
-	struct rdtgroup *rdtgrp;
-	int ret =3D 0;
-
-	rdtgrp =3D rdtgroup_kn_lock_live(of->kn);
-	if (rdtgrp)
-		seq_printf(s, "%u\n", rdtgrp->closid);
-	else
-		ret =3D -ENOENT;
-	rdtgroup_kn_unlock(of->kn);
-
-	return ret;
-}
-
-static int rdtgroup_rmid_show(struct kernfs_open_file *of,
-			      struct seq_file *s, void *v)
-{
-	struct rdtgroup *rdtgrp;
-	int ret =3D 0;
-
-	rdtgrp =3D rdtgroup_kn_lock_live(of->kn);
-	if (rdtgrp)
-		seq_printf(s, "%u\n", rdtgrp->mon.rmid);
-	else
-		ret =3D -ENOENT;
-	rdtgroup_kn_unlock(of->kn);
-
-	return ret;
-}
-
-#ifdef CONFIG_PROC_CPU_RESCTRL
-
-/*
- * A task can only be part of one resctrl control group and of one monitor
- * group which is associated to that control group.
- *
- * 1)   res:
- *      mon:
- *
- *    resctrl is not available.
- *
- * 2)   res:/
- *      mon:
- *
- *    Task is part of the root resctrl control group, and it is not associat=
ed
- *    to any monitor group.
- *
- * 3)  res:/
- *     mon:mon0
- *
- *    Task is part of the root resctrl control group and monitor group mon0.
- *
- * 4)  res:group0
- *     mon:
- *
- *    Task is part of resctrl control group group0, and it is not associated
- *    to any monitor group.
- *
- * 5) res:group0
- *    mon:mon1
- *
- *    Task is part of resctrl control group group0 and monitor group mon1.
- */
-int proc_resctrl_show(struct seq_file *s, struct pid_namespace *ns,
-		      struct pid *pid, struct task_struct *tsk)
-{
-	struct rdtgroup *rdtg;
-	int ret =3D 0;
-
-	mutex_lock(&rdtgroup_mutex);
-
-	/* Return empty if resctrl has not been mounted. */
-	if (!resctrl_mounted) {
-		seq_puts(s, "res:\nmon:\n");
-		goto unlock;
-	}
-
-	list_for_each_entry(rdtg, &rdt_all_groups, rdtgroup_list) {
-		struct rdtgroup *crg;
-
-		/*
-		 * Task information is only relevant for shareable
-		 * and exclusive groups.
-		 */
-		if (rdtg->mode !=3D RDT_MODE_SHAREABLE &&
-		    rdtg->mode !=3D RDT_MODE_EXCLUSIVE)
-			continue;
-
-		if (!resctrl_arch_match_closid(tsk, rdtg->closid))
-			continue;
-
-		seq_printf(s, "res:%s%s\n", (rdtg =3D=3D &rdtgroup_default) ? "/" : "",
-			   rdt_kn_name(rdtg->kn));
-		seq_puts(s, "mon:");
-		list_for_each_entry(crg, &rdtg->mon.crdtgrp_list,
-				    mon.crdtgrp_list) {
-			if (!resctrl_arch_match_rmid(tsk, crg->mon.parent->closid,
-						     crg->mon.rmid))
-				continue;
-			seq_printf(s, "%s", rdt_kn_name(crg->kn));
-			break;
-		}
-		seq_putc(s, '\n');
-		goto unlock;
-	}
-	/*
-	 * The above search should succeed. Otherwise return
-	 * with an error.
-	 */
-	ret =3D -ENOENT;
-unlock:
-	mutex_unlock(&rdtgroup_mutex);
-
-	return ret;
-}
-#endif
-
-static int rdt_last_cmd_status_show(struct kernfs_open_file *of,
-				    struct seq_file *seq, void *v)
-{
-	int len;
-
-	mutex_lock(&rdtgroup_mutex);
-	len =3D seq_buf_used(&last_cmd_status);
-	if (len)
-		seq_printf(seq, "%.*s", len, last_cmd_status_buf);
-	else
-		seq_puts(seq, "ok\n");
-	mutex_unlock(&rdtgroup_mutex);
-	return 0;
-}
-
-static void *rdt_kn_parent_priv(struct kernfs_node *kn)
-{
-	/*
-	 * The parent pointer is only valid within RCU section since it can be
-	 * replaced.
-	 */
-	guard(rcu)();
-	return rcu_dereference(kn->__parent)->priv;
-}
-
-static int rdt_num_closids_show(struct kernfs_open_file *of,
-				struct seq_file *seq, void *v)
-{
-	struct resctrl_schema *s =3D rdt_kn_parent_priv(of->kn);
-
-	seq_printf(seq, "%u\n", s->num_closid);
-	return 0;
-}
-
-static int rdt_default_ctrl_show(struct kernfs_open_file *of,
-				 struct seq_file *seq, void *v)
-{
-	struct resctrl_schema *s =3D rdt_kn_parent_priv(of->kn);
-	struct rdt_resource *r =3D s->res;
-
-	seq_printf(seq, "%x\n", resctrl_get_default_ctrl(r));
-	return 0;
-}
-
-static int rdt_min_cbm_bits_show(struct kernfs_open_file *of,
-				 struct seq_file *seq, void *v)
-{
-	struct resctrl_schema *s =3D rdt_kn_parent_priv(of->kn);
-	struct rdt_resource *r =3D s->res;
-
-	seq_printf(seq, "%u\n", r->cache.min_cbm_bits);
-	return 0;
-}
-
-static int rdt_shareable_bits_show(struct kernfs_open_file *of,
-				   struct seq_file *seq, void *v)
-{
-	struct resctrl_schema *s =3D rdt_kn_parent_priv(of->kn);
-	struct rdt_resource *r =3D s->res;
-
-	seq_printf(seq, "%x\n", r->cache.shareable_bits);
-	return 0;
-}
-
-/*
- * rdt_bit_usage_show - Display current usage of resources
- *
- * A domain is a shared resource that can now be allocated differently. Here
- * we display the current regions of the domain as an annotated bitmask.
- * For each domain of this resource its allocation bitmask
- * is annotated as below to indicate the current usage of the corresponding =
bit:
- *   0 - currently unused
- *   X - currently available for sharing and used by software and hardware
- *   H - currently used by hardware only but available for software use
- *   S - currently used and shareable by software only
- *   E - currently used exclusively by one resource group
- *   P - currently pseudo-locked by one resource group
- */
-static int rdt_bit_usage_show(struct kernfs_open_file *of,
-			      struct seq_file *seq, void *v)
-{
-	struct resctrl_schema *s =3D rdt_kn_parent_priv(of->kn);
-	/*
-	 * Use unsigned long even though only 32 bits are used to ensure
-	 * test_bit() is used safely.
-	 */
-	unsigned long sw_shareable =3D 0, hw_shareable =3D 0;
-	unsigned long exclusive =3D 0, pseudo_locked =3D 0;
-	struct rdt_resource *r =3D s->res;
-	struct rdt_ctrl_domain *dom;
-	int i, hwb, swb, excl, psl;
-	enum rdtgrp_mode mode;
-	bool sep =3D false;
-	u32 ctrl_val;
-
-	cpus_read_lock();
-	mutex_lock(&rdtgroup_mutex);
-	hw_shareable =3D r->cache.shareable_bits;
-	list_for_each_entry(dom, &r->ctrl_domains, hdr.list) {
-		if (sep)
-			seq_putc(seq, ';');
-		sw_shareable =3D 0;
-		exclusive =3D 0;
-		seq_printf(seq, "%d=3D", dom->hdr.id);
-		for (i =3D 0; i < closids_supported(); i++) {
-			if (!closid_allocated(i))
-				continue;
-			ctrl_val =3D resctrl_arch_get_config(r, dom, i,
-							   s->conf_type);
-			mode =3D rdtgroup_mode_by_closid(i);
-			switch (mode) {
-			case RDT_MODE_SHAREABLE:
-				sw_shareable |=3D ctrl_val;
-				break;
-			case RDT_MODE_EXCLUSIVE:
-				exclusive |=3D ctrl_val;
-				break;
-			case RDT_MODE_PSEUDO_LOCKSETUP:
-			/*
-			 * RDT_MODE_PSEUDO_LOCKSETUP is possible
-			 * here but not included since the CBM
-			 * associated with this CLOSID in this mode
-			 * is not initialized and no task or cpu can be
-			 * assigned this CLOSID.
-			 */
-				break;
-			case RDT_MODE_PSEUDO_LOCKED:
-			case RDT_NUM_MODES:
-				WARN(1,
-				     "invalid mode for closid %d\n", i);
-				break;
-			}
-		}
-		for (i =3D r->cache.cbm_len - 1; i >=3D 0; i--) {
-			pseudo_locked =3D dom->plr ? dom->plr->cbm : 0;
-			hwb =3D test_bit(i, &hw_shareable);
-			swb =3D test_bit(i, &sw_shareable);
-			excl =3D test_bit(i, &exclusive);
-			psl =3D test_bit(i, &pseudo_locked);
-			if (hwb && swb)
-				seq_putc(seq, 'X');
-			else if (hwb && !swb)
-				seq_putc(seq, 'H');
-			else if (!hwb && swb)
-				seq_putc(seq, 'S');
-			else if (excl)
-				seq_putc(seq, 'E');
-			else if (psl)
-				seq_putc(seq, 'P');
-			else /* Unused bits remain */
-				seq_putc(seq, '0');
-		}
-		sep =3D true;
-	}
-	seq_putc(seq, '\n');
-	mutex_unlock(&rdtgroup_mutex);
-	cpus_read_unlock();
-	return 0;
-}
-
-static int rdt_min_bw_show(struct kernfs_open_file *of,
-			   struct seq_file *seq, void *v)
-{
-	struct resctrl_schema *s =3D rdt_kn_parent_priv(of->kn);
-	struct rdt_resource *r =3D s->res;
-
-	seq_printf(seq, "%u\n", r->membw.min_bw);
-	return 0;
-}
-
-static int rdt_num_rmids_show(struct kernfs_open_file *of,
-			      struct seq_file *seq, void *v)
-{
-	struct rdt_resource *r =3D rdt_kn_parent_priv(of->kn);
-
-	seq_printf(seq, "%d\n", r->num_rmid);
-
-	return 0;
-}
-
-static int rdt_mon_features_show(struct kernfs_open_file *of,
-				 struct seq_file *seq, void *v)
-{
-	struct rdt_resource *r =3D rdt_kn_parent_priv(of->kn);
-	struct mon_evt *mevt;
-
-	list_for_each_entry(mevt, &r->evt_list, list) {
-		seq_printf(seq, "%s\n", mevt->name);
-		if (mevt->configurable)
-			seq_printf(seq, "%s_config\n", mevt->name);
-	}
-
-	return 0;
-}
-
-static int rdt_bw_gran_show(struct kernfs_open_file *of,
-			    struct seq_file *seq, void *v)
-{
-	struct resctrl_schema *s =3D rdt_kn_parent_priv(of->kn);
-	struct rdt_resource *r =3D s->res;
-
-	seq_printf(seq, "%u\n", r->membw.bw_gran);
-	return 0;
-}
-
-static int rdt_delay_linear_show(struct kernfs_open_file *of,
-				 struct seq_file *seq, void *v)
-{
-	struct resctrl_schema *s =3D rdt_kn_parent_priv(of->kn);
-	struct rdt_resource *r =3D s->res;
-
-	seq_printf(seq, "%u\n", r->membw.delay_linear);
-	return 0;
-}
-
-static int max_threshold_occ_show(struct kernfs_open_file *of,
-				  struct seq_file *seq, void *v)
-{
-	seq_printf(seq, "%u\n", resctrl_rmid_realloc_threshold);
-
-	return 0;
-}
-
-static int rdt_thread_throttle_mode_show(struct kernfs_open_file *of,
-					 struct seq_file *seq, void *v)
-{
-	struct resctrl_schema *s =3D rdt_kn_parent_priv(of->kn);
-	struct rdt_resource *r =3D s->res;
-
-	switch (r->membw.throttle_mode) {
-	case THREAD_THROTTLE_PER_THREAD:
-		seq_puts(seq, "per-thread\n");
-		return 0;
-	case THREAD_THROTTLE_MAX:
-		seq_puts(seq, "max\n");
-		return 0;
-	case THREAD_THROTTLE_UNDEFINED:
-		seq_puts(seq, "undefined\n");
-		return 0;
-	}
-
-	WARN_ON_ONCE(1);
-
-	return 0;
-}
-
-static ssize_t max_threshold_occ_write(struct kernfs_open_file *of,
-				       char *buf, size_t nbytes, loff_t off)
-{
-	unsigned int bytes;
-	int ret;
-
-	ret =3D kstrtouint(buf, 0, &bytes);
-	if (ret)
-		return ret;
-
-	if (bytes > resctrl_rmid_realloc_limit)
-		return -EINVAL;
-
-	resctrl_rmid_realloc_threshold =3D resctrl_arch_round_mon_val(bytes);
-
-	return nbytes;
-}
-
-/*
- * rdtgroup_mode_show - Display mode of this resource group
- */
-static int rdtgroup_mode_show(struct kernfs_open_file *of,
-			      struct seq_file *s, void *v)
-{
-	struct rdtgroup *rdtgrp;
-
-	rdtgrp =3D rdtgroup_kn_lock_live(of->kn);
-	if (!rdtgrp) {
-		rdtgroup_kn_unlock(of->kn);
-		return -ENOENT;
-	}
-
-	seq_printf(s, "%s\n", rdtgroup_mode_str(rdtgrp->mode));
-
-	rdtgroup_kn_unlock(of->kn);
-	return 0;
-}
-
-static enum resctrl_conf_type resctrl_peer_type(enum resctrl_conf_type my_ty=
pe)
-{
-	switch (my_type) {
-	case CDP_CODE:
-		return CDP_DATA;
-	case CDP_DATA:
-		return CDP_CODE;
-	default:
-	case CDP_NONE:
-		return CDP_NONE;
-	}
-}
-
-static int rdt_has_sparse_bitmasks_show(struct kernfs_open_file *of,
-					struct seq_file *seq, void *v)
-{
-	struct resctrl_schema *s =3D rdt_kn_parent_priv(of->kn);
-	struct rdt_resource *r =3D s->res;
-
-	seq_printf(seq, "%u\n", r->cache.arch_has_sparse_bitmasks);
-
-	return 0;
-}
-
-/**
- * __rdtgroup_cbm_overlaps - Does CBM for intended closid overlap with other
- * @r: Resource to which domain instance @d belongs.
- * @d: The domain instance for which @closid is being tested.
- * @cbm: Capacity bitmask being tested.
- * @closid: Intended closid for @cbm.
- * @type: CDP type of @r.
- * @exclusive: Only check if overlaps with exclusive resource groups
- *
- * Checks if provided @cbm intended to be used for @closid on domain
- * @d overlaps with any other closids or other hardware usage associated
- * with this domain. If @exclusive is true then only overlaps with
- * resource groups in exclusive mode will be considered. If @exclusive
- * is false then overlaps with any resource group or hardware entities
- * will be considered.
- *
- * @cbm is unsigned long, even if only 32 bits are used, to make the
- * bitmap functions work correctly.
- *
- * Return: false if CBM does not overlap, true if it does.
- */
-static bool __rdtgroup_cbm_overlaps(struct rdt_resource *r, struct rdt_ctrl_=
domain *d,
-				    unsigned long cbm, int closid,
-				    enum resctrl_conf_type type, bool exclusive)
-{
-	enum rdtgrp_mode mode;
-	unsigned long ctrl_b;
-	int i;
-
-	/* Check for any overlap with regions used by hardware directly */
-	if (!exclusive) {
-		ctrl_b =3D r->cache.shareable_bits;
-		if (bitmap_intersects(&cbm, &ctrl_b, r->cache.cbm_len))
-			return true;
-	}
-
-	/* Check for overlap with other resource groups */
-	for (i =3D 0; i < closids_supported(); i++) {
-		ctrl_b =3D resctrl_arch_get_config(r, d, i, type);
-		mode =3D rdtgroup_mode_by_closid(i);
-		if (closid_allocated(i) && i !=3D closid &&
-		    mode !=3D RDT_MODE_PSEUDO_LOCKSETUP) {
-			if (bitmap_intersects(&cbm, &ctrl_b, r->cache.cbm_len)) {
-				if (exclusive) {
-					if (mode =3D=3D RDT_MODE_EXCLUSIVE)
-						return true;
-					continue;
-				}
-				return true;
-			}
-		}
-	}
-
-	return false;
-}
-
-/**
- * rdtgroup_cbm_overlaps - Does CBM overlap with other use of hardware
- * @s: Schema for the resource to which domain instance @d belongs.
- * @d: The domain instance for which @closid is being tested.
- * @cbm: Capacity bitmask being tested.
- * @closid: Intended closid for @cbm.
- * @exclusive: Only check if overlaps with exclusive resource groups
- *
- * Resources that can be allocated using a CBM can use the CBM to control
- * the overlap of these allocations. rdtgroup_cmb_overlaps() is the test
- * for overlap. Overlap test is not limited to the specific resource for
- * which the CBM is intended though - when dealing with CDP resources that
- * share the underlying hardware the overlap check should be performed on
- * the CDP resource sharing the hardware also.
- *
- * Refer to description of __rdtgroup_cbm_overlaps() for the details of the
- * overlap test.
- *
- * Return: true if CBM overlap detected, false if there is no overlap
- */
-bool rdtgroup_cbm_overlaps(struct resctrl_schema *s, struct rdt_ctrl_domain =
*d,
-			   unsigned long cbm, int closid, bool exclusive)
-{
-	enum resctrl_conf_type peer_type =3D resctrl_peer_type(s->conf_type);
-	struct rdt_resource *r =3D s->res;
-
-	if (__rdtgroup_cbm_overlaps(r, d, cbm, closid, s->conf_type,
-				    exclusive))
-		return true;
-
-	if (!resctrl_arch_get_cdp_enabled(r->rid))
-		return false;
-	return  __rdtgroup_cbm_overlaps(r, d, cbm, closid, peer_type, exclusive);
-}
-
-/**
- * rdtgroup_mode_test_exclusive - Test if this resource group can be exclusi=
ve
- * @rdtgrp: Resource group identified through its closid.
- *
- * An exclusive resource group implies that there should be no sharing of
- * its allocated resources. At the time this group is considered to be
- * exclusive this test can determine if its current schemata supports this
- * setting by testing for overlap with all other resource groups.
- *
- * Return: true if resource group can be exclusive, false if there is overlap
- * with allocations of other resource groups and thus this resource group
- * cannot be exclusive.
- */
-static bool rdtgroup_mode_test_exclusive(struct rdtgroup *rdtgrp)
-{
-	int closid =3D rdtgrp->closid;
-	struct rdt_ctrl_domain *d;
-	struct resctrl_schema *s;
-	struct rdt_resource *r;
-	bool has_cache =3D false;
-	u32 ctrl;
-
-	/* Walking r->domains, ensure it can't race with cpuhp */
-	lockdep_assert_cpus_held();
-
-	list_for_each_entry(s, &resctrl_schema_all, list) {
-		r =3D s->res;
-		if (r->rid =3D=3D RDT_RESOURCE_MBA || r->rid =3D=3D RDT_RESOURCE_SMBA)
-			continue;
-		has_cache =3D true;
-		list_for_each_entry(d, &r->ctrl_domains, hdr.list) {
-			ctrl =3D resctrl_arch_get_config(r, d, closid,
-						       s->conf_type);
-			if (rdtgroup_cbm_overlaps(s, d, ctrl, closid, false)) {
-				rdt_last_cmd_puts("Schemata overlaps\n");
-				return false;
-			}
-		}
-	}
-
-	if (!has_cache) {
-		rdt_last_cmd_puts("Cannot be exclusive without CAT/CDP\n");
-		return false;
-	}
-
-	return true;
-}
-
-/*
- * rdtgroup_mode_write - Modify the resource group's mode
- */
-static ssize_t rdtgroup_mode_write(struct kernfs_open_file *of,
-				   char *buf, size_t nbytes, loff_t off)
-{
-	struct rdtgroup *rdtgrp;
-	enum rdtgrp_mode mode;
-	int ret =3D 0;
-
-	/* Valid input requires a trailing newline */
-	if (nbytes =3D=3D 0 || buf[nbytes - 1] !=3D '\n')
-		return -EINVAL;
-	buf[nbytes - 1] =3D '\0';
-
-	rdtgrp =3D rdtgroup_kn_lock_live(of->kn);
-	if (!rdtgrp) {
-		rdtgroup_kn_unlock(of->kn);
-		return -ENOENT;
-	}
-
-	rdt_last_cmd_clear();
-
-	mode =3D rdtgrp->mode;
-
-	if ((!strcmp(buf, "shareable") && mode =3D=3D RDT_MODE_SHAREABLE) ||
-	    (!strcmp(buf, "exclusive") && mode =3D=3D RDT_MODE_EXCLUSIVE) ||
-	    (!strcmp(buf, "pseudo-locksetup") &&
-	     mode =3D=3D RDT_MODE_PSEUDO_LOCKSETUP) ||
-	    (!strcmp(buf, "pseudo-locked") && mode =3D=3D RDT_MODE_PSEUDO_LOCKED))
-		goto out;
-
-	if (mode =3D=3D RDT_MODE_PSEUDO_LOCKED) {
-		rdt_last_cmd_puts("Cannot change pseudo-locked group\n");
-		ret =3D -EINVAL;
-		goto out;
-	}
-
-	if (!strcmp(buf, "shareable")) {
-		if (rdtgrp->mode =3D=3D RDT_MODE_PSEUDO_LOCKSETUP) {
-			ret =3D rdtgroup_locksetup_exit(rdtgrp);
-			if (ret)
-				goto out;
-		}
-		rdtgrp->mode =3D RDT_MODE_SHAREABLE;
-	} else if (!strcmp(buf, "exclusive")) {
-		if (!rdtgroup_mode_test_exclusive(rdtgrp)) {
-			ret =3D -EINVAL;
-			goto out;
-		}
-		if (rdtgrp->mode =3D=3D RDT_MODE_PSEUDO_LOCKSETUP) {
-			ret =3D rdtgroup_locksetup_exit(rdtgrp);
-			if (ret)
-				goto out;
-		}
-		rdtgrp->mode =3D RDT_MODE_EXCLUSIVE;
-	} else if (IS_ENABLED(CONFIG_RESCTRL_FS_PSEUDO_LOCK) &&
-		   !strcmp(buf, "pseudo-locksetup")) {
-		ret =3D rdtgroup_locksetup_enter(rdtgrp);
-		if (ret)
-			goto out;
-		rdtgrp->mode =3D RDT_MODE_PSEUDO_LOCKSETUP;
-	} else {
-		rdt_last_cmd_puts("Unknown or unsupported mode\n");
-		ret =3D -EINVAL;
-	}
-
-out:
-	rdtgroup_kn_unlock(of->kn);
-	return ret ?: nbytes;
-}
-
-/**
- * rdtgroup_cbm_to_size - Translate CBM to size in bytes
- * @r: RDT resource to which @d belongs.
- * @d: RDT domain instance.
- * @cbm: bitmask for which the size should be computed.
- *
- * The bitmask provided associated with the RDT domain instance @d will be
- * translated into how many bytes it represents. The size in bytes is
- * computed by first dividing the total cache size by the CBM length to
- * determine how many bytes each bit in the bitmask represents. The result
- * is multiplied with the number of bits set in the bitmask.
- *
- * @cbm is unsigned long, even if only 32 bits are used to make the
- * bitmap functions work correctly.
- */
-unsigned int rdtgroup_cbm_to_size(struct rdt_resource *r,
-				  struct rdt_ctrl_domain *d, unsigned long cbm)
-{
-	unsigned int size =3D 0;
-	struct cacheinfo *ci;
-	int num_b;
-
-	if (WARN_ON_ONCE(r->ctrl_scope !=3D RESCTRL_L2_CACHE && r->ctrl_scope !=3D =
RESCTRL_L3_CACHE))
-		return size;
-
-	num_b =3D bitmap_weight(&cbm, r->cache.cbm_len);
-	ci =3D get_cpu_cacheinfo_level(cpumask_any(&d->hdr.cpu_mask), r->ctrl_scope=
);
-	if (ci)
-		size =3D ci->size / r->cache.cbm_len * num_b;
-
-	return size;
-}
-
-bool is_mba_sc(struct rdt_resource *r)
-{
-	if (!r)
-		r =3D resctrl_arch_get_resource(RDT_RESOURCE_MBA);
-
-	/*
-	 * The software controller support is only applicable to MBA resource.
-	 * Make sure to check for resource type.
-	 */
-	if (r->rid !=3D RDT_RESOURCE_MBA)
-		return false;
-
-	return r->membw.mba_sc;
-}
-
-/*
- * rdtgroup_size_show - Display size in bytes of allocated regions
- *
- * The "size" file mirrors the layout of the "schemata" file, printing the
- * size in bytes of each region instead of the capacity bitmask.
- */
-static int rdtgroup_size_show(struct kernfs_open_file *of,
-			      struct seq_file *s, void *v)
-{
-	struct resctrl_schema *schema;
-	enum resctrl_conf_type type;
-	struct rdt_ctrl_domain *d;
-	struct rdtgroup *rdtgrp;
-	struct rdt_resource *r;
-	unsigned int size;
-	int ret =3D 0;
-	u32 closid;
-	bool sep;
-	u32 ctrl;
-
-	rdtgrp =3D rdtgroup_kn_lock_live(of->kn);
-	if (!rdtgrp) {
-		rdtgroup_kn_unlock(of->kn);
-		return -ENOENT;
-	}
-
-	if (rdtgrp->mode =3D=3D RDT_MODE_PSEUDO_LOCKED) {
-		if (!rdtgrp->plr->d) {
-			rdt_last_cmd_clear();
-			rdt_last_cmd_puts("Cache domain offline\n");
-			ret =3D -ENODEV;
-		} else {
-			seq_printf(s, "%*s:", max_name_width,
-				   rdtgrp->plr->s->name);
-			size =3D rdtgroup_cbm_to_size(rdtgrp->plr->s->res,
-						    rdtgrp->plr->d,
-						    rdtgrp->plr->cbm);
-			seq_printf(s, "%d=3D%u\n", rdtgrp->plr->d->hdr.id, size);
-		}
-		goto out;
-	}
-
-	closid =3D rdtgrp->closid;
-
-	list_for_each_entry(schema, &resctrl_schema_all, list) {
-		r =3D schema->res;
-		type =3D schema->conf_type;
-		sep =3D false;
-		seq_printf(s, "%*s:", max_name_width, schema->name);
-		list_for_each_entry(d, &r->ctrl_domains, hdr.list) {
-			if (sep)
-				seq_putc(s, ';');
-			if (rdtgrp->mode =3D=3D RDT_MODE_PSEUDO_LOCKSETUP) {
-				size =3D 0;
-			} else {
-				if (is_mba_sc(r))
-					ctrl =3D d->mbps_val[closid];
-				else
-					ctrl =3D resctrl_arch_get_config(r, d,
-								       closid,
-								       type);
-				if (r->rid =3D=3D RDT_RESOURCE_MBA ||
-				    r->rid =3D=3D RDT_RESOURCE_SMBA)
-					size =3D ctrl;
-				else
-					size =3D rdtgroup_cbm_to_size(r, d, ctrl);
-			}
-			seq_printf(s, "%d=3D%u", d->hdr.id, size);
-			sep =3D true;
-		}
-		seq_putc(s, '\n');
-	}
-
-out:
-	rdtgroup_kn_unlock(of->kn);
-
-	return ret;
-}
-
-#define INVALID_CONFIG_INDEX   UINT_MAX
-
-/**
- * mon_event_config_index_get - get the hardware index for the
- *                              configurable event
- * @evtid: event id.
- *
- * Return: 0 for evtid =3D=3D QOS_L3_MBM_TOTAL_EVENT_ID
- *         1 for evtid =3D=3D QOS_L3_MBM_LOCAL_EVENT_ID
- *         INVALID_CONFIG_INDEX for invalid evtid
- */
-static inline unsigned int mon_event_config_index_get(u32 evtid)
-{
-	switch (evtid) {
-	case QOS_L3_MBM_TOTAL_EVENT_ID:
-		return 0;
-	case QOS_L3_MBM_LOCAL_EVENT_ID:
-		return 1;
-	default:
-		/* Should never reach here */
-		return INVALID_CONFIG_INDEX;
-	}
-}
-
-void resctrl_arch_mon_event_config_read(void *_config_info)
-{
-	struct resctrl_mon_config_info *config_info =3D _config_info;
-	unsigned int index;
-	u64 msrval;
-
-	index =3D mon_event_config_index_get(config_info->evtid);
-	if (index =3D=3D INVALID_CONFIG_INDEX) {
-		pr_warn_once("Invalid event id %d\n", config_info->evtid);
-		return;
-	}
-	rdmsrl(MSR_IA32_EVT_CFG_BASE + index, msrval);
-
-	/* Report only the valid event configuration bits */
-	config_info->mon_config =3D msrval & MAX_EVT_CONFIG_BITS;
-}
-
-static void mondata_config_read(struct resctrl_mon_config_info *mon_info)
-{
-	smp_call_function_any(&mon_info->d->hdr.cpu_mask,
-			      resctrl_arch_mon_event_config_read, mon_info, 1);
-}
-
-static int mbm_config_show(struct seq_file *s, struct rdt_resource *r, u32 e=
vtid)
-{
-	struct resctrl_mon_config_info mon_info;
-	struct rdt_mon_domain *dom;
-	bool sep =3D false;
-
-	cpus_read_lock();
-	mutex_lock(&rdtgroup_mutex);
-
-	list_for_each_entry(dom, &r->mon_domains, hdr.list) {
-		if (sep)
-			seq_puts(s, ";");
-
-		memset(&mon_info, 0, sizeof(struct resctrl_mon_config_info));
-		mon_info.r =3D r;
-		mon_info.d =3D dom;
-		mon_info.evtid =3D evtid;
-		mondata_config_read(&mon_info);
-
-		seq_printf(s, "%d=3D0x%02x", dom->hdr.id, mon_info.mon_config);
-		sep =3D true;
-	}
-	seq_puts(s, "\n");
-
-	mutex_unlock(&rdtgroup_mutex);
-	cpus_read_unlock();
-
-	return 0;
-}
-
-static int mbm_total_bytes_config_show(struct kernfs_open_file *of,
-				       struct seq_file *seq, void *v)
-{
-	struct rdt_resource *r =3D rdt_kn_parent_priv(of->kn);
-
-	mbm_config_show(seq, r, QOS_L3_MBM_TOTAL_EVENT_ID);
-
-	return 0;
-}
-
-static int mbm_local_bytes_config_show(struct kernfs_open_file *of,
-				       struct seq_file *seq, void *v)
-{
-	struct rdt_resource *r =3D rdt_kn_parent_priv(of->kn);
-
-	mbm_config_show(seq, r, QOS_L3_MBM_LOCAL_EVENT_ID);
-
-	return 0;
-}
-
-void resctrl_arch_mon_event_config_write(void *_config_info)
-{
-	struct resctrl_mon_config_info *config_info =3D _config_info;
-	unsigned int index;
-
-	index =3D mon_event_config_index_get(config_info->evtid);
-	if (index =3D=3D INVALID_CONFIG_INDEX) {
-		pr_warn_once("Invalid event id %d\n", config_info->evtid);
-		return;
-	}
-	wrmsr(MSR_IA32_EVT_CFG_BASE + index, config_info->mon_config, 0);
-}
-
-static void mbm_config_write_domain(struct rdt_resource *r,
-				    struct rdt_mon_domain *d, u32 evtid, u32 val)
-{
-	struct resctrl_mon_config_info mon_info =3D {0};
-
-	/*
-	 * Read the current config value first. If both are the same then
-	 * no need to write it again.
-	 */
-	mon_info.r =3D r;
-	mon_info.d =3D d;
-	mon_info.evtid =3D evtid;
-	mondata_config_read(&mon_info);
-	if (mon_info.mon_config =3D=3D val)
-		return;
-
-	mon_info.mon_config =3D val;
-
-	/*
-	 * Update MSR_IA32_EVT_CFG_BASE MSR on one of the CPUs in the
-	 * domain. The MSRs offset from MSR MSR_IA32_EVT_CFG_BASE
-	 * are scoped at the domain level. Writing any of these MSRs
-	 * on one CPU is observed by all the CPUs in the domain.
-	 */
-	smp_call_function_any(&d->hdr.cpu_mask, resctrl_arch_mon_event_config_write,
-			      &mon_info, 1);
-
-	/*
-	 * When an Event Configuration is changed, the bandwidth counters
-	 * for all RMIDs and Events will be cleared by the hardware. The
-	 * hardware also sets MSR_IA32_QM_CTR.Unavailable (bit 62) for
-	 * every RMID on the next read to any event for every RMID.
-	 * Subsequent reads will have MSR_IA32_QM_CTR.Unavailable (bit 62)
-	 * cleared while it is tracked by the hardware. Clear the
-	 * mbm_local and mbm_total counts for all the RMIDs.
-	 */
-	resctrl_arch_reset_rmid_all(r, d);
-}
-
-static int mon_config_write(struct rdt_resource *r, char *tok, u32 evtid)
-{
-	char *dom_str =3D NULL, *id_str;
-	unsigned long dom_id, val;
-	struct rdt_mon_domain *d;
-
-	/* Walking r->domains, ensure it can't race with cpuhp */
-	lockdep_assert_cpus_held();
-
-next:
-	if (!tok || tok[0] =3D=3D '\0')
-		return 0;
-
-	/* Start processing the strings for each domain */
-	dom_str =3D strim(strsep(&tok, ";"));
-	id_str =3D strsep(&dom_str, "=3D");
-
-	if (!id_str || kstrtoul(id_str, 10, &dom_id)) {
-		rdt_last_cmd_puts("Missing '=3D' or non-numeric domain id\n");
-		return -EINVAL;
-	}
-
-	if (!dom_str || kstrtoul(dom_str, 16, &val)) {
-		rdt_last_cmd_puts("Non-numeric event configuration value\n");
-		return -EINVAL;
-	}
-
-	/* Value from user cannot be more than the supported set of events */
-	if ((val & r->mbm_cfg_mask) !=3D val) {
-		rdt_last_cmd_printf("Invalid event configuration: max valid mask is 0x%02x=
\n",
-				    r->mbm_cfg_mask);
-		return -EINVAL;
-	}
-
-	list_for_each_entry(d, &r->mon_domains, hdr.list) {
-		if (d->hdr.id =3D=3D dom_id) {
-			mbm_config_write_domain(r, d, evtid, val);
-			goto next;
-		}
-	}
-
-	return -EINVAL;
-}
-
-static ssize_t mbm_total_bytes_config_write(struct kernfs_open_file *of,
-					    char *buf, size_t nbytes,
-					    loff_t off)
-{
-	struct rdt_resource *r =3D rdt_kn_parent_priv(of->kn);
-	int ret;
-
-	/* Valid input requires a trailing newline */
-	if (nbytes =3D=3D 0 || buf[nbytes - 1] !=3D '\n')
-		return -EINVAL;
-
-	cpus_read_lock();
-	mutex_lock(&rdtgroup_mutex);
-
-	rdt_last_cmd_clear();
-
-	buf[nbytes - 1] =3D '\0';
-
-	ret =3D mon_config_write(r, buf, QOS_L3_MBM_TOTAL_EVENT_ID);
-
-	mutex_unlock(&rdtgroup_mutex);
-	cpus_read_unlock();
-
-	return ret ?: nbytes;
-}
-
-static ssize_t mbm_local_bytes_config_write(struct kernfs_open_file *of,
-					    char *buf, size_t nbytes,
-					    loff_t off)
-{
-	struct rdt_resource *r =3D rdt_kn_parent_priv(of->kn);
-	int ret;
-
-	/* Valid input requires a trailing newline */
-	if (nbytes =3D=3D 0 || buf[nbytes - 1] !=3D '\n')
-		return -EINVAL;
-
-	cpus_read_lock();
-	mutex_lock(&rdtgroup_mutex);
-
-	rdt_last_cmd_clear();
-
-	buf[nbytes - 1] =3D '\0';
-
-	ret =3D mon_config_write(r, buf, QOS_L3_MBM_LOCAL_EVENT_ID);
-
-	mutex_unlock(&rdtgroup_mutex);
-	cpus_read_unlock();
-
-	return ret ?: nbytes;
-}
-
-/* rdtgroup information files for one cache resource. */
-static struct rftype res_common_files[] =3D {
-	{
-		.name		=3D "last_cmd_status",
-		.mode		=3D 0444,
-		.kf_ops		=3D &rdtgroup_kf_single_ops,
-		.seq_show	=3D rdt_last_cmd_status_show,
-		.fflags		=3D RFTYPE_TOP_INFO,
-	},
-	{
-		.name		=3D "num_closids",
-		.mode		=3D 0444,
-		.kf_ops		=3D &rdtgroup_kf_single_ops,
-		.seq_show	=3D rdt_num_closids_show,
-		.fflags		=3D RFTYPE_CTRL_INFO,
-	},
-	{
-		.name		=3D "mon_features",
-		.mode		=3D 0444,
-		.kf_ops		=3D &rdtgroup_kf_single_ops,
-		.seq_show	=3D rdt_mon_features_show,
-		.fflags		=3D RFTYPE_MON_INFO,
-	},
-	{
-		.name		=3D "num_rmids",
-		.mode		=3D 0444,
-		.kf_ops		=3D &rdtgroup_kf_single_ops,
-		.seq_show	=3D rdt_num_rmids_show,
-		.fflags		=3D RFTYPE_MON_INFO,
-	},
-	{
-		.name		=3D "cbm_mask",
-		.mode		=3D 0444,
-		.kf_ops		=3D &rdtgroup_kf_single_ops,
-		.seq_show	=3D rdt_default_ctrl_show,
-		.fflags		=3D RFTYPE_CTRL_INFO | RFTYPE_RES_CACHE,
-	},
-	{
-		.name		=3D "min_cbm_bits",
-		.mode		=3D 0444,
-		.kf_ops		=3D &rdtgroup_kf_single_ops,
-		.seq_show	=3D rdt_min_cbm_bits_show,
-		.fflags		=3D RFTYPE_CTRL_INFO | RFTYPE_RES_CACHE,
-	},
-	{
-		.name		=3D "shareable_bits",
-		.mode		=3D 0444,
-		.kf_ops		=3D &rdtgroup_kf_single_ops,
-		.seq_show	=3D rdt_shareable_bits_show,
-		.fflags		=3D RFTYPE_CTRL_INFO | RFTYPE_RES_CACHE,
-	},
-	{
-		.name		=3D "bit_usage",
-		.mode		=3D 0444,
-		.kf_ops		=3D &rdtgroup_kf_single_ops,
-		.seq_show	=3D rdt_bit_usage_show,
-		.fflags		=3D RFTYPE_CTRL_INFO | RFTYPE_RES_CACHE,
-	},
-	{
-		.name		=3D "min_bandwidth",
-		.mode		=3D 0444,
-		.kf_ops		=3D &rdtgroup_kf_single_ops,
-		.seq_show	=3D rdt_min_bw_show,
-		.fflags		=3D RFTYPE_CTRL_INFO | RFTYPE_RES_MB,
-	},
-	{
-		.name		=3D "bandwidth_gran",
-		.mode		=3D 0444,
-		.kf_ops		=3D &rdtgroup_kf_single_ops,
-		.seq_show	=3D rdt_bw_gran_show,
-		.fflags		=3D RFTYPE_CTRL_INFO | RFTYPE_RES_MB,
-	},
-	{
-		.name		=3D "delay_linear",
-		.mode		=3D 0444,
-		.kf_ops		=3D &rdtgroup_kf_single_ops,
-		.seq_show	=3D rdt_delay_linear_show,
-		.fflags		=3D RFTYPE_CTRL_INFO | RFTYPE_RES_MB,
-	},
-	/*
-	 * Platform specific which (if any) capabilities are provided by
-	 * thread_throttle_mode. Defer "fflags" initialization to platform
-	 * discovery.
-	 */
-	{
-		.name		=3D "thread_throttle_mode",
-		.mode		=3D 0444,
-		.kf_ops		=3D &rdtgroup_kf_single_ops,
-		.seq_show	=3D rdt_thread_throttle_mode_show,
-	},
-	{
-		.name		=3D "max_threshold_occupancy",
-		.mode		=3D 0644,
-		.kf_ops		=3D &rdtgroup_kf_single_ops,
-		.write		=3D max_threshold_occ_write,
-		.seq_show	=3D max_threshold_occ_show,
-		.fflags		=3D RFTYPE_MON_INFO | RFTYPE_RES_CACHE,
-	},
-	{
-		.name		=3D "mbm_total_bytes_config",
-		.mode		=3D 0644,
-		.kf_ops		=3D &rdtgroup_kf_single_ops,
-		.seq_show	=3D mbm_total_bytes_config_show,
-		.write		=3D mbm_total_bytes_config_write,
-	},
-	{
-		.name		=3D "mbm_local_bytes_config",
-		.mode		=3D 0644,
-		.kf_ops		=3D &rdtgroup_kf_single_ops,
-		.seq_show	=3D mbm_local_bytes_config_show,
-		.write		=3D mbm_local_bytes_config_write,
-	},
-	{
-		.name		=3D "cpus",
-		.mode		=3D 0644,
-		.kf_ops		=3D &rdtgroup_kf_single_ops,
-		.write		=3D rdtgroup_cpus_write,
-		.seq_show	=3D rdtgroup_cpus_show,
-		.fflags		=3D RFTYPE_BASE,
-	},
-	{
-		.name		=3D "cpus_list",
-		.mode		=3D 0644,
-		.kf_ops		=3D &rdtgroup_kf_single_ops,
-		.write		=3D rdtgroup_cpus_write,
-		.seq_show	=3D rdtgroup_cpus_show,
-		.flags		=3D RFTYPE_FLAGS_CPUS_LIST,
-		.fflags		=3D RFTYPE_BASE,
-	},
-	{
-		.name		=3D "tasks",
-		.mode		=3D 0644,
-		.kf_ops		=3D &rdtgroup_kf_single_ops,
-		.write		=3D rdtgroup_tasks_write,
-		.seq_show	=3D rdtgroup_tasks_show,
-		.fflags		=3D RFTYPE_BASE,
-	},
-	{
-		.name		=3D "mon_hw_id",
-		.mode		=3D 0444,
-		.kf_ops		=3D &rdtgroup_kf_single_ops,
-		.seq_show	=3D rdtgroup_rmid_show,
-		.fflags		=3D RFTYPE_MON_BASE | RFTYPE_DEBUG,
-	},
-	{
-		.name		=3D "schemata",
-		.mode		=3D 0644,
-		.kf_ops		=3D &rdtgroup_kf_single_ops,
-		.write		=3D rdtgroup_schemata_write,
-		.seq_show	=3D rdtgroup_schemata_show,
-		.fflags		=3D RFTYPE_CTRL_BASE,
-	},
-	{
-		.name		=3D "mba_MBps_event",
-		.mode		=3D 0644,
-		.kf_ops		=3D &rdtgroup_kf_single_ops,
-		.write		=3D rdtgroup_mba_mbps_event_write,
-		.seq_show	=3D rdtgroup_mba_mbps_event_show,
-	},
-	{
-		.name		=3D "mode",
-		.mode		=3D 0644,
-		.kf_ops		=3D &rdtgroup_kf_single_ops,
-		.write		=3D rdtgroup_mode_write,
-		.seq_show	=3D rdtgroup_mode_show,
-		.fflags		=3D RFTYPE_CTRL_BASE,
-	},
-	{
-		.name		=3D "size",
-		.mode		=3D 0444,
-		.kf_ops		=3D &rdtgroup_kf_single_ops,
-		.seq_show	=3D rdtgroup_size_show,
-		.fflags		=3D RFTYPE_CTRL_BASE,
-	},
-	{
-		.name		=3D "sparse_masks",
-		.mode		=3D 0444,
-		.kf_ops		=3D &rdtgroup_kf_single_ops,
-		.seq_show	=3D rdt_has_sparse_bitmasks_show,
-		.fflags		=3D RFTYPE_CTRL_INFO | RFTYPE_RES_CACHE,
-	},
-	{
-		.name		=3D "ctrl_hw_id",
-		.mode		=3D 0444,
-		.kf_ops		=3D &rdtgroup_kf_single_ops,
-		.seq_show	=3D rdtgroup_closid_show,
-		.fflags		=3D RFTYPE_CTRL_BASE | RFTYPE_DEBUG,
-	},
-};
-
-static int rdtgroup_add_files(struct kernfs_node *kn, unsigned long fflags)
-{
-	struct rftype *rfts, *rft;
-	int ret, len;
-
-	rfts =3D res_common_files;
-	len =3D ARRAY_SIZE(res_common_files);
-
-	lockdep_assert_held(&rdtgroup_mutex);
-
-	if (resctrl_debug)
-		fflags |=3D RFTYPE_DEBUG;
-
-	for (rft =3D rfts; rft < rfts + len; rft++) {
-		if (rft->fflags && ((fflags & rft->fflags) =3D=3D rft->fflags)) {
-			ret =3D rdtgroup_add_file(kn, rft);
-			if (ret)
-				goto error;
-		}
-	}
-
-	return 0;
-error:
-	pr_warn("Failed to add %s, err=3D%d\n", rft->name, ret);
-	while (--rft >=3D rfts) {
-		if ((fflags & rft->fflags) =3D=3D rft->fflags)
-			kernfs_remove_by_name(kn, rft->name);
-	}
-	return ret;
-}
-
-static struct rftype *rdtgroup_get_rftype_by_name(const char *name)
-{
-	struct rftype *rfts, *rft;
-	int len;
-
-	rfts =3D res_common_files;
-	len =3D ARRAY_SIZE(res_common_files);
-
-	for (rft =3D rfts; rft < rfts + len; rft++) {
-		if (!strcmp(rft->name, name))
-			return rft;
-	}
-
-	return NULL;
-}
-
-static void thread_throttle_mode_init(void)
-{
-	enum membw_throttle_mode throttle_mode =3D THREAD_THROTTLE_UNDEFINED;
-	struct rdt_resource *r_mba, *r_smba;
-
-	r_mba =3D resctrl_arch_get_resource(RDT_RESOURCE_MBA);
-	if (r_mba->alloc_capable &&
-	    r_mba->membw.throttle_mode !=3D THREAD_THROTTLE_UNDEFINED)
-		throttle_mode =3D r_mba->membw.throttle_mode;
-
-	r_smba =3D resctrl_arch_get_resource(RDT_RESOURCE_SMBA);
-	if (r_smba->alloc_capable &&
-	    r_smba->membw.throttle_mode !=3D THREAD_THROTTLE_UNDEFINED)
-		throttle_mode =3D r_smba->membw.throttle_mode;
-
-	if (throttle_mode =3D=3D THREAD_THROTTLE_UNDEFINED)
-		return;
-
-	resctrl_file_fflags_init("thread_throttle_mode",
-				 RFTYPE_CTRL_INFO | RFTYPE_RES_MB);
-}
-
-void resctrl_file_fflags_init(const char *config, unsigned long fflags)
-{
-	struct rftype *rft;
-
-	rft =3D rdtgroup_get_rftype_by_name(config);
-	if (rft)
-		rft->fflags =3D fflags;
-}
-
-/**
- * rdtgroup_kn_mode_restrict - Restrict user access to named resctrl file
- * @r: The resource group with which the file is associated.
- * @name: Name of the file
- *
- * The permissions of named resctrl file, directory, or link are modified
- * to not allow read, write, or execute by any user.
- *
- * WARNING: This function is intended to communicate to the user that the
- * resctrl file has been locked down - that it is not relevant to the
- * particular state the system finds itself in. It should not be relied
- * on to protect from user access because after the file's permissions
- * are restricted the user can still change the permissions using chmod
- * from the command line.
- *
- * Return: 0 on success, <0 on failure.
- */
-int rdtgroup_kn_mode_restrict(struct rdtgroup *r, const char *name)
-{
-	struct iattr iattr =3D {.ia_valid =3D ATTR_MODE,};
-	struct kernfs_node *kn;
-	int ret =3D 0;
-
-	kn =3D kernfs_find_and_get_ns(r->kn, name, NULL);
-	if (!kn)
-		return -ENOENT;
-
-	switch (kernfs_type(kn)) {
-	case KERNFS_DIR:
-		iattr.ia_mode =3D S_IFDIR;
-		break;
-	case KERNFS_FILE:
-		iattr.ia_mode =3D S_IFREG;
-		break;
-	case KERNFS_LINK:
-		iattr.ia_mode =3D S_IFLNK;
-		break;
-	}
-
-	ret =3D kernfs_setattr(kn, &iattr);
-	kernfs_put(kn);
-	return ret;
-}
-
-/**
- * rdtgroup_kn_mode_restore - Restore user access to named resctrl file
- * @r: The resource group with which the file is associated.
- * @name: Name of the file
- * @mask: Mask of permissions that should be restored
- *
- * Restore the permissions of the named file. If @name is a directory the
- * permissions of its parent will be used.
- *
- * Return: 0 on success, <0 on failure.
- */
-int rdtgroup_kn_mode_restore(struct rdtgroup *r, const char *name,
-			     umode_t mask)
-{
-	struct iattr iattr =3D {.ia_valid =3D ATTR_MODE,};
-	struct kernfs_node *kn, *parent;
-	struct rftype *rfts, *rft;
-	int ret, len;
-
-	rfts =3D res_common_files;
-	len =3D ARRAY_SIZE(res_common_files);
-
-	for (rft =3D rfts; rft < rfts + len; rft++) {
-		if (!strcmp(rft->name, name))
-			iattr.ia_mode =3D rft->mode & mask;
-	}
-
-	kn =3D kernfs_find_and_get_ns(r->kn, name, NULL);
-	if (!kn)
-		return -ENOENT;
-
-	switch (kernfs_type(kn)) {
-	case KERNFS_DIR:
-		parent =3D kernfs_get_parent(kn);
-		if (parent) {
-			iattr.ia_mode |=3D parent->mode;
-			kernfs_put(parent);
-		}
-		iattr.ia_mode |=3D S_IFDIR;
-		break;
-	case KERNFS_FILE:
-		iattr.ia_mode |=3D S_IFREG;
-		break;
-	case KERNFS_LINK:
-		iattr.ia_mode |=3D S_IFLNK;
-		break;
-	}
-
-	ret =3D kernfs_setattr(kn, &iattr);
-	kernfs_put(kn);
-	return ret;
-}
-
-static int rdtgroup_mkdir_info_resdir(void *priv, char *name,
-				      unsigned long fflags)
-{
-	struct kernfs_node *kn_subdir;
-	int ret;
-
-	kn_subdir =3D kernfs_create_dir(kn_info, name,
-				      kn_info->mode, priv);
-	if (IS_ERR(kn_subdir))
-		return PTR_ERR(kn_subdir);
-
-	ret =3D rdtgroup_kn_set_ugid(kn_subdir);
-	if (ret)
-		return ret;
-
-	ret =3D rdtgroup_add_files(kn_subdir, fflags);
-	if (!ret)
-		kernfs_activate(kn_subdir);
-
-	return ret;
-}
-
-static unsigned long fflags_from_resource(struct rdt_resource *r)
-{
-	switch (r->rid) {
-	case RDT_RESOURCE_L3:
-	case RDT_RESOURCE_L2:
-		return RFTYPE_RES_CACHE;
-	case RDT_RESOURCE_MBA:
-	case RDT_RESOURCE_SMBA:
-		return RFTYPE_RES_MB;
-	}
-
-	return WARN_ON_ONCE(1);
-}
-
-static int rdtgroup_create_info_dir(struct kernfs_node *parent_kn)
-{
-	struct resctrl_schema *s;
-	struct rdt_resource *r;
-	unsigned long fflags;
-	char name[32];
-	int ret;
-
-	/* create the directory */
-	kn_info =3D kernfs_create_dir(parent_kn, "info", parent_kn->mode, NULL);
-	if (IS_ERR(kn_info))
-		return PTR_ERR(kn_info);
-
-	ret =3D rdtgroup_add_files(kn_info, RFTYPE_TOP_INFO);
-	if (ret)
-		goto out_destroy;
-
-	/* loop over enabled controls, these are all alloc_capable */
-	list_for_each_entry(s, &resctrl_schema_all, list) {
-		r =3D s->res;
-		fflags =3D fflags_from_resource(r) | RFTYPE_CTRL_INFO;
-		ret =3D rdtgroup_mkdir_info_resdir(s, s->name, fflags);
-		if (ret)
-			goto out_destroy;
-	}
-
-	for_each_mon_capable_rdt_resource(r) {
-		fflags =3D fflags_from_resource(r) | RFTYPE_MON_INFO;
-		sprintf(name, "%s_MON", r->name);
-		ret =3D rdtgroup_mkdir_info_resdir(r, name, fflags);
-		if (ret)
-			goto out_destroy;
-	}
-
-	ret =3D rdtgroup_kn_set_ugid(kn_info);
-	if (ret)
-		goto out_destroy;
-
-	kernfs_activate(kn_info);
-
-	return 0;
-
-out_destroy:
-	kernfs_remove(kn_info);
-	return ret;
-}
-
-static int
-mongroup_create_dir(struct kernfs_node *parent_kn, struct rdtgroup *prgrp,
-		    char *name, struct kernfs_node **dest_kn)
-{
-	struct kernfs_node *kn;
-	int ret;
-
-	/* create the directory */
-	kn =3D kernfs_create_dir(parent_kn, name, parent_kn->mode, prgrp);
-	if (IS_ERR(kn))
-		return PTR_ERR(kn);
-
-	if (dest_kn)
-		*dest_kn =3D kn;
-
-	ret =3D rdtgroup_kn_set_ugid(kn);
-	if (ret)
-		goto out_destroy;
-
-	kernfs_activate(kn);
-
-	return 0;
-
-out_destroy:
-	kernfs_remove(kn);
-	return ret;
-}
-
-static void l3_qos_cfg_update(void *arg)
-{
-	bool *enable =3D arg;
-
-	wrmsrl(MSR_IA32_L3_QOS_CFG, *enable ? L3_QOS_CDP_ENABLE : 0ULL);
-}
-
-static void l2_qos_cfg_update(void *arg)
-{
-	bool *enable =3D arg;
-
-	wrmsrl(MSR_IA32_L2_QOS_CFG, *enable ? L2_QOS_CDP_ENABLE : 0ULL);
-}
-
-static inline bool is_mba_linear(void)
-{
-	return resctrl_arch_get_resource(RDT_RESOURCE_MBA)->membw.delay_linear;
-}
-
-static int set_cache_qos_cfg(int level, bool enable)
-{
-	void (*update)(void *arg);
-	struct rdt_ctrl_domain *d;
-	struct rdt_resource *r_l;
-	cpumask_var_t cpu_mask;
-	int cpu;
-
-	/* Walking r->domains, ensure it can't race with cpuhp */
-	lockdep_assert_cpus_held();
-
-	if (level =3D=3D RDT_RESOURCE_L3)
-		update =3D l3_qos_cfg_update;
-	else if (level =3D=3D RDT_RESOURCE_L2)
-		update =3D l2_qos_cfg_update;
-	else
-		return -EINVAL;
-
-	if (!zalloc_cpumask_var(&cpu_mask, GFP_KERNEL))
-		return -ENOMEM;
-
-	r_l =3D &rdt_resources_all[level].r_resctrl;
-	list_for_each_entry(d, &r_l->ctrl_domains, hdr.list) {
-		if (r_l->cache.arch_has_per_cpu_cfg)
-			/* Pick all the CPUs in the domain instance */
-			for_each_cpu(cpu, &d->hdr.cpu_mask)
-				cpumask_set_cpu(cpu, cpu_mask);
-		else
-			/* Pick one CPU from each domain instance to update MSR */
-			cpumask_set_cpu(cpumask_any(&d->hdr.cpu_mask), cpu_mask);
-	}
-
-	/* Update QOS_CFG MSR on all the CPUs in cpu_mask */
-	on_each_cpu_mask(cpu_mask, update, &enable, 1);
-
-	free_cpumask_var(cpu_mask);
-
-	return 0;
-}
-
-/* Restore the qos cfg state when a domain comes online */
-void rdt_domain_reconfigure_cdp(struct rdt_resource *r)
-{
-	struct rdt_hw_resource *hw_res =3D resctrl_to_arch_res(r);
-
-	if (!r->cdp_capable)
-		return;
-
-	if (r->rid =3D=3D RDT_RESOURCE_L2)
-		l2_qos_cfg_update(&hw_res->cdp_enabled);
-
-	if (r->rid =3D=3D RDT_RESOURCE_L3)
-		l3_qos_cfg_update(&hw_res->cdp_enabled);
-}
-
-static int mba_sc_domain_allocate(struct rdt_resource *r, struct rdt_ctrl_do=
main *d)
-{
-	u32 num_closid =3D resctrl_arch_get_num_closid(r);
-	int cpu =3D cpumask_any(&d->hdr.cpu_mask);
-	int i;
-
-	d->mbps_val =3D kcalloc_node(num_closid, sizeof(*d->mbps_val),
-				   GFP_KERNEL, cpu_to_node(cpu));
-	if (!d->mbps_val)
-		return -ENOMEM;
-
-	for (i =3D 0; i < num_closid; i++)
-		d->mbps_val[i] =3D MBA_MAX_MBPS;
-
-	return 0;
-}
-
-static void mba_sc_domain_destroy(struct rdt_resource *r,
-				  struct rdt_ctrl_domain *d)
-{
-	kfree(d->mbps_val);
-	d->mbps_val =3D NULL;
-}
-
-/*
- * MBA software controller is supported only if
- * MBM is supported and MBA is in linear scale,
- * and the MBM monitor scope is the same as MBA
- * control scope.
- */
-static bool supports_mba_mbps(void)
-{
-	struct rdt_resource *rmbm =3D resctrl_arch_get_resource(RDT_RESOURCE_L3);
-	struct rdt_resource *r =3D resctrl_arch_get_resource(RDT_RESOURCE_MBA);
-
-	return (resctrl_is_mbm_enabled() &&
-		r->alloc_capable && is_mba_linear() &&
-		r->ctrl_scope =3D=3D rmbm->mon_scope);
-}
-
-/*
- * Enable or disable the MBA software controller
- * which helps user specify bandwidth in MBps.
- */
-static int set_mba_sc(bool mba_sc)
-{
-	struct rdt_resource *r =3D resctrl_arch_get_resource(RDT_RESOURCE_MBA);
-	u32 num_closid =3D resctrl_arch_get_num_closid(r);
-	struct rdt_ctrl_domain *d;
-	unsigned long fflags;
-	int i;
-
-	if (!supports_mba_mbps() || mba_sc =3D=3D is_mba_sc(r))
-		return -EINVAL;
-
-	r->membw.mba_sc =3D mba_sc;
-
-	rdtgroup_default.mba_mbps_event =3D mba_mbps_default_event;
-
-	list_for_each_entry(d, &r->ctrl_domains, hdr.list) {
-		for (i =3D 0; i < num_closid; i++)
-			d->mbps_val[i] =3D MBA_MAX_MBPS;
-	}
-
-	fflags =3D mba_sc ? RFTYPE_CTRL_BASE | RFTYPE_MON_BASE : 0;
-	resctrl_file_fflags_init("mba_MBps_event", fflags);
-
-	return 0;
-}
-
-static int cdp_enable(int level)
-{
-	struct rdt_resource *r_l =3D &rdt_resources_all[level].r_resctrl;
-	int ret;
-
-	if (!r_l->alloc_capable)
-		return -EINVAL;
-
-	ret =3D set_cache_qos_cfg(level, true);
-	if (!ret)
-		rdt_resources_all[level].cdp_enabled =3D true;
-
-	return ret;
-}
-
-static void cdp_disable(int level)
-{
-	struct rdt_hw_resource *r_hw =3D &rdt_resources_all[level];
-
-	if (r_hw->cdp_enabled) {
-		set_cache_qos_cfg(level, false);
-		r_hw->cdp_enabled =3D false;
-	}
-}
-
-int resctrl_arch_set_cdp_enabled(enum resctrl_res_level l, bool enable)
-{
-	struct rdt_hw_resource *hw_res =3D &rdt_resources_all[l];
-
-	if (!hw_res->r_resctrl.cdp_capable)
-		return -EINVAL;
-
-	if (enable)
-		return cdp_enable(l);
-
-	cdp_disable(l);
-
-	return 0;
-}
-
-bool resctrl_arch_get_cdp_enabled(enum resctrl_res_level l)
-{
-	return rdt_resources_all[l].cdp_enabled;
-}
-
-/*
- * We don't allow rdtgroup directories to be created anywhere
- * except the root directory. Thus when looking for the rdtgroup
- * structure for a kernfs node we are either looking at a directory,
- * in which case the rdtgroup structure is pointed at by the "priv"
- * field, otherwise we have a file, and need only look to the parent
- * to find the rdtgroup.
- */
-static struct rdtgroup *kernfs_to_rdtgroup(struct kernfs_node *kn)
-{
-	if (kernfs_type(kn) =3D=3D KERNFS_DIR) {
-		/*
-		 * All the resource directories use "kn->priv"
-		 * to point to the "struct rdtgroup" for the
-		 * resource. "info" and its subdirectories don't
-		 * have rdtgroup structures, so return NULL here.
-		 */
-		if (kn =3D=3D kn_info ||
-		    rcu_access_pointer(kn->__parent) =3D=3D kn_info)
-			return NULL;
-		else
-			return kn->priv;
-	} else {
-		return rdt_kn_parent_priv(kn);
-	}
-}
-
-static void rdtgroup_kn_get(struct rdtgroup *rdtgrp, struct kernfs_node *kn)
-{
-	atomic_inc(&rdtgrp->waitcount);
-	kernfs_break_active_protection(kn);
-}
-
-static void rdtgroup_kn_put(struct rdtgroup *rdtgrp, struct kernfs_node *kn)
-{
-	if (atomic_dec_and_test(&rdtgrp->waitcount) &&
-	    (rdtgrp->flags & RDT_DELETED)) {
-		if (rdtgrp->mode =3D=3D RDT_MODE_PSEUDO_LOCKSETUP ||
-		    rdtgrp->mode =3D=3D RDT_MODE_PSEUDO_LOCKED)
-			rdtgroup_pseudo_lock_remove(rdtgrp);
-		kernfs_unbreak_active_protection(kn);
-		rdtgroup_remove(rdtgrp);
-	} else {
-		kernfs_unbreak_active_protection(kn);
-	}
-}
-
-struct rdtgroup *rdtgroup_kn_lock_live(struct kernfs_node *kn)
-{
-	struct rdtgroup *rdtgrp =3D kernfs_to_rdtgroup(kn);
-
-	if (!rdtgrp)
-		return NULL;
-
-	rdtgroup_kn_get(rdtgrp, kn);
-
-	cpus_read_lock();
-	mutex_lock(&rdtgroup_mutex);
-
-	/* Was this group deleted while we waited? */
-	if (rdtgrp->flags & RDT_DELETED)
-		return NULL;
-
-	return rdtgrp;
-}
-
-void rdtgroup_kn_unlock(struct kernfs_node *kn)
-{
-	struct rdtgroup *rdtgrp =3D kernfs_to_rdtgroup(kn);
-
-	if (!rdtgrp)
-		return;
-
-	mutex_unlock(&rdtgroup_mutex);
-	cpus_read_unlock();
-
-	rdtgroup_kn_put(rdtgrp, kn);
-}
-
-static int mkdir_mondata_all(struct kernfs_node *parent_kn,
-			     struct rdtgroup *prgrp,
-			     struct kernfs_node **mon_data_kn);
-
-static void rdt_disable_ctx(void)
-{
-	resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L3, false);
-	resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L2, false);
-	set_mba_sc(false);
-
-	resctrl_debug =3D false;
-}
-
-static int rdt_enable_ctx(struct rdt_fs_context *ctx)
-{
-	int ret =3D 0;
-
-	if (ctx->enable_cdpl2) {
-		ret =3D resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L2, true);
-		if (ret)
-			goto out_done;
-	}
-
-	if (ctx->enable_cdpl3) {
-		ret =3D resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L3, true);
-		if (ret)
-			goto out_cdpl2;
-	}
-
-	if (ctx->enable_mba_mbps) {
-		ret =3D set_mba_sc(true);
-		if (ret)
-			goto out_cdpl3;
-	}
-
-	if (ctx->enable_debug)
-		resctrl_debug =3D true;
-
-	return 0;
-
-out_cdpl3:
-	resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L3, false);
-out_cdpl2:
-	resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L2, false);
-out_done:
-	return ret;
-}
-
-static int schemata_list_add(struct rdt_resource *r, enum resctrl_conf_type =
type)
-{
-	struct resctrl_schema *s;
-	const char *suffix =3D "";
-	int ret, cl;
-
-	s =3D kzalloc(sizeof(*s), GFP_KERNEL);
-	if (!s)
-		return -ENOMEM;
-
-	s->res =3D r;
-	s->num_closid =3D resctrl_arch_get_num_closid(r);
-	if (resctrl_arch_get_cdp_enabled(r->rid))
-		s->num_closid /=3D 2;
-
-	s->conf_type =3D type;
-	switch (type) {
-	case CDP_CODE:
-		suffix =3D "CODE";
-		break;
-	case CDP_DATA:
-		suffix =3D "DATA";
-		break;
-	case CDP_NONE:
-		suffix =3D "";
-		break;
-	}
-
-	ret =3D snprintf(s->name, sizeof(s->name), "%s%s", r->name, suffix);
-	if (ret >=3D sizeof(s->name)) {
-		kfree(s);
-		return -EINVAL;
-	}
-
-	cl =3D strlen(s->name);
-
-	/*
-	 * If CDP is supported by this resource, but not enabled,
-	 * include the suffix. This ensures the tabular format of the
-	 * schemata file does not change between mounts of the filesystem.
-	 */
-	if (r->cdp_capable && !resctrl_arch_get_cdp_enabled(r->rid))
-		cl +=3D 4;
-
-	if (cl > max_name_width)
-		max_name_width =3D cl;
-
-	switch (r->schema_fmt) {
-	case RESCTRL_SCHEMA_BITMAP:
-		s->fmt_str =3D "%d=3D%x";
-		break;
-	case RESCTRL_SCHEMA_RANGE:
-		s->fmt_str =3D "%d=3D%u";
-		break;
-	}
-
-	if (WARN_ON_ONCE(!s->fmt_str)) {
-		kfree(s);
-		return -EINVAL;
-	}
-
-	INIT_LIST_HEAD(&s->list);
-	list_add(&s->list, &resctrl_schema_all);
-
-	return 0;
-}
-
-static int schemata_list_create(void)
-{
-	struct rdt_resource *r;
-	int ret =3D 0;
-
-	for_each_alloc_capable_rdt_resource(r) {
-		if (resctrl_arch_get_cdp_enabled(r->rid)) {
-			ret =3D schemata_list_add(r, CDP_CODE);
-			if (ret)
-				break;
-
-			ret =3D schemata_list_add(r, CDP_DATA);
-		} else {
-			ret =3D schemata_list_add(r, CDP_NONE);
-		}
-
-		if (ret)
-			break;
-	}
-
-	return ret;
-}
-
-static void schemata_list_destroy(void)
-{
-	struct resctrl_schema *s, *tmp;
-
-	list_for_each_entry_safe(s, tmp, &resctrl_schema_all, list) {
-		list_del(&s->list);
-		kfree(s);
-	}
-}
-
-static int rdt_get_tree(struct fs_context *fc)
-{
-	struct rdt_fs_context *ctx =3D rdt_fc2context(fc);
-	unsigned long flags =3D RFTYPE_CTRL_BASE;
-	struct rdt_mon_domain *dom;
-	struct rdt_resource *r;
-	int ret;
-
-	cpus_read_lock();
-	mutex_lock(&rdtgroup_mutex);
-	/*
-	 * resctrl file system can only be mounted once.
-	 */
-	if (resctrl_mounted) {
-		ret =3D -EBUSY;
-		goto out;
-	}
-
-	ret =3D rdtgroup_setup_root(ctx);
-	if (ret)
-		goto out;
-
-	ret =3D rdt_enable_ctx(ctx);
-	if (ret)
-		goto out_root;
-
-	ret =3D schemata_list_create();
-	if (ret) {
-		schemata_list_destroy();
-		goto out_ctx;
-	}
-
-	ret =3D closid_init();
-	if (ret)
-		goto out_schemata_free;
-
-	if (resctrl_arch_mon_capable())
-		flags |=3D RFTYPE_MON;
-
-	ret =3D rdtgroup_add_files(rdtgroup_default.kn, flags);
-	if (ret)
-		goto out_closid_exit;
-
-	kernfs_activate(rdtgroup_default.kn);
-
-	ret =3D rdtgroup_create_info_dir(rdtgroup_default.kn);
-	if (ret < 0)
-		goto out_closid_exit;
-
-	if (resctrl_arch_mon_capable()) {
-		ret =3D mongroup_create_dir(rdtgroup_default.kn,
-					  &rdtgroup_default, "mon_groups",
-					  &kn_mongrp);
-		if (ret < 0)
-			goto out_info;
-
-		ret =3D mkdir_mondata_all(rdtgroup_default.kn,
-					&rdtgroup_default, &kn_mondata);
-		if (ret < 0)
-			goto out_mongrp;
-		rdtgroup_default.mon.mon_data_kn =3D kn_mondata;
-	}
-
-	ret =3D rdt_pseudo_lock_init();
-	if (ret)
-		goto out_mondata;
-
-	ret =3D kernfs_get_tree(fc);
-	if (ret < 0)
-		goto out_psl;
-
-	if (resctrl_arch_alloc_capable())
-		resctrl_arch_enable_alloc();
-	if (resctrl_arch_mon_capable())
-		resctrl_arch_enable_mon();
-
-	if (resctrl_arch_alloc_capable() || resctrl_arch_mon_capable())
-		resctrl_mounted =3D true;
-
-	if (resctrl_is_mbm_enabled()) {
-		r =3D resctrl_arch_get_resource(RDT_RESOURCE_L3);
-		list_for_each_entry(dom, &r->mon_domains, hdr.list)
-			mbm_setup_overflow_handler(dom, MBM_OVERFLOW_INTERVAL,
-						   RESCTRL_PICK_ANY_CPU);
-	}
-
-	goto out;
-
-out_psl:
-	rdt_pseudo_lock_release();
-out_mondata:
-	if (resctrl_arch_mon_capable())
-		kernfs_remove(kn_mondata);
-out_mongrp:
-	if (resctrl_arch_mon_capable())
-		kernfs_remove(kn_mongrp);
-out_info:
-	kernfs_remove(kn_info);
-out_closid_exit:
-	closid_exit();
-out_schemata_free:
-	schemata_list_destroy();
-out_ctx:
-	rdt_disable_ctx();
-out_root:
-	rdtgroup_destroy_root();
-out:
-	rdt_last_cmd_clear();
-	mutex_unlock(&rdtgroup_mutex);
-	cpus_read_unlock();
-	return ret;
-}
-
-enum rdt_param {
-	Opt_cdp,
-	Opt_cdpl2,
-	Opt_mba_mbps,
-	Opt_debug,
-	nr__rdt_params
-};
-
-static const struct fs_parameter_spec rdt_fs_parameters[] =3D {
-	fsparam_flag("cdp",		Opt_cdp),
-	fsparam_flag("cdpl2",		Opt_cdpl2),
-	fsparam_flag("mba_MBps",	Opt_mba_mbps),
-	fsparam_flag("debug",		Opt_debug),
-	{}
-};
-
-static int rdt_parse_param(struct fs_context *fc, struct fs_parameter *param)
-{
-	struct rdt_fs_context *ctx =3D rdt_fc2context(fc);
-	struct fs_parse_result result;
-	const char *msg;
-	int opt;
-
-	opt =3D fs_parse(fc, rdt_fs_parameters, param, &result);
-	if (opt < 0)
-		return opt;
-
-	switch (opt) {
-	case Opt_cdp:
-		ctx->enable_cdpl3 =3D true;
-		return 0;
-	case Opt_cdpl2:
-		ctx->enable_cdpl2 =3D true;
-		return 0;
-	case Opt_mba_mbps:
-		msg =3D "mba_MBps requires MBM and linear scale MBA at L3 scope";
-		if (!supports_mba_mbps())
-			return invalfc(fc, msg);
-		ctx->enable_mba_mbps =3D true;
-		return 0;
-	case Opt_debug:
-		ctx->enable_debug =3D true;
-		return 0;
-	}
-
-	return -EINVAL;
-}
-
-static void rdt_fs_context_free(struct fs_context *fc)
-{
-	struct rdt_fs_context *ctx =3D rdt_fc2context(fc);
-
-	kernfs_free_fs_context(fc);
-	kfree(ctx);
-}
-
-static const struct fs_context_operations rdt_fs_context_ops =3D {
-	.free		=3D rdt_fs_context_free,
-	.parse_param	=3D rdt_parse_param,
-	.get_tree	=3D rdt_get_tree,
-};
-
-static int rdt_init_fs_context(struct fs_context *fc)
-{
-	struct rdt_fs_context *ctx;
-
-	ctx =3D kzalloc(sizeof(*ctx), GFP_KERNEL);
-	if (!ctx)
-		return -ENOMEM;
-
-	ctx->kfc.magic =3D RDTGROUP_SUPER_MAGIC;
-	fc->fs_private =3D &ctx->kfc;
-	fc->ops =3D &rdt_fs_context_ops;
-	put_user_ns(fc->user_ns);
-	fc->user_ns =3D get_user_ns(&init_user_ns);
-	fc->global =3D true;
-	return 0;
-}
-
-void resctrl_arch_reset_all_ctrls(struct rdt_resource *r)
-{
-	struct rdt_hw_resource *hw_res =3D resctrl_to_arch_res(r);
-	struct rdt_hw_ctrl_domain *hw_dom;
-	struct msr_param msr_param;
-	struct rdt_ctrl_domain *d;
-	int i;
-
-	/* Walking r->domains, ensure it can't race with cpuhp */
-	lockdep_assert_cpus_held();
-
-	msr_param.res =3D r;
-	msr_param.low =3D 0;
-	msr_param.high =3D hw_res->num_closid;
-
-	/*
-	 * Disable resource control for this resource by setting all
-	 * CBMs in all ctrl_domains to the maximum mask value. Pick one CPU
-	 * from each domain to update the MSRs below.
-	 */
-	list_for_each_entry(d, &r->ctrl_domains, hdr.list) {
-		hw_dom =3D resctrl_to_arch_ctrl_dom(d);
-
-		for (i =3D 0; i < hw_res->num_closid; i++)
-			hw_dom->ctrl_val[i] =3D resctrl_get_default_ctrl(r);
-		msr_param.dom =3D d;
-		smp_call_function_any(&d->hdr.cpu_mask, rdt_ctrl_update, &msr_param, 1);
-	}
-
-	return;
-}
-
-/*
- * Move tasks from one to the other group. If @from is NULL, then all tasks
- * in the systems are moved unconditionally (used for teardown).
- *
- * If @mask is not NULL the cpus on which moved tasks are running are set
- * in that mask so the update smp function call is restricted to affected
- * cpus.
- */
-static void rdt_move_group_tasks(struct rdtgroup *from, struct rdtgroup *to,
-				 struct cpumask *mask)
-{
-	struct task_struct *p, *t;
-
-	read_lock(&tasklist_lock);
-	for_each_process_thread(p, t) {
-		if (!from || is_closid_match(t, from) ||
-		    is_rmid_match(t, from)) {
-			resctrl_arch_set_closid_rmid(t, to->closid,
-						     to->mon.rmid);
-
-			/*
-			 * Order the closid/rmid stores above before the loads
-			 * in task_curr(). This pairs with the full barrier
-			 * between the rq->curr update and
-			 * resctrl_arch_sched_in() during context switch.
-			 */
-			smp_mb();
-
-			/*
-			 * If the task is on a CPU, set the CPU in the mask.
-			 * The detection is inaccurate as tasks might move or
-			 * schedule before the smp function call takes place.
-			 * In such a case the function call is pointless, but
-			 * there is no other side effect.
-			 */
-			if (IS_ENABLED(CONFIG_SMP) && mask && task_curr(t))
-				cpumask_set_cpu(task_cpu(t), mask);
-		}
-	}
-	read_unlock(&tasklist_lock);
-}
-
-static void free_all_child_rdtgrp(struct rdtgroup *rdtgrp)
-{
-	struct rdtgroup *sentry, *stmp;
-	struct list_head *head;
-
-	head =3D &rdtgrp->mon.crdtgrp_list;
-	list_for_each_entry_safe(sentry, stmp, head, mon.crdtgrp_list) {
-		free_rmid(sentry->closid, sentry->mon.rmid);
-		list_del(&sentry->mon.crdtgrp_list);
-
-		if (atomic_read(&sentry->waitcount) !=3D 0)
-			sentry->flags =3D RDT_DELETED;
-		else
-			rdtgroup_remove(sentry);
-	}
-}
-
-/*
- * Forcibly remove all of subdirectories under root.
- */
-static void rmdir_all_sub(void)
-{
-	struct rdtgroup *rdtgrp, *tmp;
-
-	/* Move all tasks to the default resource group */
-	rdt_move_group_tasks(NULL, &rdtgroup_default, NULL);
-
-	list_for_each_entry_safe(rdtgrp, tmp, &rdt_all_groups, rdtgroup_list) {
-		/* Free any child rmids */
-		free_all_child_rdtgrp(rdtgrp);
-
-		/* Remove each rdtgroup other than root */
-		if (rdtgrp =3D=3D &rdtgroup_default)
-			continue;
-
-		if (rdtgrp->mode =3D=3D RDT_MODE_PSEUDO_LOCKSETUP ||
-		    rdtgrp->mode =3D=3D RDT_MODE_PSEUDO_LOCKED)
-			rdtgroup_pseudo_lock_remove(rdtgrp);
-
-		/*
-		 * Give any CPUs back to the default group. We cannot copy
-		 * cpu_online_mask because a CPU might have executed the
-		 * offline callback already, but is still marked online.
-		 */
-		cpumask_or(&rdtgroup_default.cpu_mask,
-			   &rdtgroup_default.cpu_mask, &rdtgrp->cpu_mask);
-
-		free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
-
-		kernfs_remove(rdtgrp->kn);
-		list_del(&rdtgrp->rdtgroup_list);
-
-		if (atomic_read(&rdtgrp->waitcount) !=3D 0)
-			rdtgrp->flags =3D RDT_DELETED;
-		else
-			rdtgroup_remove(rdtgrp);
-	}
-	/* Notify online CPUs to update per cpu storage and PQR_ASSOC MSR */
-	update_closid_rmid(cpu_online_mask, &rdtgroup_default);
-
-	kernfs_remove(kn_info);
-	kernfs_remove(kn_mongrp);
-	kernfs_remove(kn_mondata);
-}
-
-/**
- * mon_get_kn_priv() - Get the mon_data priv data for this event.
- *
- * The same values are used across the mon_data directories of all control a=
nd
- * monitor groups for the same event in the same domain. Keep a list of
- * allocated structures and re-use an existing one with the same values for
- * @rid, @domid, etc.
- *
- * @rid:    The resource id for the event file being created.
- * @domid:  The domain id for the event file being created.
- * @mevt:   The type of event file being created.
- * @do_sum: Whether SNC summing monitors are being created.
- */
-static struct mon_data *mon_get_kn_priv(enum resctrl_res_level rid, int domi=
d,
-					struct mon_evt *mevt,
-					bool do_sum)
-{
-	struct mon_data *priv;
-
-	lockdep_assert_held(&rdtgroup_mutex);
-
-	list_for_each_entry(priv, &mon_data_kn_priv_list, list) {
-		if (priv->rid =3D=3D rid && priv->domid =3D=3D domid &&
-		    priv->sum =3D=3D do_sum && priv->evtid =3D=3D mevt->evtid)
-			return priv;
-	}
-
-	priv =3D kzalloc(sizeof(*priv), GFP_KERNEL);
-	if (!priv)
-		return NULL;
-
-	priv->rid =3D rid;
-	priv->domid =3D domid;
-	priv->sum =3D do_sum;
-	priv->evtid =3D mevt->evtid;
-	list_add_tail(&priv->list, &mon_data_kn_priv_list);
-
-	return priv;
-}
-
-/**
- * mon_put_kn_priv() - Free all allocated mon_data structures.
- *
- * Called when resctrl file system is unmounted.
- */
-static void mon_put_kn_priv(void)
-{
-	struct mon_data *priv, *tmp;
-
-	lockdep_assert_held(&rdtgroup_mutex);
-
-	list_for_each_entry_safe(priv, tmp, &mon_data_kn_priv_list, list) {
-		list_del(&priv->list);
-		kfree(priv);
-	}
-}
-
-static void resctrl_fs_teardown(void)
-{
-	lockdep_assert_held(&rdtgroup_mutex);
-
-	/* Cleared by rdtgroup_destroy_root() */
-	if (!rdtgroup_default.kn)
-		return;
-
-	rmdir_all_sub();
-	mon_put_kn_priv();
-	rdt_pseudo_lock_release();
-	rdtgroup_default.mode =3D RDT_MODE_SHAREABLE;
-	closid_exit();
-	schemata_list_destroy();
-	rdtgroup_destroy_root();
-}
-
-static void rdt_kill_sb(struct super_block *sb)
-{
-	struct rdt_resource *r;
-
-	cpus_read_lock();
-	mutex_lock(&rdtgroup_mutex);
-
-	rdt_disable_ctx();
-
-	/* Put everything back to default values. */
-	for_each_alloc_capable_rdt_resource(r)
-		resctrl_arch_reset_all_ctrls(r);
-
-	resctrl_fs_teardown();
-	if (resctrl_arch_alloc_capable())
-		resctrl_arch_disable_alloc();
-	if (resctrl_arch_mon_capable())
-		resctrl_arch_disable_mon();
-	resctrl_mounted =3D false;
-	kernfs_kill_sb(sb);
-	mutex_unlock(&rdtgroup_mutex);
-	cpus_read_unlock();
-}
-
-static struct file_system_type rdt_fs_type =3D {
-	.name			=3D "resctrl",
-	.init_fs_context	=3D rdt_init_fs_context,
-	.parameters		=3D rdt_fs_parameters,
-	.kill_sb		=3D rdt_kill_sb,
-};
-
-static int mon_addfile(struct kernfs_node *parent_kn, const char *name,
-		       void *priv)
-{
-	struct kernfs_node *kn;
-	int ret =3D 0;
-
-	kn =3D __kernfs_create_file(parent_kn, name, 0444,
-				  GLOBAL_ROOT_UID, GLOBAL_ROOT_GID, 0,
-				  &kf_mondata_ops, priv, NULL, NULL);
-	if (IS_ERR(kn))
-		return PTR_ERR(kn);
-
-	ret =3D rdtgroup_kn_set_ugid(kn);
-	if (ret) {
-		kernfs_remove(kn);
-		return ret;
-	}
-
-	return ret;
-}
-
-static void mon_rmdir_one_subdir(struct kernfs_node *pkn, char *name, char *=
subname)
-{
-	struct kernfs_node *kn;
-
-	kn =3D kernfs_find_and_get(pkn, name);
-	if (!kn)
-		return;
-	kernfs_put(kn);
-
-	if (kn->dir.subdirs <=3D 1)
-		kernfs_remove(kn);
-	else
-		kernfs_remove_by_name(kn, subname);
-}
-
-/*
- * Remove all subdirectories of mon_data of ctrl_mon groups
- * and monitor groups for the given domain.
- * Remove files and directories containing "sum" of domain data
- * when last domain being summed is removed.
- */
-static void rmdir_mondata_subdir_allrdtgrp(struct rdt_resource *r,
-					   struct rdt_mon_domain *d)
-{
-	struct rdtgroup *prgrp, *crgrp;
-	char subname[32];
-	bool snc_mode;
-	char name[32];
-
-	snc_mode =3D r->mon_scope =3D=3D RESCTRL_L3_NODE;
-	sprintf(name, "mon_%s_%02d", r->name, snc_mode ? d->ci->id : d->hdr.id);
-	if (snc_mode)
-		sprintf(subname, "mon_sub_%s_%02d", r->name, d->hdr.id);
-
-	list_for_each_entry(prgrp, &rdt_all_groups, rdtgroup_list) {
-		mon_rmdir_one_subdir(prgrp->mon.mon_data_kn, name, subname);
-
-		list_for_each_entry(crgrp, &prgrp->mon.crdtgrp_list, mon.crdtgrp_list)
-			mon_rmdir_one_subdir(crgrp->mon.mon_data_kn, name, subname);
-	}
-}
-
-static int mon_add_all_files(struct kernfs_node *kn, struct rdt_mon_domain *=
d,
-			     struct rdt_resource *r, struct rdtgroup *prgrp,
-			     bool do_sum)
-{
-	struct rmid_read rr =3D {0};
-	struct mon_data *priv;
-	struct mon_evt *mevt;
-	int ret, domid;
-
-	if (WARN_ON(list_empty(&r->evt_list)))
-		return -EPERM;
-
-	list_for_each_entry(mevt, &r->evt_list, list) {
-		domid =3D do_sum ? d->ci->id : d->hdr.id;
-		priv =3D mon_get_kn_priv(r->rid, domid, mevt, do_sum);
-		if (WARN_ON_ONCE(!priv))
-			return -EINVAL;
-
-		ret =3D mon_addfile(kn, mevt->name, priv);
-		if (ret)
-			return ret;
-
-		if (!do_sum && resctrl_is_mbm_event(mevt->evtid))
-			mon_event_read(&rr, r, d, prgrp, &d->hdr.cpu_mask, mevt->evtid, true);
-	}
-
-	return 0;
-}
-
-static int mkdir_mondata_subdir(struct kernfs_node *parent_kn,
-				struct rdt_mon_domain *d,
-				struct rdt_resource *r, struct rdtgroup *prgrp)
-{
-	struct kernfs_node *kn, *ckn;
-	char name[32];
-	bool snc_mode;
-	int ret =3D 0;
-
-	lockdep_assert_held(&rdtgroup_mutex);
-
-	snc_mode =3D r->mon_scope =3D=3D RESCTRL_L3_NODE;
-	sprintf(name, "mon_%s_%02d", r->name, snc_mode ? d->ci->id : d->hdr.id);
-	kn =3D kernfs_find_and_get(parent_kn, name);
-	if (kn) {
-		/*
-		 * rdtgroup_mutex will prevent this directory from being
-		 * removed. No need to keep this hold.
-		 */
-		kernfs_put(kn);
-	} else {
-		kn =3D kernfs_create_dir(parent_kn, name, parent_kn->mode, prgrp);
-		if (IS_ERR(kn))
-			return PTR_ERR(kn);
-
-		ret =3D rdtgroup_kn_set_ugid(kn);
-		if (ret)
-			goto out_destroy;
-		ret =3D mon_add_all_files(kn, d, r, prgrp, snc_mode);
-		if (ret)
-			goto out_destroy;
-	}
-
-	if (snc_mode) {
-		sprintf(name, "mon_sub_%s_%02d", r->name, d->hdr.id);
-		ckn =3D kernfs_create_dir(kn, name, parent_kn->mode, prgrp);
-		if (IS_ERR(ckn)) {
-			ret =3D -EINVAL;
-			goto out_destroy;
-		}
-
-		ret =3D rdtgroup_kn_set_ugid(ckn);
-		if (ret)
-			goto out_destroy;
-
-		ret =3D mon_add_all_files(ckn, d, r, prgrp, false);
-		if (ret)
-			goto out_destroy;
-	}
-
-	kernfs_activate(kn);
-	return 0;
-
-out_destroy:
-	kernfs_remove(kn);
-	return ret;
-}
-
-/*
- * Add all subdirectories of mon_data for "ctrl_mon" groups
- * and "monitor" groups with given domain id.
- */
-static void mkdir_mondata_subdir_allrdtgrp(struct rdt_resource *r,
-					   struct rdt_mon_domain *d)
-{
-	struct kernfs_node *parent_kn;
-	struct rdtgroup *prgrp, *crgrp;
-	struct list_head *head;
-
-	list_for_each_entry(prgrp, &rdt_all_groups, rdtgroup_list) {
-		parent_kn =3D prgrp->mon.mon_data_kn;
-		mkdir_mondata_subdir(parent_kn, d, r, prgrp);
-
-		head =3D &prgrp->mon.crdtgrp_list;
-		list_for_each_entry(crgrp, head, mon.crdtgrp_list) {
-			parent_kn =3D crgrp->mon.mon_data_kn;
-			mkdir_mondata_subdir(parent_kn, d, r, crgrp);
-		}
-	}
-}
-
-static int mkdir_mondata_subdir_alldom(struct kernfs_node *parent_kn,
-				       struct rdt_resource *r,
-				       struct rdtgroup *prgrp)
-{
-	struct rdt_mon_domain *dom;
-	int ret;
-
-	/* Walking r->domains, ensure it can't race with cpuhp */
-	lockdep_assert_cpus_held();
-
-	list_for_each_entry(dom, &r->mon_domains, hdr.list) {
-		ret =3D mkdir_mondata_subdir(parent_kn, dom, r, prgrp);
-		if (ret)
-			return ret;
-	}
-
-	return 0;
-}
-
-/*
- * This creates a directory mon_data which contains the monitored data.
- *
- * mon_data has one directory for each domain which are named
- * in the format mon_<domain_name>_<domain_id>. For ex: A mon_data
- * with L3 domain looks as below:
- * ./mon_data:
- * mon_L3_00
- * mon_L3_01
- * mon_L3_02
- * ...
- *
- * Each domain directory has one file per event:
- * ./mon_L3_00/:
- * llc_occupancy
- *
- */
-static int mkdir_mondata_all(struct kernfs_node *parent_kn,
-			     struct rdtgroup *prgrp,
-			     struct kernfs_node **dest_kn)
-{
-	struct rdt_resource *r;
-	struct kernfs_node *kn;
-	int ret;
-
-	/*
-	 * Create the mon_data directory first.
-	 */
-	ret =3D mongroup_create_dir(parent_kn, prgrp, "mon_data", &kn);
-	if (ret)
-		return ret;
-
-	if (dest_kn)
-		*dest_kn =3D kn;
-
-	/*
-	 * Create the subdirectories for each domain. Note that all events
-	 * in a domain like L3 are grouped into a resource whose domain is L3
-	 */
-	for_each_mon_capable_rdt_resource(r) {
-		ret =3D mkdir_mondata_subdir_alldom(kn, r, prgrp);
-		if (ret)
-			goto out_destroy;
-	}
-
-	return 0;
-
-out_destroy:
-	kernfs_remove(kn);
-	return ret;
-}
-
-/**
- * cbm_ensure_valid - Enforce validity on provided CBM
- * @_val:	Candidate CBM
- * @r:		RDT resource to which the CBM belongs
- *
- * The provided CBM represents all cache portions available for use. This
- * may be represented by a bitmap that does not consist of contiguous ones
- * and thus be an invalid CBM.
- * Here the provided CBM is forced to be a valid CBM by only considering
- * the first set of contiguous bits as valid and clearing all bits.
- * The intention here is to provide a valid default CBM with which a new
- * resource group is initialized. The user can follow this with a
- * modification to the CBM if the default does not satisfy the
- * requirements.
- */
-static u32 cbm_ensure_valid(u32 _val, struct rdt_resource *r)
-{
-	unsigned int cbm_len =3D r->cache.cbm_len;
-	unsigned long first_bit, zero_bit;
-	unsigned long val =3D _val;
-
-	if (!val)
-		return 0;
-
-	first_bit =3D find_first_bit(&val, cbm_len);
-	zero_bit =3D find_next_zero_bit(&val, cbm_len, first_bit);
-
-	/* Clear any remaining bits to ensure contiguous region */
-	bitmap_clear(&val, zero_bit, cbm_len - zero_bit);
-	return (u32)val;
-}
-
-/*
- * Initialize cache resources per RDT domain
- *
- * Set the RDT domain up to start off with all usable allocations. That is,
- * all shareable and unused bits. All-zero CBM is invalid.
- */
-static int __init_one_rdt_domain(struct rdt_ctrl_domain *d, struct resctrl_s=
chema *s,
-				 u32 closid)
-{
-	enum resctrl_conf_type peer_type =3D resctrl_peer_type(s->conf_type);
-	enum resctrl_conf_type t =3D s->conf_type;
-	struct resctrl_staged_config *cfg;
-	struct rdt_resource *r =3D s->res;
-	u32 used_b =3D 0, unused_b =3D 0;
-	unsigned long tmp_cbm;
-	enum rdtgrp_mode mode;
-	u32 peer_ctl, ctrl_val;
-	int i;
-
-	cfg =3D &d->staged_config[t];
-	cfg->have_new_ctrl =3D false;
-	cfg->new_ctrl =3D r->cache.shareable_bits;
-	used_b =3D r->cache.shareable_bits;
-	for (i =3D 0; i < closids_supported(); i++) {
-		if (closid_allocated(i) && i !=3D closid) {
-			mode =3D rdtgroup_mode_by_closid(i);
-			if (mode =3D=3D RDT_MODE_PSEUDO_LOCKSETUP)
-				/*
-				 * ctrl values for locksetup aren't relevant
-				 * until the schemata is written, and the mode
-				 * becomes RDT_MODE_PSEUDO_LOCKED.
-				 */
-				continue;
-			/*
-			 * If CDP is active include peer domain's
-			 * usage to ensure there is no overlap
-			 * with an exclusive group.
-			 */
-			if (resctrl_arch_get_cdp_enabled(r->rid))
-				peer_ctl =3D resctrl_arch_get_config(r, d, i,
-								   peer_type);
-			else
-				peer_ctl =3D 0;
-			ctrl_val =3D resctrl_arch_get_config(r, d, i,
-							   s->conf_type);
-			used_b |=3D ctrl_val | peer_ctl;
-			if (mode =3D=3D RDT_MODE_SHAREABLE)
-				cfg->new_ctrl |=3D ctrl_val | peer_ctl;
-		}
-	}
-	if (d->plr && d->plr->cbm > 0)
-		used_b |=3D d->plr->cbm;
-	unused_b =3D used_b ^ (BIT_MASK(r->cache.cbm_len) - 1);
-	unused_b &=3D BIT_MASK(r->cache.cbm_len) - 1;
-	cfg->new_ctrl |=3D unused_b;
-	/*
-	 * Force the initial CBM to be valid, user can
-	 * modify the CBM based on system availability.
-	 */
-	cfg->new_ctrl =3D cbm_ensure_valid(cfg->new_ctrl, r);
-	/*
-	 * Assign the u32 CBM to an unsigned long to ensure that
-	 * bitmap_weight() does not access out-of-bound memory.
-	 */
-	tmp_cbm =3D cfg->new_ctrl;
-	if (bitmap_weight(&tmp_cbm, r->cache.cbm_len) < r->cache.min_cbm_bits) {
-		rdt_last_cmd_printf("No space on %s:%d\n", s->name, d->hdr.id);
-		return -ENOSPC;
-	}
-	cfg->have_new_ctrl =3D true;
-
-	return 0;
-}
-
-/*
- * Initialize cache resources with default values.
- *
- * A new RDT group is being created on an allocation capable (CAT)
- * supporting system. Set this group up to start off with all usable
- * allocations.
- *
- * If there are no more shareable bits available on any domain then
- * the entire allocation will fail.
- */
-static int rdtgroup_init_cat(struct resctrl_schema *s, u32 closid)
-{
-	struct rdt_ctrl_domain *d;
-	int ret;
-
-	list_for_each_entry(d, &s->res->ctrl_domains, hdr.list) {
-		ret =3D __init_one_rdt_domain(d, s, closid);
-		if (ret < 0)
-			return ret;
-	}
-
-	return 0;
-}
-
-/* Initialize MBA resource with default values. */
-static void rdtgroup_init_mba(struct rdt_resource *r, u32 closid)
-{
-	struct resctrl_staged_config *cfg;
-	struct rdt_ctrl_domain *d;
-
-	list_for_each_entry(d, &r->ctrl_domains, hdr.list) {
-		if (is_mba_sc(r)) {
-			d->mbps_val[closid] =3D MBA_MAX_MBPS;
-			continue;
-		}
-
-		cfg =3D &d->staged_config[CDP_NONE];
-		cfg->new_ctrl =3D resctrl_get_default_ctrl(r);
-		cfg->have_new_ctrl =3D true;
-	}
-}
-
-/* Initialize the RDT group's allocations. */
-static int rdtgroup_init_alloc(struct rdtgroup *rdtgrp)
-{
-	struct resctrl_schema *s;
-	struct rdt_resource *r;
-	int ret =3D 0;
-
-	rdt_staged_configs_clear();
-
-	list_for_each_entry(s, &resctrl_schema_all, list) {
-		r =3D s->res;
-		if (r->rid =3D=3D RDT_RESOURCE_MBA ||
-		    r->rid =3D=3D RDT_RESOURCE_SMBA) {
-			rdtgroup_init_mba(r, rdtgrp->closid);
-			if (is_mba_sc(r))
-				continue;
-		} else {
-			ret =3D rdtgroup_init_cat(s, rdtgrp->closid);
-			if (ret < 0)
-				goto out;
-		}
-
-		ret =3D resctrl_arch_update_domains(r, rdtgrp->closid);
-		if (ret < 0) {
-			rdt_last_cmd_puts("Failed to initialize allocations\n");
-			goto out;
-		}
-	}
-
-	rdtgrp->mode =3D RDT_MODE_SHAREABLE;
-
-out:
-	rdt_staged_configs_clear();
-	return ret;
-}
-
-static int mkdir_rdt_prepare_rmid_alloc(struct rdtgroup *rdtgrp)
-{
-	int ret;
-
-	if (!resctrl_arch_mon_capable())
-		return 0;
-
-	ret =3D alloc_rmid(rdtgrp->closid);
-	if (ret < 0) {
-		rdt_last_cmd_puts("Out of RMIDs\n");
-		return ret;
-	}
-	rdtgrp->mon.rmid =3D ret;
-
-	ret =3D mkdir_mondata_all(rdtgrp->kn, rdtgrp, &rdtgrp->mon.mon_data_kn);
-	if (ret) {
-		rdt_last_cmd_puts("kernfs subdir error\n");
-		free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
-		return ret;
-	}
-
-	return 0;
-}
-
-static void mkdir_rdt_prepare_rmid_free(struct rdtgroup *rgrp)
-{
-	if (resctrl_arch_mon_capable())
-		free_rmid(rgrp->closid, rgrp->mon.rmid);
-}
-
-/*
- * We allow creating mon groups only with in a directory called "mon_groups"
- * which is present in every ctrl_mon group. Check if this is a valid
- * "mon_groups" directory.
- *
- * 1. The directory should be named "mon_groups".
- * 2. The mon group itself should "not" be named "mon_groups".
- *   This makes sure "mon_groups" directory always has a ctrl_mon group
- *   as parent.
- */
-static bool is_mon_groups(struct kernfs_node *kn, const char *name)
-{
-	return (!strcmp(rdt_kn_name(kn), "mon_groups") &&
-		strcmp(name, "mon_groups"));
-}
-
-static int mkdir_rdt_prepare(struct kernfs_node *parent_kn,
-			     const char *name, umode_t mode,
-			     enum rdt_group_type rtype, struct rdtgroup **r)
-{
-	struct rdtgroup *prdtgrp, *rdtgrp;
-	unsigned long files =3D 0;
-	struct kernfs_node *kn;
-	int ret;
-
-	prdtgrp =3D rdtgroup_kn_lock_live(parent_kn);
-	if (!prdtgrp) {
-		ret =3D -ENODEV;
-		goto out_unlock;
-	}
-
-	/*
-	 * Check that the parent directory for a monitor group is a "mon_groups"
-	 * directory.
-	 */
-	if (rtype =3D=3D RDTMON_GROUP && !is_mon_groups(parent_kn, name)) {
-		ret =3D -EPERM;
-		goto out_unlock;
-	}
-
-	if (rtype =3D=3D RDTMON_GROUP &&
-	    (prdtgrp->mode =3D=3D RDT_MODE_PSEUDO_LOCKSETUP ||
-	     prdtgrp->mode =3D=3D RDT_MODE_PSEUDO_LOCKED)) {
-		ret =3D -EINVAL;
-		rdt_last_cmd_puts("Pseudo-locking in progress\n");
-		goto out_unlock;
-	}
-
-	/* allocate the rdtgroup. */
-	rdtgrp =3D kzalloc(sizeof(*rdtgrp), GFP_KERNEL);
-	if (!rdtgrp) {
-		ret =3D -ENOSPC;
-		rdt_last_cmd_puts("Kernel out of memory\n");
-		goto out_unlock;
-	}
-	*r =3D rdtgrp;
-	rdtgrp->mon.parent =3D prdtgrp;
-	rdtgrp->type =3D rtype;
-	INIT_LIST_HEAD(&rdtgrp->mon.crdtgrp_list);
-
-	/* kernfs creates the directory for rdtgrp */
-	kn =3D kernfs_create_dir(parent_kn, name, mode, rdtgrp);
-	if (IS_ERR(kn)) {
-		ret =3D PTR_ERR(kn);
-		rdt_last_cmd_puts("kernfs create error\n");
-		goto out_free_rgrp;
-	}
-	rdtgrp->kn =3D kn;
-
-	/*
-	 * kernfs_remove() will drop the reference count on "kn" which
-	 * will free it. But we still need it to stick around for the
-	 * rdtgroup_kn_unlock(kn) call. Take one extra reference here,
-	 * which will be dropped by kernfs_put() in rdtgroup_remove().
-	 */
-	kernfs_get(kn);
-
-	ret =3D rdtgroup_kn_set_ugid(kn);
-	if (ret) {
-		rdt_last_cmd_puts("kernfs perm error\n");
-		goto out_destroy;
-	}
-
-	if (rtype =3D=3D RDTCTRL_GROUP) {
-		files =3D RFTYPE_BASE | RFTYPE_CTRL;
-		if (resctrl_arch_mon_capable())
-			files |=3D RFTYPE_MON;
-	} else {
-		files =3D RFTYPE_BASE | RFTYPE_MON;
-	}
-
-	ret =3D rdtgroup_add_files(kn, files);
-	if (ret) {
-		rdt_last_cmd_puts("kernfs fill error\n");
-		goto out_destroy;
-	}
-
-	/*
-	 * The caller unlocks the parent_kn upon success.
-	 */
-	return 0;
-
-out_destroy:
-	kernfs_put(rdtgrp->kn);
-	kernfs_remove(rdtgrp->kn);
-out_free_rgrp:
-	kfree(rdtgrp);
-out_unlock:
-	rdtgroup_kn_unlock(parent_kn);
-	return ret;
-}
-
-static void mkdir_rdt_prepare_clean(struct rdtgroup *rgrp)
-{
-	kernfs_remove(rgrp->kn);
-	rdtgroup_remove(rgrp);
-}
-
-/*
- * Create a monitor group under "mon_groups" directory of a control
- * and monitor group(ctrl_mon). This is a resource group
- * to monitor a subset of tasks and cpus in its parent ctrl_mon group.
- */
-static int rdtgroup_mkdir_mon(struct kernfs_node *parent_kn,
-			      const char *name, umode_t mode)
-{
-	struct rdtgroup *rdtgrp, *prgrp;
-	int ret;
-
-	ret =3D mkdir_rdt_prepare(parent_kn, name, mode, RDTMON_GROUP, &rdtgrp);
-	if (ret)
-		return ret;
-
-	prgrp =3D rdtgrp->mon.parent;
-	rdtgrp->closid =3D prgrp->closid;
-
-	ret =3D mkdir_rdt_prepare_rmid_alloc(rdtgrp);
-	if (ret) {
-		mkdir_rdt_prepare_clean(rdtgrp);
-		goto out_unlock;
-	}
-
-	kernfs_activate(rdtgrp->kn);
-
-	/*
-	 * Add the rdtgrp to the list of rdtgrps the parent
-	 * ctrl_mon group has to track.
-	 */
-	list_add_tail(&rdtgrp->mon.crdtgrp_list, &prgrp->mon.crdtgrp_list);
-
-out_unlock:
-	rdtgroup_kn_unlock(parent_kn);
-	return ret;
-}
-
-/*
- * These are rdtgroups created under the root directory. Can be used
- * to allocate and monitor resources.
- */
-static int rdtgroup_mkdir_ctrl_mon(struct kernfs_node *parent_kn,
-				   const char *name, umode_t mode)
-{
-	struct rdtgroup *rdtgrp;
-	struct kernfs_node *kn;
-	u32 closid;
-	int ret;
-
-	ret =3D mkdir_rdt_prepare(parent_kn, name, mode, RDTCTRL_GROUP, &rdtgrp);
-	if (ret)
-		return ret;
-
-	kn =3D rdtgrp->kn;
-	ret =3D closid_alloc();
-	if (ret < 0) {
-		rdt_last_cmd_puts("Out of CLOSIDs\n");
-		goto out_common_fail;
-	}
-	closid =3D ret;
-	ret =3D 0;
-
-	rdtgrp->closid =3D closid;
-
-	ret =3D mkdir_rdt_prepare_rmid_alloc(rdtgrp);
-	if (ret)
-		goto out_closid_free;
-
-	kernfs_activate(rdtgrp->kn);
-
-	ret =3D rdtgroup_init_alloc(rdtgrp);
-	if (ret < 0)
-		goto out_rmid_free;
-
-	list_add(&rdtgrp->rdtgroup_list, &rdt_all_groups);
-
-	if (resctrl_arch_mon_capable()) {
-		/*
-		 * Create an empty mon_groups directory to hold the subset
-		 * of tasks and cpus to monitor.
-		 */
-		ret =3D mongroup_create_dir(kn, rdtgrp, "mon_groups", NULL);
-		if (ret) {
-			rdt_last_cmd_puts("kernfs subdir error\n");
-			goto out_del_list;
-		}
-		if (is_mba_sc(NULL))
-			rdtgrp->mba_mbps_event =3D mba_mbps_default_event;
-	}
-
-	goto out_unlock;
-
-out_del_list:
-	list_del(&rdtgrp->rdtgroup_list);
-out_rmid_free:
-	mkdir_rdt_prepare_rmid_free(rdtgrp);
-out_closid_free:
-	closid_free(closid);
-out_common_fail:
-	mkdir_rdt_prepare_clean(rdtgrp);
-out_unlock:
-	rdtgroup_kn_unlock(parent_kn);
-	return ret;
-}
-
-static int rdtgroup_mkdir(struct kernfs_node *parent_kn, const char *name,
-			  umode_t mode)
-{
-	/* Do not accept '\n' to avoid unparsable situation. */
-	if (strchr(name, '\n'))
-		return -EINVAL;
-
-	/*
-	 * If the parent directory is the root directory and RDT
-	 * allocation is supported, add a control and monitoring
-	 * subdirectory
-	 */
-	if (resctrl_arch_alloc_capable() && parent_kn =3D=3D rdtgroup_default.kn)
-		return rdtgroup_mkdir_ctrl_mon(parent_kn, name, mode);
-
-	/* Else, attempt to add a monitoring subdirectory. */
-	if (resctrl_arch_mon_capable())
-		return rdtgroup_mkdir_mon(parent_kn, name, mode);
-
-	return -EPERM;
-}
-
-static int rdtgroup_rmdir_mon(struct rdtgroup *rdtgrp, cpumask_var_t tmpmask)
-{
-	struct rdtgroup *prdtgrp =3D rdtgrp->mon.parent;
-	u32 closid, rmid;
-	int cpu;
-
-	/* Give any tasks back to the parent group */
-	rdt_move_group_tasks(rdtgrp, prdtgrp, tmpmask);
-
-	/*
-	 * Update per cpu closid/rmid of the moved CPUs first.
-	 * Note: the closid will not change, but the arch code still needs it.
-	 */
-	closid =3D prdtgrp->closid;
-	rmid =3D prdtgrp->mon.rmid;
-	for_each_cpu(cpu, &rdtgrp->cpu_mask)
-		resctrl_arch_set_cpu_default_closid_rmid(cpu, closid, rmid);
-
-	/*
-	 * Update the MSR on moved CPUs and CPUs which have moved
-	 * task running on them.
-	 */
-	cpumask_or(tmpmask, tmpmask, &rdtgrp->cpu_mask);
-	update_closid_rmid(tmpmask, NULL);
-
-	rdtgrp->flags =3D RDT_DELETED;
-	free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
-
-	/*
-	 * Remove the rdtgrp from the parent ctrl_mon group's list
-	 */
-	WARN_ON(list_empty(&prdtgrp->mon.crdtgrp_list));
-	list_del(&rdtgrp->mon.crdtgrp_list);
-
-	kernfs_remove(rdtgrp->kn);
-
-	return 0;
-}
-
-static int rdtgroup_ctrl_remove(struct rdtgroup *rdtgrp)
-{
-	rdtgrp->flags =3D RDT_DELETED;
-	list_del(&rdtgrp->rdtgroup_list);
-
-	kernfs_remove(rdtgrp->kn);
-	return 0;
-}
-
-static int rdtgroup_rmdir_ctrl(struct rdtgroup *rdtgrp, cpumask_var_t tmpmas=
k)
-{
-	u32 closid, rmid;
-	int cpu;
-
-	/* Give any tasks back to the default group */
-	rdt_move_group_tasks(rdtgrp, &rdtgroup_default, tmpmask);
-
-	/* Give any CPUs back to the default group */
-	cpumask_or(&rdtgroup_default.cpu_mask,
-		   &rdtgroup_default.cpu_mask, &rdtgrp->cpu_mask);
-
-	/* Update per cpu closid and rmid of the moved CPUs first */
-	closid =3D rdtgroup_default.closid;
-	rmid =3D rdtgroup_default.mon.rmid;
-	for_each_cpu(cpu, &rdtgrp->cpu_mask)
-		resctrl_arch_set_cpu_default_closid_rmid(cpu, closid, rmid);
-
-	/*
-	 * Update the MSR on moved CPUs and CPUs which have moved
-	 * task running on them.
-	 */
-	cpumask_or(tmpmask, tmpmask, &rdtgrp->cpu_mask);
-	update_closid_rmid(tmpmask, NULL);
-
-	free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
-	closid_free(rdtgrp->closid);
-
-	rdtgroup_ctrl_remove(rdtgrp);
-
-	/*
-	 * Free all the child monitor group rmids.
-	 */
-	free_all_child_rdtgrp(rdtgrp);
-
-	return 0;
-}
-
-static struct kernfs_node *rdt_kn_parent(struct kernfs_node *kn)
-{
-	/*
-	 * Valid within the RCU section it was obtained or while rdtgroup_mutex
-	 * is held.
-	 */
-	return rcu_dereference_check(kn->__parent, lockdep_is_held(&rdtgroup_mutex)=
);
-}
-
-static int rdtgroup_rmdir(struct kernfs_node *kn)
-{
-	struct kernfs_node *parent_kn;
-	struct rdtgroup *rdtgrp;
-	cpumask_var_t tmpmask;
-	int ret =3D 0;
-
-	if (!zalloc_cpumask_var(&tmpmask, GFP_KERNEL))
-		return -ENOMEM;
-
-	rdtgrp =3D rdtgroup_kn_lock_live(kn);
-	if (!rdtgrp) {
-		ret =3D -EPERM;
-		goto out;
-	}
-	parent_kn =3D rdt_kn_parent(kn);
-
-	/*
-	 * If the rdtgroup is a ctrl_mon group and parent directory
-	 * is the root directory, remove the ctrl_mon group.
-	 *
-	 * If the rdtgroup is a mon group and parent directory
-	 * is a valid "mon_groups" directory, remove the mon group.
-	 */
-	if (rdtgrp->type =3D=3D RDTCTRL_GROUP && parent_kn =3D=3D rdtgroup_default.=
kn &&
-	    rdtgrp !=3D &rdtgroup_default) {
-		if (rdtgrp->mode =3D=3D RDT_MODE_PSEUDO_LOCKSETUP ||
-		    rdtgrp->mode =3D=3D RDT_MODE_PSEUDO_LOCKED) {
-			ret =3D rdtgroup_ctrl_remove(rdtgrp);
-		} else {
-			ret =3D rdtgroup_rmdir_ctrl(rdtgrp, tmpmask);
-		}
-	} else if (rdtgrp->type =3D=3D RDTMON_GROUP &&
-		 is_mon_groups(parent_kn, rdt_kn_name(kn))) {
-		ret =3D rdtgroup_rmdir_mon(rdtgrp, tmpmask);
-	} else {
-		ret =3D -EPERM;
-	}
-
-out:
-	rdtgroup_kn_unlock(kn);
-	free_cpumask_var(tmpmask);
-	return ret;
-}
-
-/**
- * mongrp_reparent() - replace parent CTRL_MON group of a MON group
- * @rdtgrp:		the MON group whose parent should be replaced
- * @new_prdtgrp:	replacement parent CTRL_MON group for @rdtgrp
- * @cpus:		cpumask provided by the caller for use during this call
- *
- * Replaces the parent CTRL_MON group for a MON group, resulting in all memb=
er
- * tasks' CLOSID immediately changing to that of the new parent group.
- * Monitoring data for the group is unaffected by this operation.
- */
-static void mongrp_reparent(struct rdtgroup *rdtgrp,
-			    struct rdtgroup *new_prdtgrp,
-			    cpumask_var_t cpus)
-{
-	struct rdtgroup *prdtgrp =3D rdtgrp->mon.parent;
-
-	WARN_ON(rdtgrp->type !=3D RDTMON_GROUP);
-	WARN_ON(new_prdtgrp->type !=3D RDTCTRL_GROUP);
-
-	/* Nothing to do when simply renaming a MON group. */
-	if (prdtgrp =3D=3D new_prdtgrp)
-		return;
-
-	WARN_ON(list_empty(&prdtgrp->mon.crdtgrp_list));
-	list_move_tail(&rdtgrp->mon.crdtgrp_list,
-		       &new_prdtgrp->mon.crdtgrp_list);
-
-	rdtgrp->mon.parent =3D new_prdtgrp;
-	rdtgrp->closid =3D new_prdtgrp->closid;
-
-	/* Propagate updated closid to all tasks in this group. */
-	rdt_move_group_tasks(rdtgrp, rdtgrp, cpus);
-
-	update_closid_rmid(cpus, NULL);
-}
-
-static int rdtgroup_rename(struct kernfs_node *kn,
-			   struct kernfs_node *new_parent, const char *new_name)
-{
-	struct kernfs_node *kn_parent;
-	struct rdtgroup *new_prdtgrp;
-	struct rdtgroup *rdtgrp;
-	cpumask_var_t tmpmask;
-	int ret;
-
-	rdtgrp =3D kernfs_to_rdtgroup(kn);
-	new_prdtgrp =3D kernfs_to_rdtgroup(new_parent);
-	if (!rdtgrp || !new_prdtgrp)
-		return -ENOENT;
-
-	/* Release both kernfs active_refs before obtaining rdtgroup mutex. */
-	rdtgroup_kn_get(rdtgrp, kn);
-	rdtgroup_kn_get(new_prdtgrp, new_parent);
-
-	mutex_lock(&rdtgroup_mutex);
-
-	rdt_last_cmd_clear();
-
-	/*
-	 * Don't allow kernfs_to_rdtgroup() to return a parent rdtgroup if
-	 * either kernfs_node is a file.
-	 */
-	if (kernfs_type(kn) !=3D KERNFS_DIR ||
-	    kernfs_type(new_parent) !=3D KERNFS_DIR) {
-		rdt_last_cmd_puts("Source and destination must be directories");
-		ret =3D -EPERM;
-		goto out;
-	}
-
-	if ((rdtgrp->flags & RDT_DELETED) || (new_prdtgrp->flags & RDT_DELETED)) {
-		ret =3D -ENOENT;
-		goto out;
-	}
-
-	kn_parent =3D rdt_kn_parent(kn);
-	if (rdtgrp->type !=3D RDTMON_GROUP || !kn_parent ||
-	    !is_mon_groups(kn_parent, rdt_kn_name(kn))) {
-		rdt_last_cmd_puts("Source must be a MON group\n");
-		ret =3D -EPERM;
-		goto out;
-	}
-
-	if (!is_mon_groups(new_parent, new_name)) {
-		rdt_last_cmd_puts("Destination must be a mon_groups subdirectory\n");
-		ret =3D -EPERM;
-		goto out;
-	}
-
-	/*
-	 * If the MON group is monitoring CPUs, the CPUs must be assigned to the
-	 * current parent CTRL_MON group and therefore cannot be assigned to
-	 * the new parent, making the move illegal.
-	 */
-	if (!cpumask_empty(&rdtgrp->cpu_mask) &&
-	    rdtgrp->mon.parent !=3D new_prdtgrp) {
-		rdt_last_cmd_puts("Cannot move a MON group that monitors CPUs\n");
-		ret =3D -EPERM;
-		goto out;
-	}
-
-	/*
-	 * Allocate the cpumask for use in mongrp_reparent() to avoid the
-	 * possibility of failing to allocate it after kernfs_rename() has
-	 * succeeded.
-	 */
-	if (!zalloc_cpumask_var(&tmpmask, GFP_KERNEL)) {
-		ret =3D -ENOMEM;
-		goto out;
-	}
-
-	/*
-	 * Perform all input validation and allocations needed to ensure
-	 * mongrp_reparent() will succeed before calling kernfs_rename(),
-	 * otherwise it would be necessary to revert this call if
-	 * mongrp_reparent() failed.
-	 */
-	ret =3D kernfs_rename(kn, new_parent, new_name);
-	if (!ret)
-		mongrp_reparent(rdtgrp, new_prdtgrp, tmpmask);
-
-	free_cpumask_var(tmpmask);
-
-out:
-	mutex_unlock(&rdtgroup_mutex);
-	rdtgroup_kn_put(rdtgrp, kn);
-	rdtgroup_kn_put(new_prdtgrp, new_parent);
-	return ret;
-}
-
-static int rdtgroup_show_options(struct seq_file *seq, struct kernfs_root *k=
f)
-{
-	if (resctrl_arch_get_cdp_enabled(RDT_RESOURCE_L3))
-		seq_puts(seq, ",cdp");
-
-	if (resctrl_arch_get_cdp_enabled(RDT_RESOURCE_L2))
-		seq_puts(seq, ",cdpl2");
-
-	if (is_mba_sc(resctrl_arch_get_resource(RDT_RESOURCE_MBA)))
-		seq_puts(seq, ",mba_MBps");
-
-	if (resctrl_debug)
-		seq_puts(seq, ",debug");
-
-	return 0;
-}
-
-static struct kernfs_syscall_ops rdtgroup_kf_syscall_ops =3D {
-	.mkdir		=3D rdtgroup_mkdir,
-	.rmdir		=3D rdtgroup_rmdir,
-	.rename		=3D rdtgroup_rename,
-	.show_options	=3D rdtgroup_show_options,
-};
-
-static int rdtgroup_setup_root(struct rdt_fs_context *ctx)
-{
-	rdt_root =3D kernfs_create_root(&rdtgroup_kf_syscall_ops,
-				      KERNFS_ROOT_CREATE_DEACTIVATED |
-				      KERNFS_ROOT_EXTRA_OPEN_PERM_CHECK,
-				      &rdtgroup_default);
-	if (IS_ERR(rdt_root))
-		return PTR_ERR(rdt_root);
-
-	ctx->kfc.root =3D rdt_root;
-	rdtgroup_default.kn =3D kernfs_root_to_node(rdt_root);
-
-	return 0;
-}
-
-static void rdtgroup_destroy_root(void)
-{
-	lockdep_assert_held(&rdtgroup_mutex);
-
-	kernfs_destroy_root(rdt_root);
-	rdtgroup_default.kn =3D NULL;
-}
-
-static void rdtgroup_setup_default(void)
-{
-	mutex_lock(&rdtgroup_mutex);
-
-	rdtgroup_default.closid =3D RESCTRL_RESERVED_CLOSID;
-	rdtgroup_default.mon.rmid =3D RESCTRL_RESERVED_RMID;
-	rdtgroup_default.type =3D RDTCTRL_GROUP;
-	INIT_LIST_HEAD(&rdtgroup_default.mon.crdtgrp_list);
-
-	list_add(&rdtgroup_default.rdtgroup_list, &rdt_all_groups);
-
-	mutex_unlock(&rdtgroup_mutex);
-}
-
-static void domain_destroy_mon_state(struct rdt_mon_domain *d)
-{
-	bitmap_free(d->rmid_busy_llc);
-	kfree(d->mbm_total);
-	kfree(d->mbm_local);
-}
-
-void resctrl_offline_ctrl_domain(struct rdt_resource *r, struct rdt_ctrl_dom=
ain *d)
-{
-	mutex_lock(&rdtgroup_mutex);
-
-	if (supports_mba_mbps() && r->rid =3D=3D RDT_RESOURCE_MBA)
-		mba_sc_domain_destroy(r, d);
-
-	mutex_unlock(&rdtgroup_mutex);
-}
-
-void resctrl_offline_mon_domain(struct rdt_resource *r, struct rdt_mon_domai=
n *d)
-{
-	mutex_lock(&rdtgroup_mutex);
-
-	/*
-	 * If resctrl is mounted, remove all the
-	 * per domain monitor data directories.
-	 */
-	if (resctrl_mounted && resctrl_arch_mon_capable())
-		rmdir_mondata_subdir_allrdtgrp(r, d);
-
-	if (resctrl_is_mbm_enabled())
-		cancel_delayed_work(&d->mbm_over);
-	if (resctrl_arch_is_llc_occupancy_enabled() && has_busy_rmid(d)) {
-		/*
-		 * When a package is going down, forcefully
-		 * decrement rmid->ebusy. There is no way to know
-		 * that the L3 was flushed and hence may lead to
-		 * incorrect counts in rare scenarios, but leaving
-		 * the RMID as busy creates RMID leaks if the
-		 * package never comes back.
-		 */
-		__check_limbo(d, true);
-		cancel_delayed_work(&d->cqm_limbo);
-	}
-
-	domain_destroy_mon_state(d);
-
-	mutex_unlock(&rdtgroup_mutex);
-}
-
-/**
- * domain_setup_mon_state() -  Initialise domain monitoring structures.
- * @r:	The resource for the newly online domain.
- * @d:	The newly online domain.
- *
- * Allocate monitor resources that belong to this domain.
- * Called when the first CPU of a domain comes online, regardless of whether
- * the filesystem is mounted.
- * During boot this may be called before global allocations have been made by
- * resctrl_mon_resource_init().
- *
- * Returns 0 for success, or -ENOMEM.
- */
-static int domain_setup_mon_state(struct rdt_resource *r, struct rdt_mon_dom=
ain *d)
-{
-	u32 idx_limit =3D resctrl_arch_system_num_rmid_idx();
-	size_t tsize;
-
-	if (resctrl_arch_is_llc_occupancy_enabled()) {
-		d->rmid_busy_llc =3D bitmap_zalloc(idx_limit, GFP_KERNEL);
-		if (!d->rmid_busy_llc)
-			return -ENOMEM;
-	}
-	if (resctrl_arch_is_mbm_total_enabled()) {
-		tsize =3D sizeof(*d->mbm_total);
-		d->mbm_total =3D kcalloc(idx_limit, tsize, GFP_KERNEL);
-		if (!d->mbm_total) {
-			bitmap_free(d->rmid_busy_llc);
-			return -ENOMEM;
-		}
-	}
-	if (resctrl_arch_is_mbm_local_enabled()) {
-		tsize =3D sizeof(*d->mbm_local);
-		d->mbm_local =3D kcalloc(idx_limit, tsize, GFP_KERNEL);
-		if (!d->mbm_local) {
-			bitmap_free(d->rmid_busy_llc);
-			kfree(d->mbm_total);
-			return -ENOMEM;
-		}
-	}
-
-	return 0;
-}
-
-int resctrl_online_ctrl_domain(struct rdt_resource *r, struct rdt_ctrl_domai=
n *d)
-{
-	int err =3D 0;
-
-	mutex_lock(&rdtgroup_mutex);
-
-	if (supports_mba_mbps() && r->rid =3D=3D RDT_RESOURCE_MBA) {
-		/* RDT_RESOURCE_MBA is never mon_capable */
-		err =3D mba_sc_domain_allocate(r, d);
-	}
-
-	mutex_unlock(&rdtgroup_mutex);
-
-	return err;
-}
-
-int resctrl_online_mon_domain(struct rdt_resource *r, struct rdt_mon_domain =
*d)
-{
-	int err;
-
-	mutex_lock(&rdtgroup_mutex);
-
-	err =3D domain_setup_mon_state(r, d);
-	if (err)
-		goto out_unlock;
-
-	if (resctrl_is_mbm_enabled()) {
-		INIT_DELAYED_WORK(&d->mbm_over, mbm_handle_overflow);
-		mbm_setup_overflow_handler(d, MBM_OVERFLOW_INTERVAL,
-					   RESCTRL_PICK_ANY_CPU);
-	}
-
-	if (resctrl_arch_is_llc_occupancy_enabled())
-		INIT_DELAYED_WORK(&d->cqm_limbo, cqm_handle_limbo);
-
-	/*
-	 * If the filesystem is not mounted then only the default resource group
-	 * exists. Creation of its directories is deferred until mount time
-	 * by rdt_get_tree() calling mkdir_mondata_all().
-	 * If resctrl is mounted, add per domain monitor data directories.
-	 */
-	if (resctrl_mounted && resctrl_arch_mon_capable())
-		mkdir_mondata_subdir_allrdtgrp(r, d);
-
-out_unlock:
-	mutex_unlock(&rdtgroup_mutex);
-
-	return err;
-}
-
-void resctrl_online_cpu(unsigned int cpu)
-{
-	mutex_lock(&rdtgroup_mutex);
-	/* The CPU is set in default rdtgroup after online. */
-	cpumask_set_cpu(cpu, &rdtgroup_default.cpu_mask);
-	mutex_unlock(&rdtgroup_mutex);
-}
-
-static void clear_childcpus(struct rdtgroup *r, unsigned int cpu)
-{
-	struct rdtgroup *cr;
-
-	list_for_each_entry(cr, &r->mon.crdtgrp_list, mon.crdtgrp_list) {
-		if (cpumask_test_and_clear_cpu(cpu, &cr->cpu_mask))
-			break;
-	}
-}
-
-static struct rdt_mon_domain *get_mon_domain_from_cpu(int cpu,
-						      struct rdt_resource *r)
-{
-	struct rdt_mon_domain *d;
-
-	lockdep_assert_cpus_held();
-
-	list_for_each_entry(d, &r->mon_domains, hdr.list) {
-		/* Find the domain that contains this CPU */
-		if (cpumask_test_cpu(cpu, &d->hdr.cpu_mask))
-			return d;
-	}
-
-	return NULL;
-}
-
-void resctrl_offline_cpu(unsigned int cpu)
-{
-	struct rdt_resource *l3 =3D resctrl_arch_get_resource(RDT_RESOURCE_L3);
-	struct rdt_mon_domain *d;
-	struct rdtgroup *rdtgrp;
-
-	mutex_lock(&rdtgroup_mutex);
-	list_for_each_entry(rdtgrp, &rdt_all_groups, rdtgroup_list) {
-		if (cpumask_test_and_clear_cpu(cpu, &rdtgrp->cpu_mask)) {
-			clear_childcpus(rdtgrp, cpu);
-			break;
-		}
-	}
-
-	if (!l3->mon_capable)
-		goto out_unlock;
-
-	d =3D get_mon_domain_from_cpu(cpu, l3);
-	if (d) {
-		if (resctrl_is_mbm_enabled() && cpu =3D=3D d->mbm_work_cpu) {
-			cancel_delayed_work(&d->mbm_over);
-			mbm_setup_overflow_handler(d, 0, cpu);
-		}
-		if (resctrl_arch_is_llc_occupancy_enabled() &&
-		    cpu =3D=3D d->cqm_work_cpu && has_busy_rmid(d)) {
-			cancel_delayed_work(&d->cqm_limbo);
-			cqm_setup_limbo_handler(d, 0, cpu);
-		}
-	}
-
-out_unlock:
-	mutex_unlock(&rdtgroup_mutex);
-}
-
-/*
- * resctrl_init - resctrl filesystem initialization
- *
- * Setup resctrl file system including set up root, create mount point,
- * register resctrl filesystem, and initialize files under root directory.
- *
- * Return: 0 on success or -errno
- */
-int resctrl_init(void)
-{
-	int ret =3D 0;
-
-	seq_buf_init(&last_cmd_status, last_cmd_status_buf,
-		     sizeof(last_cmd_status_buf));
-
-	rdtgroup_setup_default();
-
-	thread_throttle_mode_init();
-
-	ret =3D resctrl_mon_resource_init();
-	if (ret)
-		return ret;
-
-	ret =3D sysfs_create_mount_point(fs_kobj, "resctrl");
-	if (ret) {
-		resctrl_mon_resource_exit();
-		return ret;
-	}
-
-	ret =3D register_filesystem(&rdt_fs_type);
-	if (ret)
-		goto cleanup_mountpoint;
-
-	/*
-	 * Adding the resctrl debugfs directory here may not be ideal since
-	 * it would let the resctrl debugfs directory appear on the debugfs
-	 * filesystem before the resctrl filesystem is mounted.
-	 * It may also be ok since that would enable debugging of RDT before
-	 * resctrl is mounted.
-	 * The reason why the debugfs directory is created here and not in
-	 * rdt_get_tree() is because rdt_get_tree() takes rdtgroup_mutex and
-	 * during the debugfs directory creation also &sb->s_type->i_mutex_key
-	 * (the lockdep class of inode->i_rwsem). Other filesystem
-	 * interactions (eg. SyS_getdents) have the lock ordering:
-	 * &sb->s_type->i_mutex_key --> &mm->mmap_lock
-	 * During mmap(), called with &mm->mmap_lock, the rdtgroup_mutex
-	 * is taken, thus creating dependency:
-	 * &mm->mmap_lock --> rdtgroup_mutex for the latter that can cause
-	 * issues considering the other two lock dependencies.
-	 * By creating the debugfs directory here we avoid a dependency
-	 * that may cause deadlock (even though file operations cannot
-	 * occur until the filesystem is mounted, but I do not know how to
-	 * tell lockdep that).
-	 */
-	debugfs_resctrl =3D debugfs_create_dir("resctrl", NULL);
-
-	return 0;
-
-cleanup_mountpoint:
-	sysfs_remove_mount_point(fs_kobj, "resctrl");
-	resctrl_mon_resource_exit();
-
-	return ret;
-}
-
-static bool resctrl_online_domains_exist(void)
-{
-	struct rdt_resource *r;
-
-	/*
-	 * Only walk capable resources to allow resctrl_arch_get_resource()
-	 * to return dummy 'not capable' resources.
-	 */
-	for_each_alloc_capable_rdt_resource(r) {
-		if (!list_empty(&r->ctrl_domains))
-			return true;
-	}
-
-	for_each_mon_capable_rdt_resource(r) {
-		if (!list_empty(&r->mon_domains))
-			return true;
-	}
-
-	return false;
-}
-
-/**
- * resctrl_exit() - Remove the resctrl filesystem and free resources.
- *
- * Called by the architecture code in response to a fatal error.
- * Removes resctrl files and structures from kernfs to prevent further
- * configuration.
- *
- * When called by the architecture code, all CPUs and resctrl domains must be
- * offline. This ensures the limbo and overflow handlers are not scheduled to
- * run, meaning the data structures they access can be freed by
- * resctrl_mon_resource_exit().
- *
- * After resctrl_exit() returns, the architecture code should return an
- * error from all resctrl_arch_ functions that can do this.
- * resctrl_arch_get_resource() must continue to return struct rdt_resources
- * with the correct rid field to ensure the filesystem can be unmounted.
- */
-void resctrl_exit(void)
-{
-	cpus_read_lock();
-	WARN_ON_ONCE(resctrl_online_domains_exist());
-
-	mutex_lock(&rdtgroup_mutex);
-	resctrl_fs_teardown();
-	mutex_unlock(&rdtgroup_mutex);
-
-	cpus_read_unlock();
-
-	debugfs_remove_recursive(debugfs_resctrl);
-	debugfs_resctrl =3D NULL;
-	unregister_filesystem(&rdt_fs_type);
-
-	/*
-	 * Do not remove the sysfs mount point added by resctrl_init() so that
-	 * it can be used to umount resctrl.
-	 */
-
-	resctrl_mon_resource_exit();
+	return;
 }
diff --git a/fs/resctrl/Kconfig b/fs/resctrl/Kconfig
index 478a8e2..2167130 100644
--- a/fs/resctrl/Kconfig
+++ b/fs/resctrl/Kconfig
@@ -21,7 +21,7 @@ config RESCTRL_FS
 	  On architectures where this can be disabled independently, it is
 	  safe to say N.
=20
-	  See <file:Documentation/arch/x86/resctrl.rst> for more information.
+	  See <file:Documentation/filesystems/resctrl.rst> for more information.
=20
 config RESCTRL_FS_PSEUDO_LOCK
 	bool
diff --git a/fs/resctrl/ctrlmondata.c b/fs/resctrl/ctrlmondata.c
index e69de29..6ed2dfd 100644
--- a/fs/resctrl/ctrlmondata.c
+++ b/fs/resctrl/ctrlmondata.c
@@ -0,0 +1,661 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Resource Director Technology(RDT)
+ * - Cache Allocation code.
+ *
+ * Copyright (C) 2016 Intel Corporation
+ *
+ * Authors:
+ *    Fenghua Yu <fenghua.yu@intel.com>
+ *    Tony Luck <tony.luck@intel.com>
+ *
+ * More information about RDT be found in the Intel (R) x86 Architecture
+ * Software Developer Manual June 2016, volume 3, section 17.17.
+ */
+
+#define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
+
+#include <linux/cpu.h>
+#include <linux/kernfs.h>
+#include <linux/seq_file.h>
+#include <linux/slab.h>
+#include <linux/tick.h>
+
+#include "internal.h"
+
+struct rdt_parse_data {
+	struct rdtgroup		*rdtgrp;
+	char			*buf;
+};
+
+typedef int (ctrlval_parser_t)(struct rdt_parse_data *data,
+			       struct resctrl_schema *s,
+			       struct rdt_ctrl_domain *d);
+
+/*
+ * Check whether MBA bandwidth percentage value is correct. The value is
+ * checked against the minimum and max bandwidth values specified by the
+ * hardware. The allocated bandwidth percentage is rounded to the next
+ * control step available on the hardware.
+ */
+static bool bw_validate(char *buf, u32 *data, struct rdt_resource *r)
+{
+	int ret;
+	u32 bw;
+
+	/*
+	 * Only linear delay values is supported for current Intel SKUs.
+	 */
+	if (!r->membw.delay_linear && r->membw.arch_needs_linear) {
+		rdt_last_cmd_puts("No support for non-linear MB domains\n");
+		return false;
+	}
+
+	ret =3D kstrtou32(buf, 10, &bw);
+	if (ret) {
+		rdt_last_cmd_printf("Invalid MB value %s\n", buf);
+		return false;
+	}
+
+	/* Nothing else to do if software controller is enabled. */
+	if (is_mba_sc(r)) {
+		*data =3D bw;
+		return true;
+	}
+
+	if (bw < r->membw.min_bw || bw > r->membw.max_bw) {
+		rdt_last_cmd_printf("MB value %u out of range [%d,%d]\n",
+				    bw, r->membw.min_bw, r->membw.max_bw);
+		return false;
+	}
+
+	*data =3D roundup(bw, (unsigned long)r->membw.bw_gran);
+	return true;
+}
+
+static int parse_bw(struct rdt_parse_data *data, struct resctrl_schema *s,
+		    struct rdt_ctrl_domain *d)
+{
+	struct resctrl_staged_config *cfg;
+	u32 closid =3D data->rdtgrp->closid;
+	struct rdt_resource *r =3D s->res;
+	u32 bw_val;
+
+	cfg =3D &d->staged_config[s->conf_type];
+	if (cfg->have_new_ctrl) {
+		rdt_last_cmd_printf("Duplicate domain %d\n", d->hdr.id);
+		return -EINVAL;
+	}
+
+	if (!bw_validate(data->buf, &bw_val, r))
+		return -EINVAL;
+
+	if (is_mba_sc(r)) {
+		d->mbps_val[closid] =3D bw_val;
+		return 0;
+	}
+
+	cfg->new_ctrl =3D bw_val;
+	cfg->have_new_ctrl =3D true;
+
+	return 0;
+}
+
+/*
+ * Check whether a cache bit mask is valid.
+ * On Intel CPUs, non-contiguous 1s value support is indicated by CPUID:
+ *   - CPUID.0x10.1:ECX[3]: L3 non-contiguous 1s value supported if 1
+ *   - CPUID.0x10.2:ECX[3]: L2 non-contiguous 1s value supported if 1
+ *
+ * Haswell does not support a non-contiguous 1s value and additionally
+ * requires at least two bits set.
+ * AMD allows non-contiguous bitmasks.
+ */
+static bool cbm_validate(char *buf, u32 *data, struct rdt_resource *r)
+{
+	u32 supported_bits =3D BIT_MASK(r->cache.cbm_len) - 1;
+	unsigned int cbm_len =3D r->cache.cbm_len;
+	unsigned long first_bit, zero_bit, val;
+	int ret;
+
+	ret =3D kstrtoul(buf, 16, &val);
+	if (ret) {
+		rdt_last_cmd_printf("Non-hex character in the mask %s\n", buf);
+		return false;
+	}
+
+	if ((r->cache.min_cbm_bits > 0 && val =3D=3D 0) || val > supported_bits) {
+		rdt_last_cmd_puts("Mask out of range\n");
+		return false;
+	}
+
+	first_bit =3D find_first_bit(&val, cbm_len);
+	zero_bit =3D find_next_zero_bit(&val, cbm_len, first_bit);
+
+	/* Are non-contiguous bitmasks allowed? */
+	if (!r->cache.arch_has_sparse_bitmasks &&
+	    (find_next_bit(&val, cbm_len, zero_bit) < cbm_len)) {
+		rdt_last_cmd_printf("The mask %lx has non-consecutive 1-bits\n", val);
+		return false;
+	}
+
+	if ((zero_bit - first_bit) < r->cache.min_cbm_bits) {
+		rdt_last_cmd_printf("Need at least %d bits in the mask\n",
+				    r->cache.min_cbm_bits);
+		return false;
+	}
+
+	*data =3D val;
+	return true;
+}
+
+/*
+ * Read one cache bit mask (hex). Check that it is valid for the current
+ * resource type.
+ */
+static int parse_cbm(struct rdt_parse_data *data, struct resctrl_schema *s,
+		     struct rdt_ctrl_domain *d)
+{
+	struct rdtgroup *rdtgrp =3D data->rdtgrp;
+	struct resctrl_staged_config *cfg;
+	struct rdt_resource *r =3D s->res;
+	u32 cbm_val;
+
+	cfg =3D &d->staged_config[s->conf_type];
+	if (cfg->have_new_ctrl) {
+		rdt_last_cmd_printf("Duplicate domain %d\n", d->hdr.id);
+		return -EINVAL;
+	}
+
+	/*
+	 * Cannot set up more than one pseudo-locked region in a cache
+	 * hierarchy.
+	 */
+	if (rdtgrp->mode =3D=3D RDT_MODE_PSEUDO_LOCKSETUP &&
+	    rdtgroup_pseudo_locked_in_hierarchy(d)) {
+		rdt_last_cmd_puts("Pseudo-locked region in hierarchy\n");
+		return -EINVAL;
+	}
+
+	if (!cbm_validate(data->buf, &cbm_val, r))
+		return -EINVAL;
+
+	if ((rdtgrp->mode =3D=3D RDT_MODE_EXCLUSIVE ||
+	     rdtgrp->mode =3D=3D RDT_MODE_SHAREABLE) &&
+	    rdtgroup_cbm_overlaps_pseudo_locked(d, cbm_val)) {
+		rdt_last_cmd_puts("CBM overlaps with pseudo-locked region\n");
+		return -EINVAL;
+	}
+
+	/*
+	 * The CBM may not overlap with the CBM of another closid if
+	 * either is exclusive.
+	 */
+	if (rdtgroup_cbm_overlaps(s, d, cbm_val, rdtgrp->closid, true)) {
+		rdt_last_cmd_puts("Overlaps with exclusive group\n");
+		return -EINVAL;
+	}
+
+	if (rdtgroup_cbm_overlaps(s, d, cbm_val, rdtgrp->closid, false)) {
+		if (rdtgrp->mode =3D=3D RDT_MODE_EXCLUSIVE ||
+		    rdtgrp->mode =3D=3D RDT_MODE_PSEUDO_LOCKSETUP) {
+			rdt_last_cmd_puts("Overlaps with other group\n");
+			return -EINVAL;
+		}
+	}
+
+	cfg->new_ctrl =3D cbm_val;
+	cfg->have_new_ctrl =3D true;
+
+	return 0;
+}
+
+/*
+ * For each domain in this resource we expect to find a series of:
+ *	id=3Dmask
+ * separated by ";". The "id" is in decimal, and must match one of
+ * the "id"s for this resource.
+ */
+static int parse_line(char *line, struct resctrl_schema *s,
+		      struct rdtgroup *rdtgrp)
+{
+	enum resctrl_conf_type t =3D s->conf_type;
+	ctrlval_parser_t *parse_ctrlval =3D NULL;
+	struct resctrl_staged_config *cfg;
+	struct rdt_resource *r =3D s->res;
+	struct rdt_parse_data data;
+	struct rdt_ctrl_domain *d;
+	char *dom =3D NULL, *id;
+	unsigned long dom_id;
+
+	/* Walking r->domains, ensure it can't race with cpuhp */
+	lockdep_assert_cpus_held();
+
+	switch (r->schema_fmt) {
+	case RESCTRL_SCHEMA_BITMAP:
+		parse_ctrlval =3D &parse_cbm;
+		break;
+	case RESCTRL_SCHEMA_RANGE:
+		parse_ctrlval =3D &parse_bw;
+		break;
+	}
+
+	if (WARN_ON_ONCE(!parse_ctrlval))
+		return -EINVAL;
+
+	if (rdtgrp->mode =3D=3D RDT_MODE_PSEUDO_LOCKSETUP &&
+	    (r->rid =3D=3D RDT_RESOURCE_MBA || r->rid =3D=3D RDT_RESOURCE_SMBA)) {
+		rdt_last_cmd_puts("Cannot pseudo-lock MBA resource\n");
+		return -EINVAL;
+	}
+
+next:
+	if (!line || line[0] =3D=3D '\0')
+		return 0;
+	dom =3D strsep(&line, ";");
+	id =3D strsep(&dom, "=3D");
+	if (!dom || kstrtoul(id, 10, &dom_id)) {
+		rdt_last_cmd_puts("Missing '=3D' or non-numeric domain\n");
+		return -EINVAL;
+	}
+	dom =3D strim(dom);
+	list_for_each_entry(d, &r->ctrl_domains, hdr.list) {
+		if (d->hdr.id =3D=3D dom_id) {
+			data.buf =3D dom;
+			data.rdtgrp =3D rdtgrp;
+			if (parse_ctrlval(&data, s, d))
+				return -EINVAL;
+			if (rdtgrp->mode =3D=3D  RDT_MODE_PSEUDO_LOCKSETUP) {
+				cfg =3D &d->staged_config[t];
+				/*
+				 * In pseudo-locking setup mode and just
+				 * parsed a valid CBM that should be
+				 * pseudo-locked. Only one locked region per
+				 * resource group and domain so just do
+				 * the required initialization for single
+				 * region and return.
+				 */
+				rdtgrp->plr->s =3D s;
+				rdtgrp->plr->d =3D d;
+				rdtgrp->plr->cbm =3D cfg->new_ctrl;
+				d->plr =3D rdtgrp->plr;
+				return 0;
+			}
+			goto next;
+		}
+	}
+	return -EINVAL;
+}
+
+static int rdtgroup_parse_resource(char *resname, char *tok,
+				   struct rdtgroup *rdtgrp)
+{
+	struct resctrl_schema *s;
+
+	list_for_each_entry(s, &resctrl_schema_all, list) {
+		if (!strcmp(resname, s->name) && rdtgrp->closid < s->num_closid)
+			return parse_line(tok, s, rdtgrp);
+	}
+	rdt_last_cmd_printf("Unknown or unsupported resource name '%s'\n", resname);
+	return -EINVAL;
+}
+
+ssize_t rdtgroup_schemata_write(struct kernfs_open_file *of,
+				char *buf, size_t nbytes, loff_t off)
+{
+	struct resctrl_schema *s;
+	struct rdtgroup *rdtgrp;
+	struct rdt_resource *r;
+	char *tok, *resname;
+	int ret =3D 0;
+
+	/* Valid input requires a trailing newline */
+	if (nbytes =3D=3D 0 || buf[nbytes - 1] !=3D '\n')
+		return -EINVAL;
+	buf[nbytes - 1] =3D '\0';
+
+	rdtgrp =3D rdtgroup_kn_lock_live(of->kn);
+	if (!rdtgrp) {
+		rdtgroup_kn_unlock(of->kn);
+		return -ENOENT;
+	}
+	rdt_last_cmd_clear();
+
+	/*
+	 * No changes to pseudo-locked region allowed. It has to be removed
+	 * and re-created instead.
+	 */
+	if (rdtgrp->mode =3D=3D RDT_MODE_PSEUDO_LOCKED) {
+		ret =3D -EINVAL;
+		rdt_last_cmd_puts("Resource group is pseudo-locked\n");
+		goto out;
+	}
+
+	rdt_staged_configs_clear();
+
+	while ((tok =3D strsep(&buf, "\n")) !=3D NULL) {
+		resname =3D strim(strsep(&tok, ":"));
+		if (!tok) {
+			rdt_last_cmd_puts("Missing ':'\n");
+			ret =3D -EINVAL;
+			goto out;
+		}
+		if (tok[0] =3D=3D '\0') {
+			rdt_last_cmd_printf("Missing '%s' value\n", resname);
+			ret =3D -EINVAL;
+			goto out;
+		}
+		ret =3D rdtgroup_parse_resource(resname, tok, rdtgrp);
+		if (ret)
+			goto out;
+	}
+
+	list_for_each_entry(s, &resctrl_schema_all, list) {
+		r =3D s->res;
+
+		/*
+		 * Writes to mba_sc resources update the software controller,
+		 * not the control MSR.
+		 */
+		if (is_mba_sc(r))
+			continue;
+
+		ret =3D resctrl_arch_update_domains(r, rdtgrp->closid);
+		if (ret)
+			goto out;
+	}
+
+	if (rdtgrp->mode =3D=3D RDT_MODE_PSEUDO_LOCKSETUP) {
+		/*
+		 * If pseudo-locking fails we keep the resource group in
+		 * mode RDT_MODE_PSEUDO_LOCKSETUP with its class of service
+		 * active and updated for just the domain the pseudo-locked
+		 * region was requested for.
+		 */
+		ret =3D rdtgroup_pseudo_lock_create(rdtgrp);
+	}
+
+out:
+	rdt_staged_configs_clear();
+	rdtgroup_kn_unlock(of->kn);
+	return ret ?: nbytes;
+}
+
+static void show_doms(struct seq_file *s, struct resctrl_schema *schema, int=
 closid)
+{
+	struct rdt_resource *r =3D schema->res;
+	struct rdt_ctrl_domain *dom;
+	bool sep =3D false;
+	u32 ctrl_val;
+
+	/* Walking r->domains, ensure it can't race with cpuhp */
+	lockdep_assert_cpus_held();
+
+	seq_printf(s, "%*s:", max_name_width, schema->name);
+	list_for_each_entry(dom, &r->ctrl_domains, hdr.list) {
+		if (sep)
+			seq_puts(s, ";");
+
+		if (is_mba_sc(r))
+			ctrl_val =3D dom->mbps_val[closid];
+		else
+			ctrl_val =3D resctrl_arch_get_config(r, dom, closid,
+							   schema->conf_type);
+
+		seq_printf(s, schema->fmt_str, dom->hdr.id, ctrl_val);
+		sep =3D true;
+	}
+	seq_puts(s, "\n");
+}
+
+int rdtgroup_schemata_show(struct kernfs_open_file *of,
+			   struct seq_file *s, void *v)
+{
+	struct resctrl_schema *schema;
+	struct rdtgroup *rdtgrp;
+	int ret =3D 0;
+	u32 closid;
+
+	rdtgrp =3D rdtgroup_kn_lock_live(of->kn);
+	if (rdtgrp) {
+		if (rdtgrp->mode =3D=3D RDT_MODE_PSEUDO_LOCKSETUP) {
+			list_for_each_entry(schema, &resctrl_schema_all, list) {
+				seq_printf(s, "%s:uninitialized\n", schema->name);
+			}
+		} else if (rdtgrp->mode =3D=3D RDT_MODE_PSEUDO_LOCKED) {
+			if (!rdtgrp->plr->d) {
+				rdt_last_cmd_clear();
+				rdt_last_cmd_puts("Cache domain offline\n");
+				ret =3D -ENODEV;
+			} else {
+				seq_printf(s, "%s:%d=3D%x\n",
+					   rdtgrp->plr->s->res->name,
+					   rdtgrp->plr->d->hdr.id,
+					   rdtgrp->plr->cbm);
+			}
+		} else {
+			closid =3D rdtgrp->closid;
+			list_for_each_entry(schema, &resctrl_schema_all, list) {
+				if (closid < schema->num_closid)
+					show_doms(s, schema, closid);
+			}
+		}
+	} else {
+		ret =3D -ENOENT;
+	}
+	rdtgroup_kn_unlock(of->kn);
+	return ret;
+}
+
+static int smp_mon_event_count(void *arg)
+{
+	mon_event_count(arg);
+
+	return 0;
+}
+
+ssize_t rdtgroup_mba_mbps_event_write(struct kernfs_open_file *of,
+				      char *buf, size_t nbytes, loff_t off)
+{
+	struct rdtgroup *rdtgrp;
+	int ret =3D 0;
+
+	/* Valid input requires a trailing newline */
+	if (nbytes =3D=3D 0 || buf[nbytes - 1] !=3D '\n')
+		return -EINVAL;
+	buf[nbytes - 1] =3D '\0';
+
+	rdtgrp =3D rdtgroup_kn_lock_live(of->kn);
+	if (!rdtgrp) {
+		rdtgroup_kn_unlock(of->kn);
+		return -ENOENT;
+	}
+	rdt_last_cmd_clear();
+
+	if (!strcmp(buf, "mbm_local_bytes")) {
+		if (resctrl_arch_is_mbm_local_enabled())
+			rdtgrp->mba_mbps_event =3D QOS_L3_MBM_LOCAL_EVENT_ID;
+		else
+			ret =3D -EINVAL;
+	} else if (!strcmp(buf, "mbm_total_bytes")) {
+		if (resctrl_arch_is_mbm_total_enabled())
+			rdtgrp->mba_mbps_event =3D QOS_L3_MBM_TOTAL_EVENT_ID;
+		else
+			ret =3D -EINVAL;
+	} else {
+		ret =3D -EINVAL;
+	}
+
+	if (ret)
+		rdt_last_cmd_printf("Unsupported event id '%s'\n", buf);
+
+	rdtgroup_kn_unlock(of->kn);
+
+	return ret ?: nbytes;
+}
+
+int rdtgroup_mba_mbps_event_show(struct kernfs_open_file *of,
+				 struct seq_file *s, void *v)
+{
+	struct rdtgroup *rdtgrp;
+	int ret =3D 0;
+
+	rdtgrp =3D rdtgroup_kn_lock_live(of->kn);
+
+	if (rdtgrp) {
+		switch (rdtgrp->mba_mbps_event) {
+		case QOS_L3_MBM_LOCAL_EVENT_ID:
+			seq_puts(s, "mbm_local_bytes\n");
+			break;
+		case QOS_L3_MBM_TOTAL_EVENT_ID:
+			seq_puts(s, "mbm_total_bytes\n");
+			break;
+		default:
+			pr_warn_once("Bad event %d\n", rdtgrp->mba_mbps_event);
+			ret =3D -EINVAL;
+			break;
+		}
+	} else {
+		ret =3D -ENOENT;
+	}
+
+	rdtgroup_kn_unlock(of->kn);
+
+	return ret;
+}
+
+struct rdt_domain_hdr *resctrl_find_domain(struct list_head *h, int id,
+					   struct list_head **pos)
+{
+	struct rdt_domain_hdr *d;
+	struct list_head *l;
+
+	list_for_each(l, h) {
+		d =3D list_entry(l, struct rdt_domain_hdr, list);
+		/* When id is found, return its domain. */
+		if (id =3D=3D d->id)
+			return d;
+		/* Stop searching when finding id's position in sorted list. */
+		if (id < d->id)
+			break;
+	}
+
+	if (pos)
+		*pos =3D l;
+
+	return NULL;
+}
+
+void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
+		    struct rdt_mon_domain *d, struct rdtgroup *rdtgrp,
+		    cpumask_t *cpumask, int evtid, int first)
+{
+	int cpu;
+
+	/* When picking a CPU from cpu_mask, ensure it can't race with cpuhp */
+	lockdep_assert_cpus_held();
+
+	/*
+	 * Setup the parameters to pass to mon_event_count() to read the data.
+	 */
+	rr->rgrp =3D rdtgrp;
+	rr->evtid =3D evtid;
+	rr->r =3D r;
+	rr->d =3D d;
+	rr->first =3D first;
+	rr->arch_mon_ctx =3D resctrl_arch_mon_ctx_alloc(r, evtid);
+	if (IS_ERR(rr->arch_mon_ctx)) {
+		rr->err =3D -EINVAL;
+		return;
+	}
+
+	cpu =3D cpumask_any_housekeeping(cpumask, RESCTRL_PICK_ANY_CPU);
+
+	/*
+	 * cpumask_any_housekeeping() prefers housekeeping CPUs, but
+	 * are all the CPUs nohz_full? If yes, pick a CPU to IPI.
+	 * MPAM's resctrl_arch_rmid_read() is unable to read the
+	 * counters on some platforms if its called in IRQ context.
+	 */
+	if (tick_nohz_full_cpu(cpu))
+		smp_call_function_any(cpumask, mon_event_count, rr, 1);
+	else
+		smp_call_on_cpu(cpu, smp_mon_event_count, rr, false);
+
+	resctrl_arch_mon_ctx_free(r, evtid, rr->arch_mon_ctx);
+}
+
+int rdtgroup_mondata_show(struct seq_file *m, void *arg)
+{
+	struct kernfs_open_file *of =3D m->private;
+	enum resctrl_res_level resid;
+	enum resctrl_event_id evtid;
+	struct rdt_domain_hdr *hdr;
+	struct rmid_read rr =3D {0};
+	struct rdt_mon_domain *d;
+	struct rdtgroup *rdtgrp;
+	struct rdt_resource *r;
+	struct mon_data *md;
+	int domid, ret =3D 0;
+
+	rdtgrp =3D rdtgroup_kn_lock_live(of->kn);
+	if (!rdtgrp) {
+		ret =3D -ENOENT;
+		goto out;
+	}
+
+	md =3D of->kn->priv;
+	if (WARN_ON_ONCE(!md)) {
+		ret =3D -EIO;
+		goto out;
+	}
+
+	resid =3D md->rid;
+	domid =3D md->domid;
+	evtid =3D md->evtid;
+	r =3D resctrl_arch_get_resource(resid);
+
+	if (md->sum) {
+		/*
+		 * This file requires summing across all domains that share
+		 * the L3 cache id that was provided in the "domid" field of the
+		 * struct mon_data. Search all domains in the resource for
+		 * one that matches this cache id.
+		 */
+		list_for_each_entry(d, &r->mon_domains, hdr.list) {
+			if (d->ci->id =3D=3D domid) {
+				rr.ci =3D d->ci;
+				mon_event_read(&rr, r, NULL, rdtgrp,
+					       &d->ci->shared_cpu_map, evtid, false);
+				goto checkresult;
+			}
+		}
+		ret =3D -ENOENT;
+		goto out;
+	} else {
+		/*
+		 * This file provides data from a single domain. Search
+		 * the resource to find the domain with "domid".
+		 */
+		hdr =3D resctrl_find_domain(&r->mon_domains, domid, NULL);
+		if (!hdr || WARN_ON_ONCE(hdr->type !=3D RESCTRL_MON_DOMAIN)) {
+			ret =3D -ENOENT;
+			goto out;
+		}
+		d =3D container_of(hdr, struct rdt_mon_domain, hdr);
+		mon_event_read(&rr, r, d, rdtgrp, &d->hdr.cpu_mask, evtid, false);
+	}
+
+checkresult:
+
+	if (rr.err =3D=3D -EIO)
+		seq_puts(m, "Error\n");
+	else if (rr.err =3D=3D -EINVAL)
+		seq_puts(m, "Unavailable\n");
+	else
+		seq_printf(m, "%llu\n", rr.val);
+
+out:
+	rdtgroup_kn_unlock(of->kn);
+	return ret;
+}
diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
index e69de29..9a8cf6f 100644
--- a/fs/resctrl/internal.h
+++ b/fs/resctrl/internal.h
@@ -0,0 +1,426 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _FS_RESCTRL_INTERNAL_H
+#define _FS_RESCTRL_INTERNAL_H
+
+#include <linux/resctrl.h>
+#include <linux/kernfs.h>
+#include <linux/fs_context.h>
+#include <linux/tick.h>
+
+#define CQM_LIMBOCHECK_INTERVAL	1000
+
+/**
+ * cpumask_any_housekeeping() - Choose any CPU in @mask, preferring those th=
at
+ *			        aren't marked nohz_full
+ * @mask:	The mask to pick a CPU from.
+ * @exclude_cpu:The CPU to avoid picking.
+ *
+ * Returns a CPU from @mask, but not @exclude_cpu. If there are housekeeping
+ * CPUs that don't use nohz_full, these are preferred. Pass
+ * RESCTRL_PICK_ANY_CPU to avoid excluding any CPUs.
+ *
+ * When a CPU is excluded, returns >=3D nr_cpu_ids if no CPUs are available.
+ */
+static inline unsigned int
+cpumask_any_housekeeping(const struct cpumask *mask, int exclude_cpu)
+{
+	unsigned int cpu;
+
+	/* Try to find a CPU that isn't nohz_full to use in preference */
+	if (tick_nohz_full_enabled()) {
+		cpu =3D cpumask_any_andnot_but(mask, tick_nohz_full_mask, exclude_cpu);
+		if (cpu < nr_cpu_ids)
+			return cpu;
+	}
+
+	return cpumask_any_but(mask, exclude_cpu);
+}
+
+struct rdt_fs_context {
+	struct kernfs_fs_context	kfc;
+	bool				enable_cdpl2;
+	bool				enable_cdpl3;
+	bool				enable_mba_mbps;
+	bool				enable_debug;
+};
+
+static inline struct rdt_fs_context *rdt_fc2context(struct fs_context *fc)
+{
+	struct kernfs_fs_context *kfc =3D fc->fs_private;
+
+	return container_of(kfc, struct rdt_fs_context, kfc);
+}
+
+/**
+ * struct mon_evt - Entry in the event list of a resource
+ * @evtid:		event id
+ * @name:		name of the event
+ * @configurable:	true if the event is configurable
+ * @list:		entry in &rdt_resource->evt_list
+ */
+struct mon_evt {
+	enum resctrl_event_id	evtid;
+	char			*name;
+	bool			configurable;
+	struct list_head	list;
+};
+
+/**
+ * struct mon_data - Monitoring details for each event file.
+ * @list:            Member of the global @mon_data_kn_priv_list list.
+ * @rid:             Resource id associated with the event file.
+ * @evtid:           Event id associated with the event file.
+ * @sum:             Set when event must be summed across multiple
+ *                   domains.
+ * @domid:           When @sum is zero this is the domain to which
+ *                   the event file belongs. When @sum is one this
+ *                   is the id of the L3 cache that all domains to be
+ *                   summed share.
+ *
+ * Pointed to by the kernfs kn->priv field of monitoring event files.
+ * Readers and writers must hold rdtgroup_mutex.
+ */
+struct mon_data {
+	struct list_head	list;
+	enum resctrl_res_level	rid;
+	enum resctrl_event_id	evtid;
+	int			domid;
+	bool			sum;
+};
+
+/**
+ * struct rmid_read - Data passed across smp_call*() to read event count.
+ * @rgrp:  Resource group for which the counter is being read. If it is a pa=
rent
+ *	   resource group then its event count is summed with the count from all
+ *	   its child resource groups.
+ * @r:	   Resource describing the properties of the event being read.
+ * @d:	   Domain that the counter should be read from. If NULL then sum all
+ *	   domains in @r sharing L3 @ci.id
+ * @evtid: Which monitor event to read.
+ * @first: Initialize MBM counter when true.
+ * @ci:    Cacheinfo for L3. Only set when @d is NULL. Used when summing dom=
ains.
+ * @err:   Error encountered when reading counter.
+ * @val:   Returned value of event counter. If @rgrp is a parent resource gr=
oup,
+ *	   @val includes the sum of event counts from its child resource groups.
+ *	   If @d is NULL, @val includes the sum of all domains in @r sharing @ci.=
id,
+ *	   (summed across child resource groups if @rgrp is a parent resource gro=
up).
+ * @arch_mon_ctx: Hardware monitor allocated for this read request (MPAM onl=
y).
+ */
+struct rmid_read {
+	struct rdtgroup		*rgrp;
+	struct rdt_resource	*r;
+	struct rdt_mon_domain	*d;
+	enum resctrl_event_id	evtid;
+	bool			first;
+	struct cacheinfo	*ci;
+	int			err;
+	u64			val;
+	void			*arch_mon_ctx;
+};
+
+extern struct list_head resctrl_schema_all;
+
+extern bool resctrl_mounted;
+
+enum rdt_group_type {
+	RDTCTRL_GROUP =3D 0,
+	RDTMON_GROUP,
+	RDT_NUM_GROUP,
+};
+
+/**
+ * enum rdtgrp_mode - Mode of a RDT resource group
+ * @RDT_MODE_SHAREABLE: This resource group allows sharing of its allocations
+ * @RDT_MODE_EXCLUSIVE: No sharing of this resource group's allocations allo=
wed
+ * @RDT_MODE_PSEUDO_LOCKSETUP: Resource group will be used for Pseudo-Locking
+ * @RDT_MODE_PSEUDO_LOCKED: No sharing of this resource group's allocations
+ *                          allowed AND the allocations are Cache Pseudo-Loc=
ked
+ * @RDT_NUM_MODES: Total number of modes
+ *
+ * The mode of a resource group enables control over the allowed overlap
+ * between allocations associated with different resource groups (classes
+ * of service). User is able to modify the mode of a resource group by
+ * writing to the "mode" resctrl file associated with the resource group.
+ *
+ * The "shareable", "exclusive", and "pseudo-locksetup" modes are set by
+ * writing the appropriate text to the "mode" file. A resource group enters
+ * "pseudo-locked" mode after the schemata is written while the resource
+ * group is in "pseudo-locksetup" mode.
+ */
+enum rdtgrp_mode {
+	RDT_MODE_SHAREABLE =3D 0,
+	RDT_MODE_EXCLUSIVE,
+	RDT_MODE_PSEUDO_LOCKSETUP,
+	RDT_MODE_PSEUDO_LOCKED,
+
+	/* Must be last */
+	RDT_NUM_MODES,
+};
+
+/**
+ * struct mongroup - store mon group's data in resctrl fs.
+ * @mon_data_kn:		kernfs node for the mon_data directory
+ * @parent:			parent rdtgrp
+ * @crdtgrp_list:		child rdtgroup node list
+ * @rmid:			rmid for this rdtgroup
+ */
+struct mongroup {
+	struct kernfs_node	*mon_data_kn;
+	struct rdtgroup		*parent;
+	struct list_head	crdtgrp_list;
+	u32			rmid;
+};
+
+/**
+ * struct rdtgroup - store rdtgroup's data in resctrl file system.
+ * @kn:				kernfs node
+ * @rdtgroup_list:		linked list for all rdtgroups
+ * @closid:			closid for this rdtgroup
+ * @cpu_mask:			CPUs assigned to this rdtgroup
+ * @flags:			status bits
+ * @waitcount:			how many cpus expect to find this
+ *				group when they acquire rdtgroup_mutex
+ * @type:			indicates type of this rdtgroup - either
+ *				monitor only or ctrl_mon group
+ * @mon:			mongroup related data
+ * @mode:			mode of resource group
+ * @mba_mbps_event:		input monitoring event id when mba_sc is enabled
+ * @plr:			pseudo-locked region
+ */
+struct rdtgroup {
+	struct kernfs_node		*kn;
+	struct list_head		rdtgroup_list;
+	u32				closid;
+	struct cpumask			cpu_mask;
+	int				flags;
+	atomic_t			waitcount;
+	enum rdt_group_type		type;
+	struct mongroup			mon;
+	enum rdtgrp_mode		mode;
+	enum resctrl_event_id		mba_mbps_event;
+	struct pseudo_lock_region	*plr;
+};
+
+/* rdtgroup.flags */
+#define	RDT_DELETED		1
+
+/* rftype.flags */
+#define RFTYPE_FLAGS_CPUS_LIST	1
+
+/*
+ * Define the file type flags for base and info directories.
+ */
+#define RFTYPE_INFO			BIT(0)
+
+#define RFTYPE_BASE			BIT(1)
+
+#define RFTYPE_CTRL			BIT(4)
+
+#define RFTYPE_MON			BIT(5)
+
+#define RFTYPE_TOP			BIT(6)
+
+#define RFTYPE_RES_CACHE		BIT(8)
+
+#define RFTYPE_RES_MB			BIT(9)
+
+#define RFTYPE_DEBUG			BIT(10)
+
+#define RFTYPE_CTRL_INFO		(RFTYPE_INFO | RFTYPE_CTRL)
+
+#define RFTYPE_MON_INFO			(RFTYPE_INFO | RFTYPE_MON)
+
+#define RFTYPE_TOP_INFO			(RFTYPE_INFO | RFTYPE_TOP)
+
+#define RFTYPE_CTRL_BASE		(RFTYPE_BASE | RFTYPE_CTRL)
+
+#define RFTYPE_MON_BASE			(RFTYPE_BASE | RFTYPE_MON)
+
+/* List of all resource groups */
+extern struct list_head rdt_all_groups;
+
+extern int max_name_width;
+
+/**
+ * struct rftype - describe each file in the resctrl file system
+ * @name:	File name
+ * @mode:	Access mode
+ * @kf_ops:	File operations
+ * @flags:	File specific RFTYPE_FLAGS_* flags
+ * @fflags:	File specific RFTYPE_* flags
+ * @seq_show:	Show content of the file
+ * @write:	Write to the file
+ */
+struct rftype {
+	char			*name;
+	umode_t			mode;
+	const struct kernfs_ops	*kf_ops;
+	unsigned long		flags;
+	unsigned long		fflags;
+
+	int (*seq_show)(struct kernfs_open_file *of,
+			struct seq_file *sf, void *v);
+	/*
+	 * write() is the generic write callback which maps directly to
+	 * kernfs write operation and overrides all other operations.
+	 * Maximum write size is determined by ->max_write_len.
+	 */
+	ssize_t (*write)(struct kernfs_open_file *of,
+			 char *buf, size_t nbytes, loff_t off);
+};
+
+/**
+ * struct mbm_state - status for each MBM counter in each domain
+ * @prev_bw_bytes: Previous bytes value read for bandwidth calculation
+ * @prev_bw:	The most recent bandwidth in MBps
+ */
+struct mbm_state {
+	u64	prev_bw_bytes;
+	u32	prev_bw;
+};
+
+extern struct mutex rdtgroup_mutex;
+
+static inline const char *rdt_kn_name(const struct kernfs_node *kn)
+{
+	return rcu_dereference_check(kn->name, lockdep_is_held(&rdtgroup_mutex));
+}
+
+extern struct rdtgroup rdtgroup_default;
+
+extern struct dentry *debugfs_resctrl;
+
+extern enum resctrl_event_id mba_mbps_default_event;
+
+void rdt_last_cmd_clear(void);
+
+void rdt_last_cmd_puts(const char *s);
+
+__printf(1, 2)
+void rdt_last_cmd_printf(const char *fmt, ...);
+
+struct rdtgroup *rdtgroup_kn_lock_live(struct kernfs_node *kn);
+
+void rdtgroup_kn_unlock(struct kernfs_node *kn);
+
+int rdtgroup_kn_mode_restrict(struct rdtgroup *r, const char *name);
+
+int rdtgroup_kn_mode_restore(struct rdtgroup *r, const char *name,
+			     umode_t mask);
+
+ssize_t rdtgroup_schemata_write(struct kernfs_open_file *of,
+				char *buf, size_t nbytes, loff_t off);
+
+int rdtgroup_schemata_show(struct kernfs_open_file *of,
+			   struct seq_file *s, void *v);
+
+ssize_t rdtgroup_mba_mbps_event_write(struct kernfs_open_file *of,
+				      char *buf, size_t nbytes, loff_t off);
+
+int rdtgroup_mba_mbps_event_show(struct kernfs_open_file *of,
+				 struct seq_file *s, void *v);
+
+bool rdtgroup_cbm_overlaps(struct resctrl_schema *s, struct rdt_ctrl_domain =
*d,
+			   unsigned long cbm, int closid, bool exclusive);
+
+unsigned int rdtgroup_cbm_to_size(struct rdt_resource *r, struct rdt_ctrl_do=
main *d,
+				  unsigned long cbm);
+
+enum rdtgrp_mode rdtgroup_mode_by_closid(int closid);
+
+int rdtgroup_tasks_assigned(struct rdtgroup *r);
+
+int closids_supported(void);
+
+void closid_free(int closid);
+
+int alloc_rmid(u32 closid);
+
+void free_rmid(u32 closid, u32 rmid);
+
+void resctrl_mon_resource_exit(void);
+
+void mon_event_count(void *info);
+
+int rdtgroup_mondata_show(struct seq_file *m, void *arg);
+
+void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
+		    struct rdt_mon_domain *d, struct rdtgroup *rdtgrp,
+		    cpumask_t *cpumask, int evtid, int first);
+
+int resctrl_mon_resource_init(void);
+
+void mbm_setup_overflow_handler(struct rdt_mon_domain *dom,
+				unsigned long delay_ms,
+				int exclude_cpu);
+
+void mbm_handle_overflow(struct work_struct *work);
+
+bool is_mba_sc(struct rdt_resource *r);
+
+void cqm_setup_limbo_handler(struct rdt_mon_domain *dom, unsigned long delay=
_ms,
+			     int exclude_cpu);
+
+void cqm_handle_limbo(struct work_struct *work);
+
+bool has_busy_rmid(struct rdt_mon_domain *d);
+
+void __check_limbo(struct rdt_mon_domain *d, bool force_free);
+
+void resctrl_file_fflags_init(const char *config, unsigned long fflags);
+
+void rdt_staged_configs_clear(void);
+
+bool closid_allocated(unsigned int closid);
+
+int resctrl_find_cleanest_closid(void);
+
+#ifdef CONFIG_RESCTRL_FS_PSEUDO_LOCK
+int rdtgroup_locksetup_enter(struct rdtgroup *rdtgrp);
+
+int rdtgroup_locksetup_exit(struct rdtgroup *rdtgrp);
+
+bool rdtgroup_cbm_overlaps_pseudo_locked(struct rdt_ctrl_domain *d, unsigned=
 long cbm);
+
+bool rdtgroup_pseudo_locked_in_hierarchy(struct rdt_ctrl_domain *d);
+
+int rdt_pseudo_lock_init(void);
+
+void rdt_pseudo_lock_release(void);
+
+int rdtgroup_pseudo_lock_create(struct rdtgroup *rdtgrp);
+
+void rdtgroup_pseudo_lock_remove(struct rdtgroup *rdtgrp);
+
+#else
+static inline int rdtgroup_locksetup_enter(struct rdtgroup *rdtgrp)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int rdtgroup_locksetup_exit(struct rdtgroup *rdtgrp)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline bool rdtgroup_cbm_overlaps_pseudo_locked(struct rdt_ctrl_domai=
n *d, unsigned long cbm)
+{
+	return false;
+}
+
+static inline bool rdtgroup_pseudo_locked_in_hierarchy(struct rdt_ctrl_domai=
n *d)
+{
+	return false;
+}
+
+static inline int rdt_pseudo_lock_init(void) { return 0; }
+static inline void rdt_pseudo_lock_release(void) { }
+static inline int rdtgroup_pseudo_lock_create(struct rdtgroup *rdtgrp)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void rdtgroup_pseudo_lock_remove(struct rdtgroup *rdtgrp) { }
+#endif /* CONFIG_RESCTRL_FS_PSEUDO_LOCK */
+
+#endif /* _FS_RESCTRL_INTERNAL_H */
diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
index e69de29..bde2801 100644
--- a/fs/resctrl/monitor.c
+++ b/fs/resctrl/monitor.c
@@ -0,0 +1,929 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Resource Director Technology(RDT)
+ * - Monitoring code
+ *
+ * Copyright (C) 2017 Intel Corporation
+ *
+ * Author:
+ *    Vikas Shivappa <vikas.shivappa@intel.com>
+ *
+ * This replaces the cqm.c based on perf but we reuse a lot of
+ * code and datastructures originally from Peter Zijlstra and Matt Fleming.
+ *
+ * More information about RDT be found in the Intel (R) x86 Architecture
+ * Software Developer Manual June 2016, volume 3, section 17.17.
+ */
+
+#define pr_fmt(fmt)	"resctrl: " fmt
+
+#include <linux/cpu.h>
+#include <linux/resctrl.h>
+#include <linux/sizes.h>
+#include <linux/slab.h>
+
+#include "internal.h"
+
+#define CREATE_TRACE_POINTS
+
+#include "monitor_trace.h"
+
+/**
+ * struct rmid_entry - dirty tracking for all RMID.
+ * @closid:	The CLOSID for this entry.
+ * @rmid:	The RMID for this entry.
+ * @busy:	The number of domains with cached data using this RMID.
+ * @list:	Member of the rmid_free_lru list when busy =3D=3D 0.
+ *
+ * Depending on the architecture the correct monitor is accessed using
+ * both @closid and @rmid, or @rmid only.
+ *
+ * Take the rdtgroup_mutex when accessing.
+ */
+struct rmid_entry {
+	u32				closid;
+	u32				rmid;
+	int				busy;
+	struct list_head		list;
+};
+
+/*
+ * @rmid_free_lru - A least recently used list of free RMIDs
+ *     These RMIDs are guaranteed to have an occupancy less than the
+ *     threshold occupancy
+ */
+static LIST_HEAD(rmid_free_lru);
+
+/*
+ * @closid_num_dirty_rmid    The number of dirty RMID each CLOSID has.
+ *     Only allocated when CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID is defined.
+ *     Indexed by CLOSID. Protected by rdtgroup_mutex.
+ */
+static u32 *closid_num_dirty_rmid;
+
+/*
+ * @rmid_limbo_count - count of currently unused but (potentially)
+ *     dirty RMIDs.
+ *     This counts RMIDs that no one is currently using but that
+ *     may have a occupancy value > resctrl_rmid_realloc_threshold. User can
+ *     change the threshold occupancy value.
+ */
+static unsigned int rmid_limbo_count;
+
+/*
+ * @rmid_entry - The entry in the limbo and free lists.
+ */
+static struct rmid_entry	*rmid_ptrs;
+
+/*
+ * This is the threshold cache occupancy in bytes at which we will consider =
an
+ * RMID available for re-allocation.
+ */
+unsigned int resctrl_rmid_realloc_threshold;
+
+/*
+ * This is the maximum value for the reallocation threshold, in bytes.
+ */
+unsigned int resctrl_rmid_realloc_limit;
+
+/*
+ * x86 and arm64 differ in their handling of monitoring.
+ * x86's RMID are independent numbers, there is only one source of traffic
+ * with an RMID value of '1'.
+ * arm64's PMG extends the PARTID/CLOSID space, there are multiple sources of
+ * traffic with a PMG value of '1', one for each CLOSID, meaning the RMID
+ * value is no longer unique.
+ * To account for this, resctrl uses an index. On x86 this is just the RMID,
+ * on arm64 it encodes the CLOSID and RMID. This gives a unique number.
+ *
+ * The domain's rmid_busy_llc and rmid_ptrs[] are sized by index. The arch c=
ode
+ * must accept an attempt to read every index.
+ */
+static inline struct rmid_entry *__rmid_entry(u32 idx)
+{
+	struct rmid_entry *entry;
+	u32 closid, rmid;
+
+	entry =3D &rmid_ptrs[idx];
+	resctrl_arch_rmid_idx_decode(idx, &closid, &rmid);
+
+	WARN_ON_ONCE(entry->closid !=3D closid);
+	WARN_ON_ONCE(entry->rmid !=3D rmid);
+
+	return entry;
+}
+
+static void limbo_release_entry(struct rmid_entry *entry)
+{
+	lockdep_assert_held(&rdtgroup_mutex);
+
+	rmid_limbo_count--;
+	list_add_tail(&entry->list, &rmid_free_lru);
+
+	if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID))
+		closid_num_dirty_rmid[entry->closid]--;
+}
+
+/*
+ * Check the RMIDs that are marked as busy for this domain. If the
+ * reported LLC occupancy is below the threshold clear the busy bit and
+ * decrement the count. If the busy count gets to zero on an RMID, we
+ * free the RMID
+ */
+void __check_limbo(struct rdt_mon_domain *d, bool force_free)
+{
+	struct rdt_resource *r =3D resctrl_arch_get_resource(RDT_RESOURCE_L3);
+	u32 idx_limit =3D resctrl_arch_system_num_rmid_idx();
+	struct rmid_entry *entry;
+	u32 idx, cur_idx =3D 1;
+	void *arch_mon_ctx;
+	bool rmid_dirty;
+	u64 val =3D 0;
+
+	arch_mon_ctx =3D resctrl_arch_mon_ctx_alloc(r, QOS_L3_OCCUP_EVENT_ID);
+	if (IS_ERR(arch_mon_ctx)) {
+		pr_warn_ratelimited("Failed to allocate monitor context: %ld",
+				    PTR_ERR(arch_mon_ctx));
+		return;
+	}
+
+	/*
+	 * Skip RMID 0 and start from RMID 1 and check all the RMIDs that
+	 * are marked as busy for occupancy < threshold. If the occupancy
+	 * is less than the threshold decrement the busy counter of the
+	 * RMID and move it to the free list when the counter reaches 0.
+	 */
+	for (;;) {
+		idx =3D find_next_bit(d->rmid_busy_llc, idx_limit, cur_idx);
+		if (idx >=3D idx_limit)
+			break;
+
+		entry =3D __rmid_entry(idx);
+		if (resctrl_arch_rmid_read(r, d, entry->closid, entry->rmid,
+					   QOS_L3_OCCUP_EVENT_ID, &val,
+					   arch_mon_ctx)) {
+			rmid_dirty =3D true;
+		} else {
+			rmid_dirty =3D (val >=3D resctrl_rmid_realloc_threshold);
+
+			/*
+			 * x86's CLOSID and RMID are independent numbers, so the entry's
+			 * CLOSID is an empty CLOSID (X86_RESCTRL_EMPTY_CLOSID). On Arm the
+			 * RMID (PMG) extends the CLOSID (PARTID) space with bits that aren't
+			 * used to select the configuration. It is thus necessary to track both
+			 * CLOSID and RMID because there may be dependencies between them
+			 * on some architectures.
+			 */
+			trace_mon_llc_occupancy_limbo(entry->closid, entry->rmid, d->hdr.id, val);
+		}
+
+		if (force_free || !rmid_dirty) {
+			clear_bit(idx, d->rmid_busy_llc);
+			if (!--entry->busy)
+				limbo_release_entry(entry);
+		}
+		cur_idx =3D idx + 1;
+	}
+
+	resctrl_arch_mon_ctx_free(r, QOS_L3_OCCUP_EVENT_ID, arch_mon_ctx);
+}
+
+bool has_busy_rmid(struct rdt_mon_domain *d)
+{
+	u32 idx_limit =3D resctrl_arch_system_num_rmid_idx();
+
+	return find_first_bit(d->rmid_busy_llc, idx_limit) !=3D idx_limit;
+}
+
+static struct rmid_entry *resctrl_find_free_rmid(u32 closid)
+{
+	struct rmid_entry *itr;
+	u32 itr_idx, cmp_idx;
+
+	if (list_empty(&rmid_free_lru))
+		return rmid_limbo_count ? ERR_PTR(-EBUSY) : ERR_PTR(-ENOSPC);
+
+	list_for_each_entry(itr, &rmid_free_lru, list) {
+		/*
+		 * Get the index of this free RMID, and the index it would need
+		 * to be if it were used with this CLOSID.
+		 * If the CLOSID is irrelevant on this architecture, the two
+		 * index values are always the same on every entry and thus the
+		 * very first entry will be returned.
+		 */
+		itr_idx =3D resctrl_arch_rmid_idx_encode(itr->closid, itr->rmid);
+		cmp_idx =3D resctrl_arch_rmid_idx_encode(closid, itr->rmid);
+
+		if (itr_idx =3D=3D cmp_idx)
+			return itr;
+	}
+
+	return ERR_PTR(-ENOSPC);
+}
+
+/**
+ * resctrl_find_cleanest_closid() - Find a CLOSID where all the associated
+ *                                  RMID are clean, or the CLOSID that has
+ *                                  the most clean RMID.
+ *
+ * MPAM's equivalent of RMID are per-CLOSID, meaning a freshly allocated CLO=
SID
+ * may not be able to allocate clean RMID. To avoid this the allocator will
+ * choose the CLOSID with the most clean RMID.
+ *
+ * When the CLOSID and RMID are independent numbers, the first free CLOSID w=
ill
+ * be returned.
+ */
+int resctrl_find_cleanest_closid(void)
+{
+	u32 cleanest_closid =3D ~0;
+	int i =3D 0;
+
+	lockdep_assert_held(&rdtgroup_mutex);
+
+	if (!IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID))
+		return -EIO;
+
+	for (i =3D 0; i < closids_supported(); i++) {
+		int num_dirty;
+
+		if (closid_allocated(i))
+			continue;
+
+		num_dirty =3D closid_num_dirty_rmid[i];
+		if (num_dirty =3D=3D 0)
+			return i;
+
+		if (cleanest_closid =3D=3D ~0)
+			cleanest_closid =3D i;
+
+		if (num_dirty < closid_num_dirty_rmid[cleanest_closid])
+			cleanest_closid =3D i;
+	}
+
+	if (cleanest_closid =3D=3D ~0)
+		return -ENOSPC;
+
+	return cleanest_closid;
+}
+
+/*
+ * For MPAM the RMID value is not unique, and has to be considered with
+ * the CLOSID. The (CLOSID, RMID) pair is allocated on all domains, which
+ * allows all domains to be managed by a single free list.
+ * Each domain also has a rmid_busy_llc to reduce the work of the limbo hand=
ler.
+ */
+int alloc_rmid(u32 closid)
+{
+	struct rmid_entry *entry;
+
+	lockdep_assert_held(&rdtgroup_mutex);
+
+	entry =3D resctrl_find_free_rmid(closid);
+	if (IS_ERR(entry))
+		return PTR_ERR(entry);
+
+	list_del(&entry->list);
+	return entry->rmid;
+}
+
+static void add_rmid_to_limbo(struct rmid_entry *entry)
+{
+	struct rdt_resource *r =3D resctrl_arch_get_resource(RDT_RESOURCE_L3);
+	struct rdt_mon_domain *d;
+	u32 idx;
+
+	lockdep_assert_held(&rdtgroup_mutex);
+
+	/* Walking r->domains, ensure it can't race with cpuhp */
+	lockdep_assert_cpus_held();
+
+	idx =3D resctrl_arch_rmid_idx_encode(entry->closid, entry->rmid);
+
+	entry->busy =3D 0;
+	list_for_each_entry(d, &r->mon_domains, hdr.list) {
+		/*
+		 * For the first limbo RMID in the domain,
+		 * setup up the limbo worker.
+		 */
+		if (!has_busy_rmid(d))
+			cqm_setup_limbo_handler(d, CQM_LIMBOCHECK_INTERVAL,
+						RESCTRL_PICK_ANY_CPU);
+		set_bit(idx, d->rmid_busy_llc);
+		entry->busy++;
+	}
+
+	rmid_limbo_count++;
+	if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID))
+		closid_num_dirty_rmid[entry->closid]++;
+}
+
+void free_rmid(u32 closid, u32 rmid)
+{
+	u32 idx =3D resctrl_arch_rmid_idx_encode(closid, rmid);
+	struct rmid_entry *entry;
+
+	lockdep_assert_held(&rdtgroup_mutex);
+
+	/*
+	 * Do not allow the default rmid to be free'd. Comparing by index
+	 * allows architectures that ignore the closid parameter to avoid an
+	 * unnecessary check.
+	 */
+	if (!resctrl_arch_mon_capable() ||
+	    idx =3D=3D resctrl_arch_rmid_idx_encode(RESCTRL_RESERVED_CLOSID,
+						RESCTRL_RESERVED_RMID))
+		return;
+
+	entry =3D __rmid_entry(idx);
+
+	if (resctrl_arch_is_llc_occupancy_enabled())
+		add_rmid_to_limbo(entry);
+	else
+		list_add_tail(&entry->list, &rmid_free_lru);
+}
+
+static struct mbm_state *get_mbm_state(struct rdt_mon_domain *d, u32 closid,
+				       u32 rmid, enum resctrl_event_id evtid)
+{
+	u32 idx =3D resctrl_arch_rmid_idx_encode(closid, rmid);
+
+	switch (evtid) {
+	case QOS_L3_MBM_TOTAL_EVENT_ID:
+		return &d->mbm_total[idx];
+	case QOS_L3_MBM_LOCAL_EVENT_ID:
+		return &d->mbm_local[idx];
+	default:
+		return NULL;
+	}
+}
+
+static int __mon_event_count(u32 closid, u32 rmid, struct rmid_read *rr)
+{
+	int cpu =3D smp_processor_id();
+	struct rdt_mon_domain *d;
+	struct mbm_state *m;
+	int err, ret;
+	u64 tval =3D 0;
+
+	if (rr->first) {
+		resctrl_arch_reset_rmid(rr->r, rr->d, closid, rmid, rr->evtid);
+		m =3D get_mbm_state(rr->d, closid, rmid, rr->evtid);
+		if (m)
+			memset(m, 0, sizeof(struct mbm_state));
+		return 0;
+	}
+
+	if (rr->d) {
+		/* Reading a single domain, must be on a CPU in that domain. */
+		if (!cpumask_test_cpu(cpu, &rr->d->hdr.cpu_mask))
+			return -EINVAL;
+		rr->err =3D resctrl_arch_rmid_read(rr->r, rr->d, closid, rmid,
+						 rr->evtid, &tval, rr->arch_mon_ctx);
+		if (rr->err)
+			return rr->err;
+
+		rr->val +=3D tval;
+
+		return 0;
+	}
+
+	/* Summing domains that share a cache, must be on a CPU for that cache. */
+	if (!cpumask_test_cpu(cpu, &rr->ci->shared_cpu_map))
+		return -EINVAL;
+
+	/*
+	 * Legacy files must report the sum of an event across all
+	 * domains that share the same L3 cache instance.
+	 * Report success if a read from any domain succeeds, -EINVAL
+	 * (translated to "Unavailable" for user space) if reading from
+	 * all domains fail for any reason.
+	 */
+	ret =3D -EINVAL;
+	list_for_each_entry(d, &rr->r->mon_domains, hdr.list) {
+		if (d->ci->id !=3D rr->ci->id)
+			continue;
+		err =3D resctrl_arch_rmid_read(rr->r, d, closid, rmid,
+					     rr->evtid, &tval, rr->arch_mon_ctx);
+		if (!err) {
+			rr->val +=3D tval;
+			ret =3D 0;
+		}
+	}
+
+	if (ret)
+		rr->err =3D ret;
+
+	return ret;
+}
+
+/*
+ * mbm_bw_count() - Update bw count from values previously read by
+ *		    __mon_event_count().
+ * @closid:	The closid used to identify the cached mbm_state.
+ * @rmid:	The rmid used to identify the cached mbm_state.
+ * @rr:		The struct rmid_read populated by __mon_event_count().
+ *
+ * Supporting function to calculate the memory bandwidth
+ * and delta bandwidth in MBps. The chunks value previously read by
+ * __mon_event_count() is compared with the chunks value from the previous
+ * invocation. This must be called once per second to maintain values in MBp=
s.
+ */
+static void mbm_bw_count(u32 closid, u32 rmid, struct rmid_read *rr)
+{
+	u64 cur_bw, bytes, cur_bytes;
+	struct mbm_state *m;
+
+	m =3D get_mbm_state(rr->d, closid, rmid, rr->evtid);
+	if (WARN_ON_ONCE(!m))
+		return;
+
+	cur_bytes =3D rr->val;
+	bytes =3D cur_bytes - m->prev_bw_bytes;
+	m->prev_bw_bytes =3D cur_bytes;
+
+	cur_bw =3D bytes / SZ_1M;
+
+	m->prev_bw =3D cur_bw;
+}
+
+/*
+ * This is scheduled by mon_event_read() to read the CQM/MBM counters
+ * on a domain.
+ */
+void mon_event_count(void *info)
+{
+	struct rdtgroup *rdtgrp, *entry;
+	struct rmid_read *rr =3D info;
+	struct list_head *head;
+	int ret;
+
+	rdtgrp =3D rr->rgrp;
+
+	ret =3D __mon_event_count(rdtgrp->closid, rdtgrp->mon.rmid, rr);
+
+	/*
+	 * For Ctrl groups read data from child monitor groups and
+	 * add them together. Count events which are read successfully.
+	 * Discard the rmid_read's reporting errors.
+	 */
+	head =3D &rdtgrp->mon.crdtgrp_list;
+
+	if (rdtgrp->type =3D=3D RDTCTRL_GROUP) {
+		list_for_each_entry(entry, head, mon.crdtgrp_list) {
+			if (__mon_event_count(entry->closid, entry->mon.rmid,
+					      rr) =3D=3D 0)
+				ret =3D 0;
+		}
+	}
+
+	/*
+	 * __mon_event_count() calls for newly created monitor groups may
+	 * report -EINVAL/Unavailable if the monitor hasn't seen any traffic.
+	 * Discard error if any of the monitor event reads succeeded.
+	 */
+	if (ret =3D=3D 0)
+		rr->err =3D 0;
+}
+
+static struct rdt_ctrl_domain *get_ctrl_domain_from_cpu(int cpu,
+							struct rdt_resource *r)
+{
+	struct rdt_ctrl_domain *d;
+
+	lockdep_assert_cpus_held();
+
+	list_for_each_entry(d, &r->ctrl_domains, hdr.list) {
+		/* Find the domain that contains this CPU */
+		if (cpumask_test_cpu(cpu, &d->hdr.cpu_mask))
+			return d;
+	}
+
+	return NULL;
+}
+
+/*
+ * Feedback loop for MBA software controller (mba_sc)
+ *
+ * mba_sc is a feedback loop where we periodically read MBM counters and
+ * adjust the bandwidth percentage values via the IA32_MBA_THRTL_MSRs so
+ * that:
+ *
+ *   current bandwidth(cur_bw) < user specified bandwidth(user_bw)
+ *
+ * This uses the MBM counters to measure the bandwidth and MBA throttle
+ * MSRs to control the bandwidth for a particular rdtgrp. It builds on the
+ * fact that resctrl rdtgroups have both monitoring and control.
+ *
+ * The frequency of the checks is 1s and we just tag along the MBM overflow
+ * timer. Having 1s interval makes the calculation of bandwidth simpler.
+ *
+ * Although MBA's goal is to restrict the bandwidth to a maximum, there may
+ * be a need to increase the bandwidth to avoid unnecessarily restricting
+ * the L2 <-> L3 traffic.
+ *
+ * Since MBA controls the L2 external bandwidth where as MBM measures the
+ * L3 external bandwidth the following sequence could lead to such a
+ * situation.
+ *
+ * Consider an rdtgroup which had high L3 <-> memory traffic in initial
+ * phases -> mba_sc kicks in and reduced bandwidth percentage values -> but
+ * after some time rdtgroup has mostly L2 <-> L3 traffic.
+ *
+ * In this case we may restrict the rdtgroup's L2 <-> L3 traffic as its
+ * throttle MSRs already have low percentage values.  To avoid
+ * unnecessarily restricting such rdtgroups, we also increase the bandwidth.
+ */
+static void update_mba_bw(struct rdtgroup *rgrp, struct rdt_mon_domain *dom_=
mbm)
+{
+	u32 closid, rmid, cur_msr_val, new_msr_val;
+	struct mbm_state *pmbm_data, *cmbm_data;
+	struct rdt_ctrl_domain *dom_mba;
+	enum resctrl_event_id evt_id;
+	struct rdt_resource *r_mba;
+	struct list_head *head;
+	struct rdtgroup *entry;
+	u32 cur_bw, user_bw;
+
+	r_mba =3D resctrl_arch_get_resource(RDT_RESOURCE_MBA);
+	evt_id =3D rgrp->mba_mbps_event;
+
+	closid =3D rgrp->closid;
+	rmid =3D rgrp->mon.rmid;
+	pmbm_data =3D get_mbm_state(dom_mbm, closid, rmid, evt_id);
+	if (WARN_ON_ONCE(!pmbm_data))
+		return;
+
+	dom_mba =3D get_ctrl_domain_from_cpu(smp_processor_id(), r_mba);
+	if (!dom_mba) {
+		pr_warn_once("Failure to get domain for MBA update\n");
+		return;
+	}
+
+	cur_bw =3D pmbm_data->prev_bw;
+	user_bw =3D dom_mba->mbps_val[closid];
+
+	/* MBA resource doesn't support CDP */
+	cur_msr_val =3D resctrl_arch_get_config(r_mba, dom_mba, closid, CDP_NONE);
+
+	/*
+	 * For Ctrl groups read data from child monitor groups.
+	 */
+	head =3D &rgrp->mon.crdtgrp_list;
+	list_for_each_entry(entry, head, mon.crdtgrp_list) {
+		cmbm_data =3D get_mbm_state(dom_mbm, entry->closid, entry->mon.rmid, evt_i=
d);
+		if (WARN_ON_ONCE(!cmbm_data))
+			return;
+		cur_bw +=3D cmbm_data->prev_bw;
+	}
+
+	/*
+	 * Scale up/down the bandwidth linearly for the ctrl group.  The
+	 * bandwidth step is the bandwidth granularity specified by the
+	 * hardware.
+	 * Always increase throttling if current bandwidth is above the
+	 * target set by user.
+	 * But avoid thrashing up and down on every poll by checking
+	 * whether a decrease in throttling is likely to push the group
+	 * back over target. E.g. if currently throttling to 30% of bandwidth
+	 * on a system with 10% granularity steps, check whether moving to
+	 * 40% would go past the limit by multiplying current bandwidth by
+	 * "(30 + 10) / 30".
+	 */
+	if (cur_msr_val > r_mba->membw.min_bw && user_bw < cur_bw) {
+		new_msr_val =3D cur_msr_val - r_mba->membw.bw_gran;
+	} else if (cur_msr_val < MAX_MBA_BW &&
+		   (user_bw > (cur_bw * (cur_msr_val + r_mba->membw.min_bw) / cur_msr_val)=
)) {
+		new_msr_val =3D cur_msr_val + r_mba->membw.bw_gran;
+	} else {
+		return;
+	}
+
+	resctrl_arch_update_one(r_mba, dom_mba, closid, CDP_NONE, new_msr_val);
+}
+
+static void mbm_update_one_event(struct rdt_resource *r, struct rdt_mon_doma=
in *d,
+				 u32 closid, u32 rmid, enum resctrl_event_id evtid)
+{
+	struct rmid_read rr =3D {0};
+
+	rr.r =3D r;
+	rr.d =3D d;
+	rr.evtid =3D evtid;
+	rr.arch_mon_ctx =3D resctrl_arch_mon_ctx_alloc(rr.r, rr.evtid);
+	if (IS_ERR(rr.arch_mon_ctx)) {
+		pr_warn_ratelimited("Failed to allocate monitor context: %ld",
+				    PTR_ERR(rr.arch_mon_ctx));
+		return;
+	}
+
+	__mon_event_count(closid, rmid, &rr);
+
+	/*
+	 * If the software controller is enabled, compute the
+	 * bandwidth for this event id.
+	 */
+	if (is_mba_sc(NULL))
+		mbm_bw_count(closid, rmid, &rr);
+
+	resctrl_arch_mon_ctx_free(rr.r, rr.evtid, rr.arch_mon_ctx);
+}
+
+static void mbm_update(struct rdt_resource *r, struct rdt_mon_domain *d,
+		       u32 closid, u32 rmid)
+{
+	/*
+	 * This is protected from concurrent reads from user as both
+	 * the user and overflow handler hold the global mutex.
+	 */
+	if (resctrl_arch_is_mbm_total_enabled())
+		mbm_update_one_event(r, d, closid, rmid, QOS_L3_MBM_TOTAL_EVENT_ID);
+
+	if (resctrl_arch_is_mbm_local_enabled())
+		mbm_update_one_event(r, d, closid, rmid, QOS_L3_MBM_LOCAL_EVENT_ID);
+}
+
+/*
+ * Handler to scan the limbo list and move the RMIDs
+ * to free list whose occupancy < threshold_occupancy.
+ */
+void cqm_handle_limbo(struct work_struct *work)
+{
+	unsigned long delay =3D msecs_to_jiffies(CQM_LIMBOCHECK_INTERVAL);
+	struct rdt_mon_domain *d;
+
+	cpus_read_lock();
+	mutex_lock(&rdtgroup_mutex);
+
+	d =3D container_of(work, struct rdt_mon_domain, cqm_limbo.work);
+
+	__check_limbo(d, false);
+
+	if (has_busy_rmid(d)) {
+		d->cqm_work_cpu =3D cpumask_any_housekeeping(&d->hdr.cpu_mask,
+							   RESCTRL_PICK_ANY_CPU);
+		schedule_delayed_work_on(d->cqm_work_cpu, &d->cqm_limbo,
+					 delay);
+	}
+
+	mutex_unlock(&rdtgroup_mutex);
+	cpus_read_unlock();
+}
+
+/**
+ * cqm_setup_limbo_handler() - Schedule the limbo handler to run for this
+ *                             domain.
+ * @dom:           The domain the limbo handler should run for.
+ * @delay_ms:      How far in the future the handler should run.
+ * @exclude_cpu:   Which CPU the handler should not run on,
+ *		   RESCTRL_PICK_ANY_CPU to pick any CPU.
+ */
+void cqm_setup_limbo_handler(struct rdt_mon_domain *dom, unsigned long delay=
_ms,
+			     int exclude_cpu)
+{
+	unsigned long delay =3D msecs_to_jiffies(delay_ms);
+	int cpu;
+
+	cpu =3D cpumask_any_housekeeping(&dom->hdr.cpu_mask, exclude_cpu);
+	dom->cqm_work_cpu =3D cpu;
+
+	if (cpu < nr_cpu_ids)
+		schedule_delayed_work_on(cpu, &dom->cqm_limbo, delay);
+}
+
+void mbm_handle_overflow(struct work_struct *work)
+{
+	unsigned long delay =3D msecs_to_jiffies(MBM_OVERFLOW_INTERVAL);
+	struct rdtgroup *prgrp, *crgrp;
+	struct rdt_mon_domain *d;
+	struct list_head *head;
+	struct rdt_resource *r;
+
+	cpus_read_lock();
+	mutex_lock(&rdtgroup_mutex);
+
+	/*
+	 * If the filesystem has been unmounted this work no longer needs to
+	 * run.
+	 */
+	if (!resctrl_mounted || !resctrl_arch_mon_capable())
+		goto out_unlock;
+
+	r =3D resctrl_arch_get_resource(RDT_RESOURCE_L3);
+	d =3D container_of(work, struct rdt_mon_domain, mbm_over.work);
+
+	list_for_each_entry(prgrp, &rdt_all_groups, rdtgroup_list) {
+		mbm_update(r, d, prgrp->closid, prgrp->mon.rmid);
+
+		head =3D &prgrp->mon.crdtgrp_list;
+		list_for_each_entry(crgrp, head, mon.crdtgrp_list)
+			mbm_update(r, d, crgrp->closid, crgrp->mon.rmid);
+
+		if (is_mba_sc(NULL))
+			update_mba_bw(prgrp, d);
+	}
+
+	/*
+	 * Re-check for housekeeping CPUs. This allows the overflow handler to
+	 * move off a nohz_full CPU quickly.
+	 */
+	d->mbm_work_cpu =3D cpumask_any_housekeeping(&d->hdr.cpu_mask,
+						   RESCTRL_PICK_ANY_CPU);
+	schedule_delayed_work_on(d->mbm_work_cpu, &d->mbm_over, delay);
+
+out_unlock:
+	mutex_unlock(&rdtgroup_mutex);
+	cpus_read_unlock();
+}
+
+/**
+ * mbm_setup_overflow_handler() - Schedule the overflow handler to run for t=
his
+ *                                domain.
+ * @dom:           The domain the overflow handler should run for.
+ * @delay_ms:      How far in the future the handler should run.
+ * @exclude_cpu:   Which CPU the handler should not run on,
+ *		   RESCTRL_PICK_ANY_CPU to pick any CPU.
+ */
+void mbm_setup_overflow_handler(struct rdt_mon_domain *dom, unsigned long de=
lay_ms,
+				int exclude_cpu)
+{
+	unsigned long delay =3D msecs_to_jiffies(delay_ms);
+	int cpu;
+
+	/*
+	 * When a domain comes online there is no guarantee the filesystem is
+	 * mounted. If not, there is no need to catch counter overflow.
+	 */
+	if (!resctrl_mounted || !resctrl_arch_mon_capable())
+		return;
+	cpu =3D cpumask_any_housekeeping(&dom->hdr.cpu_mask, exclude_cpu);
+	dom->mbm_work_cpu =3D cpu;
+
+	if (cpu < nr_cpu_ids)
+		schedule_delayed_work_on(cpu, &dom->mbm_over, delay);
+}
+
+static int dom_data_init(struct rdt_resource *r)
+{
+	u32 idx_limit =3D resctrl_arch_system_num_rmid_idx();
+	u32 num_closid =3D resctrl_arch_get_num_closid(r);
+	struct rmid_entry *entry =3D NULL;
+	int err =3D 0, i;
+	u32 idx;
+
+	mutex_lock(&rdtgroup_mutex);
+	if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID)) {
+		u32 *tmp;
+
+		/*
+		 * If the architecture hasn't provided a sanitised value here,
+		 * this may result in larger arrays than necessary. Resctrl will
+		 * use a smaller system wide value based on the resources in
+		 * use.
+		 */
+		tmp =3D kcalloc(num_closid, sizeof(*tmp), GFP_KERNEL);
+		if (!tmp) {
+			err =3D -ENOMEM;
+			goto out_unlock;
+		}
+
+		closid_num_dirty_rmid =3D tmp;
+	}
+
+	rmid_ptrs =3D kcalloc(idx_limit, sizeof(struct rmid_entry), GFP_KERNEL);
+	if (!rmid_ptrs) {
+		if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID)) {
+			kfree(closid_num_dirty_rmid);
+			closid_num_dirty_rmid =3D NULL;
+		}
+		err =3D -ENOMEM;
+		goto out_unlock;
+	}
+
+	for (i =3D 0; i < idx_limit; i++) {
+		entry =3D &rmid_ptrs[i];
+		INIT_LIST_HEAD(&entry->list);
+
+		resctrl_arch_rmid_idx_decode(i, &entry->closid, &entry->rmid);
+		list_add_tail(&entry->list, &rmid_free_lru);
+	}
+
+	/*
+	 * RESCTRL_RESERVED_CLOSID and RESCTRL_RESERVED_RMID are special and
+	 * are always allocated. These are used for the rdtgroup_default
+	 * control group, which will be setup later in resctrl_init().
+	 */
+	idx =3D resctrl_arch_rmid_idx_encode(RESCTRL_RESERVED_CLOSID,
+					   RESCTRL_RESERVED_RMID);
+	entry =3D __rmid_entry(idx);
+	list_del(&entry->list);
+
+out_unlock:
+	mutex_unlock(&rdtgroup_mutex);
+
+	return err;
+}
+
+static void dom_data_exit(struct rdt_resource *r)
+{
+	mutex_lock(&rdtgroup_mutex);
+
+	if (!r->mon_capable)
+		goto out_unlock;
+
+	if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID)) {
+		kfree(closid_num_dirty_rmid);
+		closid_num_dirty_rmid =3D NULL;
+	}
+
+	kfree(rmid_ptrs);
+	rmid_ptrs =3D NULL;
+
+out_unlock:
+	mutex_unlock(&rdtgroup_mutex);
+}
+
+static struct mon_evt llc_occupancy_event =3D {
+	.name		=3D "llc_occupancy",
+	.evtid		=3D QOS_L3_OCCUP_EVENT_ID,
+};
+
+static struct mon_evt mbm_total_event =3D {
+	.name		=3D "mbm_total_bytes",
+	.evtid		=3D QOS_L3_MBM_TOTAL_EVENT_ID,
+};
+
+static struct mon_evt mbm_local_event =3D {
+	.name		=3D "mbm_local_bytes",
+	.evtid		=3D QOS_L3_MBM_LOCAL_EVENT_ID,
+};
+
+/*
+ * Initialize the event list for the resource.
+ *
+ * Note that MBM events are also part of RDT_RESOURCE_L3 resource
+ * because as per the SDM the total and local memory bandwidth
+ * are enumerated as part of L3 monitoring.
+ */
+static void l3_mon_evt_init(struct rdt_resource *r)
+{
+	INIT_LIST_HEAD(&r->evt_list);
+
+	if (resctrl_arch_is_llc_occupancy_enabled())
+		list_add_tail(&llc_occupancy_event.list, &r->evt_list);
+	if (resctrl_arch_is_mbm_total_enabled())
+		list_add_tail(&mbm_total_event.list, &r->evt_list);
+	if (resctrl_arch_is_mbm_local_enabled())
+		list_add_tail(&mbm_local_event.list, &r->evt_list);
+}
+
+/**
+ * resctrl_mon_resource_init() - Initialise global monitoring structures.
+ *
+ * Allocate and initialise global monitor resources that do not belong to a
+ * specific domain. i.e. the rmid_ptrs[] used for the limbo and free lists.
+ * Called once during boot after the struct rdt_resource's have been configu=
red
+ * but before the filesystem is mounted.
+ * Resctrl's cpuhp callbacks may be called before this point to bring a doma=
in
+ * online.
+ *
+ * Returns 0 for success, or -ENOMEM.
+ */
+int resctrl_mon_resource_init(void)
+{
+	struct rdt_resource *r =3D resctrl_arch_get_resource(RDT_RESOURCE_L3);
+	int ret;
+
+	if (!r->mon_capable)
+		return 0;
+
+	ret =3D dom_data_init(r);
+	if (ret)
+		return ret;
+
+	l3_mon_evt_init(r);
+
+	if (resctrl_arch_is_evt_configurable(QOS_L3_MBM_TOTAL_EVENT_ID)) {
+		mbm_total_event.configurable =3D true;
+		resctrl_file_fflags_init("mbm_total_bytes_config",
+					 RFTYPE_MON_INFO | RFTYPE_RES_CACHE);
+	}
+	if (resctrl_arch_is_evt_configurable(QOS_L3_MBM_LOCAL_EVENT_ID)) {
+		mbm_local_event.configurable =3D true;
+		resctrl_file_fflags_init("mbm_local_bytes_config",
+					 RFTYPE_MON_INFO | RFTYPE_RES_CACHE);
+	}
+
+	if (resctrl_arch_is_mbm_local_enabled())
+		mba_mbps_default_event =3D QOS_L3_MBM_LOCAL_EVENT_ID;
+	else if (resctrl_arch_is_mbm_total_enabled())
+		mba_mbps_default_event =3D QOS_L3_MBM_TOTAL_EVENT_ID;
+
+	return 0;
+}
+
+void resctrl_mon_resource_exit(void)
+{
+	struct rdt_resource *r =3D resctrl_arch_get_resource(RDT_RESOURCE_L3);
+
+	dom_data_exit(r);
+}
diff --git a/fs/resctrl/monitor_trace.h b/fs/resctrl/monitor_trace.h
index e69de29..fdf49f2 100644
--- a/fs/resctrl/monitor_trace.h
+++ b/fs/resctrl/monitor_trace.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM resctrl
+
+#if !defined(_FS_RESCTRL_MONITOR_TRACE_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _FS_RESCTRL_MONITOR_TRACE_H
+
+#include <linux/tracepoint.h>
+
+TRACE_EVENT(mon_llc_occupancy_limbo,
+	    TP_PROTO(u32 ctrl_hw_id, u32 mon_hw_id, int domain_id, u64 llc_occupanc=
y_bytes),
+	    TP_ARGS(ctrl_hw_id, mon_hw_id, domain_id, llc_occupancy_bytes),
+	    TP_STRUCT__entry(__field(u32, ctrl_hw_id)
+			     __field(u32, mon_hw_id)
+			     __field(int, domain_id)
+			     __field(u64, llc_occupancy_bytes)),
+	    TP_fast_assign(__entry->ctrl_hw_id =3D ctrl_hw_id;
+			   __entry->mon_hw_id =3D mon_hw_id;
+			   __entry->domain_id =3D domain_id;
+			   __entry->llc_occupancy_bytes =3D llc_occupancy_bytes;),
+	    TP_printk("ctrl_hw_id=3D%u mon_hw_id=3D%u domain_id=3D%d llc_occupancy_=
bytes=3D%llu",
+		      __entry->ctrl_hw_id, __entry->mon_hw_id, __entry->domain_id,
+		      __entry->llc_occupancy_bytes)
+	   );
+
+#endif /* _FS_RESCTRL_MONITOR_TRACE_H */
+
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH .
+
+#define TRACE_INCLUDE_FILE monitor_trace
+
+#include <trace/define_trace.h>
diff --git a/fs/resctrl/pseudo_lock.c b/fs/resctrl/pseudo_lock.c
index e69de29..ccc2f92 100644
--- a/fs/resctrl/pseudo_lock.c
+++ b/fs/resctrl/pseudo_lock.c
@@ -0,0 +1,1105 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Resource Director Technology (RDT)
+ *
+ * Pseudo-locking support built on top of Cache Allocation Technology (CAT)
+ *
+ * Copyright (C) 2018 Intel Corporation
+ *
+ * Author: Reinette Chatre <reinette.chatre@intel.com>
+ */
+
+#define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
+
+#include <linux/cacheinfo.h>
+#include <linux/cpu.h>
+#include <linux/cpumask.h>
+#include <linux/debugfs.h>
+#include <linux/kthread.h>
+#include <linux/mman.h>
+#include <linux/pm_qos.h>
+#include <linux/resctrl.h>
+#include <linux/slab.h>
+#include <linux/uaccess.h>
+
+#include "internal.h"
+
+/*
+ * Major number assigned to and shared by all devices exposing
+ * pseudo-locked regions.
+ */
+static unsigned int pseudo_lock_major;
+
+static unsigned long pseudo_lock_minor_avail =3D GENMASK(MINORBITS, 0);
+
+static char *pseudo_lock_devnode(const struct device *dev, umode_t *mode)
+{
+	const struct rdtgroup *rdtgrp;
+
+	rdtgrp =3D dev_get_drvdata(dev);
+	if (mode)
+		*mode =3D 0600;
+	guard(mutex)(&rdtgroup_mutex);
+	return kasprintf(GFP_KERNEL, "pseudo_lock/%s", rdt_kn_name(rdtgrp->kn));
+}
+
+static const struct class pseudo_lock_class =3D {
+	.name =3D "pseudo_lock",
+	.devnode =3D pseudo_lock_devnode,
+};
+
+/**
+ * pseudo_lock_minor_get - Obtain available minor number
+ * @minor: Pointer to where new minor number will be stored
+ *
+ * A bitmask is used to track available minor numbers. Here the next free
+ * minor number is marked as unavailable and returned.
+ *
+ * Return: 0 on success, <0 on failure.
+ */
+static int pseudo_lock_minor_get(unsigned int *minor)
+{
+	unsigned long first_bit;
+
+	first_bit =3D find_first_bit(&pseudo_lock_minor_avail, MINORBITS);
+
+	if (first_bit =3D=3D MINORBITS)
+		return -ENOSPC;
+
+	__clear_bit(first_bit, &pseudo_lock_minor_avail);
+	*minor =3D first_bit;
+
+	return 0;
+}
+
+/**
+ * pseudo_lock_minor_release - Return minor number to available
+ * @minor: The minor number made available
+ */
+static void pseudo_lock_minor_release(unsigned int minor)
+{
+	__set_bit(minor, &pseudo_lock_minor_avail);
+}
+
+/**
+ * region_find_by_minor - Locate a pseudo-lock region by inode minor number
+ * @minor: The minor number of the device representing pseudo-locked region
+ *
+ * When the character device is accessed we need to determine which
+ * pseudo-locked region it belongs to. This is done by matching the minor
+ * number of the device to the pseudo-locked region it belongs.
+ *
+ * Minor numbers are assigned at the time a pseudo-locked region is associat=
ed
+ * with a cache instance.
+ *
+ * Return: On success return pointer to resource group owning the pseudo-loc=
ked
+ *         region, NULL on failure.
+ */
+static struct rdtgroup *region_find_by_minor(unsigned int minor)
+{
+	struct rdtgroup *rdtgrp, *rdtgrp_match =3D NULL;
+
+	list_for_each_entry(rdtgrp, &rdt_all_groups, rdtgroup_list) {
+		if (rdtgrp->plr && rdtgrp->plr->minor =3D=3D minor) {
+			rdtgrp_match =3D rdtgrp;
+			break;
+		}
+	}
+	return rdtgrp_match;
+}
+
+/**
+ * struct pseudo_lock_pm_req - A power management QoS request list entry
+ * @list:	Entry within the @pm_reqs list for a pseudo-locked region
+ * @req:	PM QoS request
+ */
+struct pseudo_lock_pm_req {
+	struct list_head list;
+	struct dev_pm_qos_request req;
+};
+
+static void pseudo_lock_cstates_relax(struct pseudo_lock_region *plr)
+{
+	struct pseudo_lock_pm_req *pm_req, *next;
+
+	list_for_each_entry_safe(pm_req, next, &plr->pm_reqs, list) {
+		dev_pm_qos_remove_request(&pm_req->req);
+		list_del(&pm_req->list);
+		kfree(pm_req);
+	}
+}
+
+/**
+ * pseudo_lock_cstates_constrain - Restrict cores from entering C6
+ * @plr: Pseudo-locked region
+ *
+ * To prevent the cache from being affected by power management entering
+ * C6 has to be avoided. This is accomplished by requesting a latency
+ * requirement lower than lowest C6 exit latency of all supported
+ * platforms as found in the cpuidle state tables in the intel_idle driver.
+ * At this time it is possible to do so with a single latency requirement
+ * for all supported platforms.
+ *
+ * Since Goldmont is supported, which is affected by X86_BUG_MONITOR,
+ * the ACPI latencies need to be considered while keeping in mind that C2
+ * may be set to map to deeper sleep states. In this case the latency
+ * requirement needs to prevent entering C2 also.
+ *
+ * Return: 0 on success, <0 on failure
+ */
+static int pseudo_lock_cstates_constrain(struct pseudo_lock_region *plr)
+{
+	struct pseudo_lock_pm_req *pm_req;
+	int cpu;
+	int ret;
+
+	for_each_cpu(cpu, &plr->d->hdr.cpu_mask) {
+		pm_req =3D kzalloc(sizeof(*pm_req), GFP_KERNEL);
+		if (!pm_req) {
+			rdt_last_cmd_puts("Failure to allocate memory for PM QoS\n");
+			ret =3D -ENOMEM;
+			goto out_err;
+		}
+		ret =3D dev_pm_qos_add_request(get_cpu_device(cpu),
+					     &pm_req->req,
+					     DEV_PM_QOS_RESUME_LATENCY,
+					     30);
+		if (ret < 0) {
+			rdt_last_cmd_printf("Failed to add latency req CPU%d\n",
+					    cpu);
+			kfree(pm_req);
+			ret =3D -1;
+			goto out_err;
+		}
+		list_add(&pm_req->list, &plr->pm_reqs);
+	}
+
+	return 0;
+
+out_err:
+	pseudo_lock_cstates_relax(plr);
+	return ret;
+}
+
+/**
+ * pseudo_lock_region_clear - Reset pseudo-lock region data
+ * @plr: pseudo-lock region
+ *
+ * All content of the pseudo-locked region is reset - any memory allocated
+ * freed.
+ *
+ * Return: void
+ */
+static void pseudo_lock_region_clear(struct pseudo_lock_region *plr)
+{
+	plr->size =3D 0;
+	plr->line_size =3D 0;
+	kfree(plr->kmem);
+	plr->kmem =3D NULL;
+	plr->s =3D NULL;
+	if (plr->d)
+		plr->d->plr =3D NULL;
+	plr->d =3D NULL;
+	plr->cbm =3D 0;
+	plr->debugfs_dir =3D NULL;
+}
+
+/**
+ * pseudo_lock_region_init - Initialize pseudo-lock region information
+ * @plr: pseudo-lock region
+ *
+ * Called after user provided a schemata to be pseudo-locked. From the
+ * schemata the &struct pseudo_lock_region is on entry already initialized
+ * with the resource, domain, and capacity bitmask. Here the information
+ * required for pseudo-locking is deduced from this data and &struct
+ * pseudo_lock_region initialized further. This information includes:
+ * - size in bytes of the region to be pseudo-locked
+ * - cache line size to know the stride with which data needs to be accessed
+ *   to be pseudo-locked
+ * - a cpu associated with the cache instance on which the pseudo-locking
+ *   flow can be executed
+ *
+ * Return: 0 on success, <0 on failure. Descriptive error will be written
+ * to last_cmd_status buffer.
+ */
+static int pseudo_lock_region_init(struct pseudo_lock_region *plr)
+{
+	enum resctrl_scope scope =3D plr->s->res->ctrl_scope;
+	struct cacheinfo *ci;
+	int ret;
+
+	if (WARN_ON_ONCE(scope !=3D RESCTRL_L2_CACHE && scope !=3D RESCTRL_L3_CACHE=
))
+		return -ENODEV;
+
+	/* Pick the first cpu we find that is associated with the cache. */
+	plr->cpu =3D cpumask_first(&plr->d->hdr.cpu_mask);
+
+	if (!cpu_online(plr->cpu)) {
+		rdt_last_cmd_printf("CPU %u associated with cache not online\n",
+				    plr->cpu);
+		ret =3D -ENODEV;
+		goto out_region;
+	}
+
+	ci =3D get_cpu_cacheinfo_level(plr->cpu, scope);
+	if (ci) {
+		plr->line_size =3D ci->coherency_line_size;
+		plr->size =3D rdtgroup_cbm_to_size(plr->s->res, plr->d, plr->cbm);
+		return 0;
+	}
+
+	ret =3D -1;
+	rdt_last_cmd_puts("Unable to determine cache line size\n");
+out_region:
+	pseudo_lock_region_clear(plr);
+	return ret;
+}
+
+/**
+ * pseudo_lock_init - Initialize a pseudo-lock region
+ * @rdtgrp: resource group to which new pseudo-locked region will belong
+ *
+ * A pseudo-locked region is associated with a resource group. When this
+ * association is created the pseudo-locked region is initialized. The
+ * details of the pseudo-locked region are not known at this time so only
+ * allocation is done and association established.
+ *
+ * Return: 0 on success, <0 on failure
+ */
+static int pseudo_lock_init(struct rdtgroup *rdtgrp)
+{
+	struct pseudo_lock_region *plr;
+
+	plr =3D kzalloc(sizeof(*plr), GFP_KERNEL);
+	if (!plr)
+		return -ENOMEM;
+
+	init_waitqueue_head(&plr->lock_thread_wq);
+	INIT_LIST_HEAD(&plr->pm_reqs);
+	rdtgrp->plr =3D plr;
+	return 0;
+}
+
+/**
+ * pseudo_lock_region_alloc - Allocate kernel memory that will be pseudo-loc=
ked
+ * @plr: pseudo-lock region
+ *
+ * Initialize the details required to set up the pseudo-locked region and
+ * allocate the contiguous memory that will be pseudo-locked to the cache.
+ *
+ * Return: 0 on success, <0 on failure.  Descriptive error will be written
+ * to last_cmd_status buffer.
+ */
+static int pseudo_lock_region_alloc(struct pseudo_lock_region *plr)
+{
+	int ret;
+
+	ret =3D pseudo_lock_region_init(plr);
+	if (ret < 0)
+		return ret;
+
+	/*
+	 * We do not yet support contiguous regions larger than
+	 * KMALLOC_MAX_SIZE.
+	 */
+	if (plr->size > KMALLOC_MAX_SIZE) {
+		rdt_last_cmd_puts("Requested region exceeds maximum size\n");
+		ret =3D -E2BIG;
+		goto out_region;
+	}
+
+	plr->kmem =3D kzalloc(plr->size, GFP_KERNEL);
+	if (!plr->kmem) {
+		rdt_last_cmd_puts("Unable to allocate memory\n");
+		ret =3D -ENOMEM;
+		goto out_region;
+	}
+
+	ret =3D 0;
+	goto out;
+out_region:
+	pseudo_lock_region_clear(plr);
+out:
+	return ret;
+}
+
+/**
+ * pseudo_lock_free - Free a pseudo-locked region
+ * @rdtgrp: resource group to which pseudo-locked region belonged
+ *
+ * The pseudo-locked region's resources have already been released, or not
+ * yet created at this point. Now it can be freed and disassociated from the
+ * resource group.
+ *
+ * Return: void
+ */
+static void pseudo_lock_free(struct rdtgroup *rdtgrp)
+{
+	pseudo_lock_region_clear(rdtgrp->plr);
+	kfree(rdtgrp->plr);
+	rdtgrp->plr =3D NULL;
+}
+
+/**
+ * rdtgroup_monitor_in_progress - Test if monitoring in progress
+ * @rdtgrp: resource group being queried
+ *
+ * Return: 1 if monitor groups have been created for this resource
+ * group, 0 otherwise.
+ */
+static int rdtgroup_monitor_in_progress(struct rdtgroup *rdtgrp)
+{
+	return !list_empty(&rdtgrp->mon.crdtgrp_list);
+}
+
+/**
+ * rdtgroup_locksetup_user_restrict - Restrict user access to group
+ * @rdtgrp: resource group needing access restricted
+ *
+ * A resource group used for cache pseudo-locking cannot have cpus or tasks
+ * assigned to it. This is communicated to the user by restricting access
+ * to all the files that can be used to make such changes.
+ *
+ * Permissions restored with rdtgroup_locksetup_user_restore()
+ *
+ * Return: 0 on success, <0 on failure. If a failure occurs during the
+ * restriction of access an attempt will be made to restore permissions but
+ * the state of the mode of these files will be uncertain when a failure
+ * occurs.
+ */
+static int rdtgroup_locksetup_user_restrict(struct rdtgroup *rdtgrp)
+{
+	int ret;
+
+	ret =3D rdtgroup_kn_mode_restrict(rdtgrp, "tasks");
+	if (ret)
+		return ret;
+
+	ret =3D rdtgroup_kn_mode_restrict(rdtgrp, "cpus");
+	if (ret)
+		goto err_tasks;
+
+	ret =3D rdtgroup_kn_mode_restrict(rdtgrp, "cpus_list");
+	if (ret)
+		goto err_cpus;
+
+	if (resctrl_arch_mon_capable()) {
+		ret =3D rdtgroup_kn_mode_restrict(rdtgrp, "mon_groups");
+		if (ret)
+			goto err_cpus_list;
+	}
+
+	ret =3D 0;
+	goto out;
+
+err_cpus_list:
+	rdtgroup_kn_mode_restore(rdtgrp, "cpus_list", 0777);
+err_cpus:
+	rdtgroup_kn_mode_restore(rdtgrp, "cpus", 0777);
+err_tasks:
+	rdtgroup_kn_mode_restore(rdtgrp, "tasks", 0777);
+out:
+	return ret;
+}
+
+/**
+ * rdtgroup_locksetup_user_restore - Restore user access to group
+ * @rdtgrp: resource group needing access restored
+ *
+ * Restore all file access previously removed using
+ * rdtgroup_locksetup_user_restrict()
+ *
+ * Return: 0 on success, <0 on failure.  If a failure occurs during the
+ * restoration of access an attempt will be made to restrict permissions
+ * again but the state of the mode of these files will be uncertain when
+ * a failure occurs.
+ */
+static int rdtgroup_locksetup_user_restore(struct rdtgroup *rdtgrp)
+{
+	int ret;
+
+	ret =3D rdtgroup_kn_mode_restore(rdtgrp, "tasks", 0777);
+	if (ret)
+		return ret;
+
+	ret =3D rdtgroup_kn_mode_restore(rdtgrp, "cpus", 0777);
+	if (ret)
+		goto err_tasks;
+
+	ret =3D rdtgroup_kn_mode_restore(rdtgrp, "cpus_list", 0777);
+	if (ret)
+		goto err_cpus;
+
+	if (resctrl_arch_mon_capable()) {
+		ret =3D rdtgroup_kn_mode_restore(rdtgrp, "mon_groups", 0777);
+		if (ret)
+			goto err_cpus_list;
+	}
+
+	ret =3D 0;
+	goto out;
+
+err_cpus_list:
+	rdtgroup_kn_mode_restrict(rdtgrp, "cpus_list");
+err_cpus:
+	rdtgroup_kn_mode_restrict(rdtgrp, "cpus");
+err_tasks:
+	rdtgroup_kn_mode_restrict(rdtgrp, "tasks");
+out:
+	return ret;
+}
+
+/**
+ * rdtgroup_locksetup_enter - Resource group enters locksetup mode
+ * @rdtgrp: resource group requested to enter locksetup mode
+ *
+ * A resource group enters locksetup mode to reflect that it would be used
+ * to represent a pseudo-locked region and is in the process of being set
+ * up to do so. A resource group used for a pseudo-locked region would
+ * lose the closid associated with it so we cannot allow it to have any
+ * tasks or cpus assigned nor permit tasks or cpus to be assigned in the
+ * future. Monitoring of a pseudo-locked region is not allowed either.
+ *
+ * The above and more restrictions on a pseudo-locked region are checked
+ * for and enforced before the resource group enters the locksetup mode.
+ *
+ * Returns: 0 if the resource group successfully entered locksetup mode, <0
+ * on failure. On failure the last_cmd_status buffer is updated with text to
+ * communicate details of failure to the user.
+ */
+int rdtgroup_locksetup_enter(struct rdtgroup *rdtgrp)
+{
+	int ret;
+
+	/*
+	 * The default resource group can neither be removed nor lose the
+	 * default closid associated with it.
+	 */
+	if (rdtgrp =3D=3D &rdtgroup_default) {
+		rdt_last_cmd_puts("Cannot pseudo-lock default group\n");
+		return -EINVAL;
+	}
+
+	/*
+	 * Cache Pseudo-locking not supported when CDP is enabled.
+	 *
+	 * Some things to consider if you would like to enable this
+	 * support (using L3 CDP as example):
+	 * - When CDP is enabled two separate resources are exposed,
+	 *   L3DATA and L3CODE, but they are actually on the same cache.
+	 *   The implication for pseudo-locking is that if a
+	 *   pseudo-locked region is created on a domain of one
+	 *   resource (eg. L3CODE), then a pseudo-locked region cannot
+	 *   be created on that same domain of the other resource
+	 *   (eg. L3DATA). This is because the creation of a
+	 *   pseudo-locked region involves a call to wbinvd that will
+	 *   affect all cache allocations on particular domain.
+	 * - Considering the previous, it may be possible to only
+	 *   expose one of the CDP resources to pseudo-locking and
+	 *   hide the other. For example, we could consider to only
+	 *   expose L3DATA and since the L3 cache is unified it is
+	 *   still possible to place instructions there are execute it.
+	 * - If only one region is exposed to pseudo-locking we should
+	 *   still keep in mind that availability of a portion of cache
+	 *   for pseudo-locking should take into account both resources.
+	 *   Similarly, if a pseudo-locked region is created in one
+	 *   resource, the portion of cache used by it should be made
+	 *   unavailable to all future allocations from both resources.
+	 */
+	if (resctrl_arch_get_cdp_enabled(RDT_RESOURCE_L3) ||
+	    resctrl_arch_get_cdp_enabled(RDT_RESOURCE_L2)) {
+		rdt_last_cmd_puts("CDP enabled\n");
+		return -EINVAL;
+	}
+
+	/*
+	 * Not knowing the bits to disable prefetching implies that this
+	 * platform does not support Cache Pseudo-Locking.
+	 */
+	if (resctrl_arch_get_prefetch_disable_bits() =3D=3D 0) {
+		rdt_last_cmd_puts("Pseudo-locking not supported\n");
+		return -EINVAL;
+	}
+
+	if (rdtgroup_monitor_in_progress(rdtgrp)) {
+		rdt_last_cmd_puts("Monitoring in progress\n");
+		return -EINVAL;
+	}
+
+	if (rdtgroup_tasks_assigned(rdtgrp)) {
+		rdt_last_cmd_puts("Tasks assigned to resource group\n");
+		return -EINVAL;
+	}
+
+	if (!cpumask_empty(&rdtgrp->cpu_mask)) {
+		rdt_last_cmd_puts("CPUs assigned to resource group\n");
+		return -EINVAL;
+	}
+
+	if (rdtgroup_locksetup_user_restrict(rdtgrp)) {
+		rdt_last_cmd_puts("Unable to modify resctrl permissions\n");
+		return -EIO;
+	}
+
+	ret =3D pseudo_lock_init(rdtgrp);
+	if (ret) {
+		rdt_last_cmd_puts("Unable to init pseudo-lock region\n");
+		goto out_release;
+	}
+
+	/*
+	 * If this system is capable of monitoring a rmid would have been
+	 * allocated when the control group was created. This is not needed
+	 * anymore when this group would be used for pseudo-locking. This
+	 * is safe to call on platforms not capable of monitoring.
+	 */
+	free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
+
+	ret =3D 0;
+	goto out;
+
+out_release:
+	rdtgroup_locksetup_user_restore(rdtgrp);
+out:
+	return ret;
+}
+
+/**
+ * rdtgroup_locksetup_exit - resource group exist locksetup mode
+ * @rdtgrp: resource group
+ *
+ * When a resource group exits locksetup mode the earlier restrictions are
+ * lifted.
+ *
+ * Return: 0 on success, <0 on failure
+ */
+int rdtgroup_locksetup_exit(struct rdtgroup *rdtgrp)
+{
+	int ret;
+
+	if (resctrl_arch_mon_capable()) {
+		ret =3D alloc_rmid(rdtgrp->closid);
+		if (ret < 0) {
+			rdt_last_cmd_puts("Out of RMIDs\n");
+			return ret;
+		}
+		rdtgrp->mon.rmid =3D ret;
+	}
+
+	ret =3D rdtgroup_locksetup_user_restore(rdtgrp);
+	if (ret) {
+		free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
+		return ret;
+	}
+
+	pseudo_lock_free(rdtgrp);
+	return 0;
+}
+
+/**
+ * rdtgroup_cbm_overlaps_pseudo_locked - Test if CBM or portion is pseudo-lo=
cked
+ * @d: RDT domain
+ * @cbm: CBM to test
+ *
+ * @d represents a cache instance and @cbm a capacity bitmask that is
+ * considered for it. Determine if @cbm overlaps with any existing
+ * pseudo-locked region on @d.
+ *
+ * @cbm is unsigned long, even if only 32 bits are used, to make the
+ * bitmap functions work correctly.
+ *
+ * Return: true if @cbm overlaps with pseudo-locked region on @d, false
+ * otherwise.
+ */
+bool rdtgroup_cbm_overlaps_pseudo_locked(struct rdt_ctrl_domain *d, unsigned=
 long cbm)
+{
+	unsigned int cbm_len;
+	unsigned long cbm_b;
+
+	if (d->plr) {
+		cbm_len =3D d->plr->s->res->cache.cbm_len;
+		cbm_b =3D d->plr->cbm;
+		if (bitmap_intersects(&cbm, &cbm_b, cbm_len))
+			return true;
+	}
+	return false;
+}
+
+/**
+ * rdtgroup_pseudo_locked_in_hierarchy - Pseudo-locked region in cache hiera=
rchy
+ * @d: RDT domain under test
+ *
+ * The setup of a pseudo-locked region affects all cache instances within
+ * the hierarchy of the region. It is thus essential to know if any
+ * pseudo-locked regions exist within a cache hierarchy to prevent any
+ * attempts to create new pseudo-locked regions in the same hierarchy.
+ *
+ * Return: true if a pseudo-locked region exists in the hierarchy of @d or
+ *         if it is not possible to test due to memory allocation issue,
+ *         false otherwise.
+ */
+bool rdtgroup_pseudo_locked_in_hierarchy(struct rdt_ctrl_domain *d)
+{
+	struct rdt_ctrl_domain *d_i;
+	cpumask_var_t cpu_with_psl;
+	struct rdt_resource *r;
+	bool ret =3D false;
+
+	/* Walking r->domains, ensure it can't race with cpuhp */
+	lockdep_assert_cpus_held();
+
+	if (!zalloc_cpumask_var(&cpu_with_psl, GFP_KERNEL))
+		return true;
+
+	/*
+	 * First determine which cpus have pseudo-locked regions
+	 * associated with them.
+	 */
+	for_each_alloc_capable_rdt_resource(r) {
+		list_for_each_entry(d_i, &r->ctrl_domains, hdr.list) {
+			if (d_i->plr)
+				cpumask_or(cpu_with_psl, cpu_with_psl,
+					   &d_i->hdr.cpu_mask);
+		}
+	}
+
+	/*
+	 * Next test if new pseudo-locked region would intersect with
+	 * existing region.
+	 */
+	if (cpumask_intersects(&d->hdr.cpu_mask, cpu_with_psl))
+		ret =3D true;
+
+	free_cpumask_var(cpu_with_psl);
+	return ret;
+}
+
+/**
+ * pseudo_lock_measure_cycles - Trigger latency measure to pseudo-locked reg=
ion
+ * @rdtgrp: Resource group to which the pseudo-locked region belongs.
+ * @sel: Selector of which measurement to perform on a pseudo-locked region.
+ *
+ * The measurement of latency to access a pseudo-locked region should be
+ * done from a cpu that is associated with that pseudo-locked region.
+ * Determine which cpu is associated with this region and start a thread on
+ * that cpu to perform the measurement, wait for that thread to complete.
+ *
+ * Return: 0 on success, <0 on failure
+ */
+static int pseudo_lock_measure_cycles(struct rdtgroup *rdtgrp, int sel)
+{
+	struct pseudo_lock_region *plr =3D rdtgrp->plr;
+	struct task_struct *thread;
+	unsigned int cpu;
+	int ret =3D -1;
+
+	cpus_read_lock();
+	mutex_lock(&rdtgroup_mutex);
+
+	if (rdtgrp->flags & RDT_DELETED) {
+		ret =3D -ENODEV;
+		goto out;
+	}
+
+	if (!plr->d) {
+		ret =3D -ENODEV;
+		goto out;
+	}
+
+	plr->thread_done =3D 0;
+	cpu =3D cpumask_first(&plr->d->hdr.cpu_mask);
+	if (!cpu_online(cpu)) {
+		ret =3D -ENODEV;
+		goto out;
+	}
+
+	plr->cpu =3D cpu;
+
+	if (sel =3D=3D 1)
+		thread =3D kthread_run_on_cpu(resctrl_arch_measure_cycles_lat_fn,
+					    plr, cpu, "pseudo_lock_measure/%u");
+	else if (sel =3D=3D 2)
+		thread =3D kthread_run_on_cpu(resctrl_arch_measure_l2_residency,
+					    plr, cpu, "pseudo_lock_measure/%u");
+	else if (sel =3D=3D 3)
+		thread =3D kthread_run_on_cpu(resctrl_arch_measure_l3_residency,
+					    plr, cpu, "pseudo_lock_measure/%u");
+	else
+		goto out;
+
+	if (IS_ERR(thread)) {
+		ret =3D PTR_ERR(thread);
+		goto out;
+	}
+
+	ret =3D wait_event_interruptible(plr->lock_thread_wq,
+				       plr->thread_done =3D=3D 1);
+	if (ret < 0)
+		goto out;
+
+	ret =3D 0;
+
+out:
+	mutex_unlock(&rdtgroup_mutex);
+	cpus_read_unlock();
+	return ret;
+}
+
+static ssize_t pseudo_lock_measure_trigger(struct file *file,
+					   const char __user *user_buf,
+					   size_t count, loff_t *ppos)
+{
+	struct rdtgroup *rdtgrp =3D file->private_data;
+	size_t buf_size;
+	char buf[32];
+	int ret;
+	int sel;
+
+	buf_size =3D min(count, (sizeof(buf) - 1));
+	if (copy_from_user(buf, user_buf, buf_size))
+		return -EFAULT;
+
+	buf[buf_size] =3D '\0';
+	ret =3D kstrtoint(buf, 10, &sel);
+	if (ret =3D=3D 0) {
+		if (sel !=3D 1 && sel !=3D 2 && sel !=3D 3)
+			return -EINVAL;
+		ret =3D debugfs_file_get(file->f_path.dentry);
+		if (ret)
+			return ret;
+		ret =3D pseudo_lock_measure_cycles(rdtgrp, sel);
+		if (ret =3D=3D 0)
+			ret =3D count;
+		debugfs_file_put(file->f_path.dentry);
+	}
+
+	return ret;
+}
+
+static const struct file_operations pseudo_measure_fops =3D {
+	.write =3D pseudo_lock_measure_trigger,
+	.open =3D simple_open,
+	.llseek =3D default_llseek,
+};
+
+/**
+ * rdtgroup_pseudo_lock_create - Create a pseudo-locked region
+ * @rdtgrp: resource group to which pseudo-lock region belongs
+ *
+ * Called when a resource group in the pseudo-locksetup mode receives a
+ * valid schemata that should be pseudo-locked. Since the resource group is
+ * in pseudo-locksetup mode the &struct pseudo_lock_region has already been
+ * allocated and initialized with the essential information. If a failure
+ * occurs the resource group remains in the pseudo-locksetup mode with the
+ * &struct pseudo_lock_region associated with it, but cleared from all
+ * information and ready for the user to re-attempt pseudo-locking by
+ * writing the schemata again.
+ *
+ * Return: 0 if the pseudo-locked region was successfully pseudo-locked, <0
+ * on failure. Descriptive error will be written to last_cmd_status buffer.
+ */
+int rdtgroup_pseudo_lock_create(struct rdtgroup *rdtgrp)
+{
+	struct pseudo_lock_region *plr =3D rdtgrp->plr;
+	struct task_struct *thread;
+	unsigned int new_minor;
+	struct device *dev;
+	char *kn_name __free(kfree) =3D NULL;
+	int ret;
+
+	ret =3D pseudo_lock_region_alloc(plr);
+	if (ret < 0)
+		return ret;
+
+	ret =3D pseudo_lock_cstates_constrain(plr);
+	if (ret < 0) {
+		ret =3D -EINVAL;
+		goto out_region;
+	}
+	kn_name =3D kstrdup(rdt_kn_name(rdtgrp->kn), GFP_KERNEL);
+	if (!kn_name) {
+		ret =3D -ENOMEM;
+		goto out_cstates;
+	}
+
+	plr->thread_done =3D 0;
+
+	thread =3D kthread_run_on_cpu(resctrl_arch_pseudo_lock_fn, plr,
+				    plr->cpu, "pseudo_lock/%u");
+	if (IS_ERR(thread)) {
+		ret =3D PTR_ERR(thread);
+		rdt_last_cmd_printf("Locking thread returned error %d\n", ret);
+		goto out_cstates;
+	}
+
+	ret =3D wait_event_interruptible(plr->lock_thread_wq,
+				       plr->thread_done =3D=3D 1);
+	if (ret < 0) {
+		/*
+		 * If the thread does not get on the CPU for whatever
+		 * reason and the process which sets up the region is
+		 * interrupted then this will leave the thread in runnable
+		 * state and once it gets on the CPU it will dereference
+		 * the cleared, but not freed, plr struct resulting in an
+		 * empty pseudo-locking loop.
+		 */
+		rdt_last_cmd_puts("Locking thread interrupted\n");
+		goto out_cstates;
+	}
+
+	ret =3D pseudo_lock_minor_get(&new_minor);
+	if (ret < 0) {
+		rdt_last_cmd_puts("Unable to obtain a new minor number\n");
+		goto out_cstates;
+	}
+
+	/*
+	 * Unlock access but do not release the reference. The
+	 * pseudo-locked region will still be here on return.
+	 *
+	 * The mutex has to be released temporarily to avoid a potential
+	 * deadlock with the mm->mmap_lock which is obtained in the
+	 * device_create() and debugfs_create_dir() callpath below as well as
+	 * before the mmap() callback is called.
+	 */
+	mutex_unlock(&rdtgroup_mutex);
+
+	if (!IS_ERR_OR_NULL(debugfs_resctrl)) {
+		plr->debugfs_dir =3D debugfs_create_dir(kn_name, debugfs_resctrl);
+		if (!IS_ERR_OR_NULL(plr->debugfs_dir))
+			debugfs_create_file("pseudo_lock_measure", 0200,
+					    plr->debugfs_dir, rdtgrp,
+					    &pseudo_measure_fops);
+	}
+
+	dev =3D device_create(&pseudo_lock_class, NULL,
+			    MKDEV(pseudo_lock_major, new_minor),
+			    rdtgrp, "%s", kn_name);
+
+	mutex_lock(&rdtgroup_mutex);
+
+	if (IS_ERR(dev)) {
+		ret =3D PTR_ERR(dev);
+		rdt_last_cmd_printf("Failed to create character device: %d\n",
+				    ret);
+		goto out_debugfs;
+	}
+
+	/* We released the mutex - check if group was removed while we did so */
+	if (rdtgrp->flags & RDT_DELETED) {
+		ret =3D -ENODEV;
+		goto out_device;
+	}
+
+	plr->minor =3D new_minor;
+
+	rdtgrp->mode =3D RDT_MODE_PSEUDO_LOCKED;
+	closid_free(rdtgrp->closid);
+	rdtgroup_kn_mode_restore(rdtgrp, "cpus", 0444);
+	rdtgroup_kn_mode_restore(rdtgrp, "cpus_list", 0444);
+
+	ret =3D 0;
+	goto out;
+
+out_device:
+	device_destroy(&pseudo_lock_class, MKDEV(pseudo_lock_major, new_minor));
+out_debugfs:
+	debugfs_remove_recursive(plr->debugfs_dir);
+	pseudo_lock_minor_release(new_minor);
+out_cstates:
+	pseudo_lock_cstates_relax(plr);
+out_region:
+	pseudo_lock_region_clear(plr);
+out:
+	return ret;
+}
+
+/**
+ * rdtgroup_pseudo_lock_remove - Remove a pseudo-locked region
+ * @rdtgrp: resource group to which the pseudo-locked region belongs
+ *
+ * The removal of a pseudo-locked region can be initiated when the resource
+ * group is removed from user space via a "rmdir" from userspace or the
+ * unmount of the resctrl filesystem. On removal the resource group does
+ * not go back to pseudo-locksetup mode before it is removed, instead it is
+ * removed directly. There is thus asymmetry with the creation where the
+ * &struct pseudo_lock_region is removed here while it was not created in
+ * rdtgroup_pseudo_lock_create().
+ *
+ * Return: void
+ */
+void rdtgroup_pseudo_lock_remove(struct rdtgroup *rdtgrp)
+{
+	struct pseudo_lock_region *plr =3D rdtgrp->plr;
+
+	if (rdtgrp->mode =3D=3D RDT_MODE_PSEUDO_LOCKSETUP) {
+		/*
+		 * Default group cannot be a pseudo-locked region so we can
+		 * free closid here.
+		 */
+		closid_free(rdtgrp->closid);
+		goto free;
+	}
+
+	pseudo_lock_cstates_relax(plr);
+	debugfs_remove_recursive(rdtgrp->plr->debugfs_dir);
+	device_destroy(&pseudo_lock_class, MKDEV(pseudo_lock_major, plr->minor));
+	pseudo_lock_minor_release(plr->minor);
+
+free:
+	pseudo_lock_free(rdtgrp);
+}
+
+static int pseudo_lock_dev_open(struct inode *inode, struct file *filp)
+{
+	struct rdtgroup *rdtgrp;
+
+	mutex_lock(&rdtgroup_mutex);
+
+	rdtgrp =3D region_find_by_minor(iminor(inode));
+	if (!rdtgrp) {
+		mutex_unlock(&rdtgroup_mutex);
+		return -ENODEV;
+	}
+
+	filp->private_data =3D rdtgrp;
+	atomic_inc(&rdtgrp->waitcount);
+	/* Perform a non-seekable open - llseek is not supported */
+	filp->f_mode &=3D ~(FMODE_LSEEK | FMODE_PREAD | FMODE_PWRITE);
+
+	mutex_unlock(&rdtgroup_mutex);
+
+	return 0;
+}
+
+static int pseudo_lock_dev_release(struct inode *inode, struct file *filp)
+{
+	struct rdtgroup *rdtgrp;
+
+	mutex_lock(&rdtgroup_mutex);
+	rdtgrp =3D filp->private_data;
+	WARN_ON(!rdtgrp);
+	if (!rdtgrp) {
+		mutex_unlock(&rdtgroup_mutex);
+		return -ENODEV;
+	}
+	filp->private_data =3D NULL;
+	atomic_dec(&rdtgrp->waitcount);
+	mutex_unlock(&rdtgroup_mutex);
+	return 0;
+}
+
+static int pseudo_lock_dev_mremap(struct vm_area_struct *area)
+{
+	/* Not supported */
+	return -EINVAL;
+}
+
+static const struct vm_operations_struct pseudo_mmap_ops =3D {
+	.mremap =3D pseudo_lock_dev_mremap,
+};
+
+static int pseudo_lock_dev_mmap(struct file *filp, struct vm_area_struct *vm=
a)
+{
+	unsigned long vsize =3D vma->vm_end - vma->vm_start;
+	unsigned long off =3D vma->vm_pgoff << PAGE_SHIFT;
+	struct pseudo_lock_region *plr;
+	struct rdtgroup *rdtgrp;
+	unsigned long physical;
+	unsigned long psize;
+
+	mutex_lock(&rdtgroup_mutex);
+
+	rdtgrp =3D filp->private_data;
+	WARN_ON(!rdtgrp);
+	if (!rdtgrp) {
+		mutex_unlock(&rdtgroup_mutex);
+		return -ENODEV;
+	}
+
+	plr =3D rdtgrp->plr;
+
+	if (!plr->d) {
+		mutex_unlock(&rdtgroup_mutex);
+		return -ENODEV;
+	}
+
+	/*
+	 * Task is required to run with affinity to the cpus associated
+	 * with the pseudo-locked region. If this is not the case the task
+	 * may be scheduled elsewhere and invalidate entries in the
+	 * pseudo-locked region.
+	 */
+	if (!cpumask_subset(current->cpus_ptr, &plr->d->hdr.cpu_mask)) {
+		mutex_unlock(&rdtgroup_mutex);
+		return -EINVAL;
+	}
+
+	physical =3D __pa(plr->kmem) >> PAGE_SHIFT;
+	psize =3D plr->size - off;
+
+	if (off > plr->size) {
+		mutex_unlock(&rdtgroup_mutex);
+		return -ENOSPC;
+	}
+
+	/*
+	 * Ensure changes are carried directly to the memory being mapped,
+	 * do not allow copy-on-write mapping.
+	 */
+	if (!(vma->vm_flags & VM_SHARED)) {
+		mutex_unlock(&rdtgroup_mutex);
+		return -EINVAL;
+	}
+
+	if (vsize > psize) {
+		mutex_unlock(&rdtgroup_mutex);
+		return -ENOSPC;
+	}
+
+	memset(plr->kmem + off, 0, vsize);
+
+	if (remap_pfn_range(vma, vma->vm_start, physical + vma->vm_pgoff,
+			    vsize, vma->vm_page_prot)) {
+		mutex_unlock(&rdtgroup_mutex);
+		return -EAGAIN;
+	}
+	vma->vm_ops =3D &pseudo_mmap_ops;
+	mutex_unlock(&rdtgroup_mutex);
+	return 0;
+}
+
+static const struct file_operations pseudo_lock_dev_fops =3D {
+	.owner =3D	THIS_MODULE,
+	.read =3D		NULL,
+	.write =3D	NULL,
+	.open =3D		pseudo_lock_dev_open,
+	.release =3D	pseudo_lock_dev_release,
+	.mmap =3D		pseudo_lock_dev_mmap,
+};
+
+int rdt_pseudo_lock_init(void)
+{
+	int ret;
+
+	ret =3D register_chrdev(0, "pseudo_lock", &pseudo_lock_dev_fops);
+	if (ret < 0)
+		return ret;
+
+	pseudo_lock_major =3D ret;
+
+	ret =3D class_register(&pseudo_lock_class);
+	if (ret) {
+		unregister_chrdev(pseudo_lock_major, "pseudo_lock");
+		return ret;
+	}
+
+	return 0;
+}
+
+void rdt_pseudo_lock_release(void)
+{
+	class_unregister(&pseudo_lock_class);
+	unregister_chrdev(pseudo_lock_major, "pseudo_lock");
+	pseudo_lock_major =3D 0;
+}
diff --git a/fs/resctrl/pseudo_lock_trace.h b/fs/resctrl/pseudo_lock_trace.h
deleted file mode 100644
index e69de29..0000000
--- a/fs/resctrl/pseudo_lock_trace.h
+++ /dev/null
diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index e69de29..cc37f58 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -0,0 +1,4353 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * User interface for Resource Allocation in Resource Director Technology(RD=
T)
+ *
+ * Copyright (C) 2016 Intel Corporation
+ *
+ * Author: Fenghua Yu <fenghua.yu@intel.com>
+ *
+ * More information about RDT be found in the Intel (R) x86 Architecture
+ * Software Developer Manual.
+ */
+
+#define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
+
+#include <linux/cpu.h>
+#include <linux/debugfs.h>
+#include <linux/fs.h>
+#include <linux/fs_parser.h>
+#include <linux/sysfs.h>
+#include <linux/kernfs.h>
+#include <linux/resctrl.h>
+#include <linux/seq_buf.h>
+#include <linux/seq_file.h>
+#include <linux/sched/task.h>
+#include <linux/slab.h>
+#include <linux/user_namespace.h>
+
+#include <uapi/linux/magic.h>
+
+#include "internal.h"
+
+/* Mutex to protect rdtgroup access. */
+DEFINE_MUTEX(rdtgroup_mutex);
+
+static struct kernfs_root *rdt_root;
+
+struct rdtgroup rdtgroup_default;
+
+LIST_HEAD(rdt_all_groups);
+
+/* list of entries for the schemata file */
+LIST_HEAD(resctrl_schema_all);
+
+/*
+ * List of struct mon_data containing private data of event files for use by
+ * rdtgroup_mondata_show(). Protected by rdtgroup_mutex.
+ */
+static LIST_HEAD(mon_data_kn_priv_list);
+
+/* The filesystem can only be mounted once. */
+bool resctrl_mounted;
+
+/* Kernel fs node for "info" directory under root */
+static struct kernfs_node *kn_info;
+
+/* Kernel fs node for "mon_groups" directory under root */
+static struct kernfs_node *kn_mongrp;
+
+/* Kernel fs node for "mon_data" directory under root */
+static struct kernfs_node *kn_mondata;
+
+/*
+ * Used to store the max resource name width to display the schemata names in
+ * a tabular format.
+ */
+int max_name_width;
+
+static struct seq_buf last_cmd_status;
+
+static char last_cmd_status_buf[512];
+
+static int rdtgroup_setup_root(struct rdt_fs_context *ctx);
+
+static void rdtgroup_destroy_root(void);
+
+struct dentry *debugfs_resctrl;
+
+/*
+ * Memory bandwidth monitoring event to use for the default CTRL_MON group
+ * and each new CTRL_MON group created by the user.  Only relevant when
+ * the filesystem is mounted with the "mba_MBps" option so it does not
+ * matter that it remains uninitialized on systems that do not support
+ * the "mba_MBps" option.
+ */
+enum resctrl_event_id mba_mbps_default_event;
+
+static bool resctrl_debug;
+
+void rdt_last_cmd_clear(void)
+{
+	lockdep_assert_held(&rdtgroup_mutex);
+	seq_buf_clear(&last_cmd_status);
+}
+
+void rdt_last_cmd_puts(const char *s)
+{
+	lockdep_assert_held(&rdtgroup_mutex);
+	seq_buf_puts(&last_cmd_status, s);
+}
+
+void rdt_last_cmd_printf(const char *fmt, ...)
+{
+	va_list ap;
+
+	va_start(ap, fmt);
+	lockdep_assert_held(&rdtgroup_mutex);
+	seq_buf_vprintf(&last_cmd_status, fmt, ap);
+	va_end(ap);
+}
+
+void rdt_staged_configs_clear(void)
+{
+	struct rdt_ctrl_domain *dom;
+	struct rdt_resource *r;
+
+	lockdep_assert_held(&rdtgroup_mutex);
+
+	for_each_alloc_capable_rdt_resource(r) {
+		list_for_each_entry(dom, &r->ctrl_domains, hdr.list)
+			memset(dom->staged_config, 0, sizeof(dom->staged_config));
+	}
+}
+
+static bool resctrl_is_mbm_enabled(void)
+{
+	return (resctrl_arch_is_mbm_total_enabled() ||
+		resctrl_arch_is_mbm_local_enabled());
+}
+
+static bool resctrl_is_mbm_event(int e)
+{
+	return (e >=3D QOS_L3_MBM_TOTAL_EVENT_ID &&
+		e <=3D QOS_L3_MBM_LOCAL_EVENT_ID);
+}
+
+/*
+ * Trivial allocator for CLOSIDs. Use BITMAP APIs to manipulate a bitmap
+ * of free CLOSIDs.
+ *
+ * Using a global CLOSID across all resources has some advantages and
+ * some drawbacks:
+ * + We can simply set current's closid to assign a task to a resource
+ *   group.
+ * + Context switch code can avoid extra memory references deciding which
+ *   CLOSID to load into the PQR_ASSOC MSR
+ * - We give up some options in configuring resource groups across multi-soc=
ket
+ *   systems.
+ * - Our choices on how to configure each resource become progressively more
+ *   limited as the number of resources grows.
+ */
+static unsigned long *closid_free_map;
+
+static int closid_free_map_len;
+
+int closids_supported(void)
+{
+	return closid_free_map_len;
+}
+
+static int closid_init(void)
+{
+	struct resctrl_schema *s;
+	u32 rdt_min_closid =3D ~0;
+
+	/* Monitor only platforms still call closid_init() */
+	if (list_empty(&resctrl_schema_all))
+		return 0;
+
+	/* Compute rdt_min_closid across all resources */
+	list_for_each_entry(s, &resctrl_schema_all, list)
+		rdt_min_closid =3D min(rdt_min_closid, s->num_closid);
+
+	closid_free_map =3D bitmap_alloc(rdt_min_closid, GFP_KERNEL);
+	if (!closid_free_map)
+		return -ENOMEM;
+	bitmap_fill(closid_free_map, rdt_min_closid);
+
+	/* RESCTRL_RESERVED_CLOSID is always reserved for the default group */
+	__clear_bit(RESCTRL_RESERVED_CLOSID, closid_free_map);
+	closid_free_map_len =3D rdt_min_closid;
+
+	return 0;
+}
+
+static void closid_exit(void)
+{
+	bitmap_free(closid_free_map);
+	closid_free_map =3D NULL;
+}
+
+static int closid_alloc(void)
+{
+	int cleanest_closid;
+	u32 closid;
+
+	lockdep_assert_held(&rdtgroup_mutex);
+
+	if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID) &&
+	    resctrl_arch_is_llc_occupancy_enabled()) {
+		cleanest_closid =3D resctrl_find_cleanest_closid();
+		if (cleanest_closid < 0)
+			return cleanest_closid;
+		closid =3D cleanest_closid;
+	} else {
+		closid =3D find_first_bit(closid_free_map, closid_free_map_len);
+		if (closid =3D=3D closid_free_map_len)
+			return -ENOSPC;
+	}
+	__clear_bit(closid, closid_free_map);
+
+	return closid;
+}
+
+void closid_free(int closid)
+{
+	lockdep_assert_held(&rdtgroup_mutex);
+
+	__set_bit(closid, closid_free_map);
+}
+
+/**
+ * closid_allocated - test if provided closid is in use
+ * @closid: closid to be tested
+ *
+ * Return: true if @closid is currently associated with a resource group,
+ * false if @closid is free
+ */
+bool closid_allocated(unsigned int closid)
+{
+	lockdep_assert_held(&rdtgroup_mutex);
+
+	return !test_bit(closid, closid_free_map);
+}
+
+/**
+ * rdtgroup_mode_by_closid - Return mode of resource group with closid
+ * @closid: closid if the resource group
+ *
+ * Each resource group is associated with a @closid. Here the mode
+ * of a resource group can be queried by searching for it using its closid.
+ *
+ * Return: mode as &enum rdtgrp_mode of resource group with closid @closid
+ */
+enum rdtgrp_mode rdtgroup_mode_by_closid(int closid)
+{
+	struct rdtgroup *rdtgrp;
+
+	list_for_each_entry(rdtgrp, &rdt_all_groups, rdtgroup_list) {
+		if (rdtgrp->closid =3D=3D closid)
+			return rdtgrp->mode;
+	}
+
+	return RDT_NUM_MODES;
+}
+
+static const char * const rdt_mode_str[] =3D {
+	[RDT_MODE_SHAREABLE]		=3D "shareable",
+	[RDT_MODE_EXCLUSIVE]		=3D "exclusive",
+	[RDT_MODE_PSEUDO_LOCKSETUP]	=3D "pseudo-locksetup",
+	[RDT_MODE_PSEUDO_LOCKED]	=3D "pseudo-locked",
+};
+
+/**
+ * rdtgroup_mode_str - Return the string representation of mode
+ * @mode: the resource group mode as &enum rdtgroup_mode
+ *
+ * Return: string representation of valid mode, "unknown" otherwise
+ */
+static const char *rdtgroup_mode_str(enum rdtgrp_mode mode)
+{
+	if (mode < RDT_MODE_SHAREABLE || mode >=3D RDT_NUM_MODES)
+		return "unknown";
+
+	return rdt_mode_str[mode];
+}
+
+/* set uid and gid of rdtgroup dirs and files to that of the creator */
+static int rdtgroup_kn_set_ugid(struct kernfs_node *kn)
+{
+	struct iattr iattr =3D { .ia_valid =3D ATTR_UID | ATTR_GID,
+				.ia_uid =3D current_fsuid(),
+				.ia_gid =3D current_fsgid(), };
+
+	if (uid_eq(iattr.ia_uid, GLOBAL_ROOT_UID) &&
+	    gid_eq(iattr.ia_gid, GLOBAL_ROOT_GID))
+		return 0;
+
+	return kernfs_setattr(kn, &iattr);
+}
+
+static int rdtgroup_add_file(struct kernfs_node *parent_kn, struct rftype *r=
ft)
+{
+	struct kernfs_node *kn;
+	int ret;
+
+	kn =3D __kernfs_create_file(parent_kn, rft->name, rft->mode,
+				  GLOBAL_ROOT_UID, GLOBAL_ROOT_GID,
+				  0, rft->kf_ops, rft, NULL, NULL);
+	if (IS_ERR(kn))
+		return PTR_ERR(kn);
+
+	ret =3D rdtgroup_kn_set_ugid(kn);
+	if (ret) {
+		kernfs_remove(kn);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int rdtgroup_seqfile_show(struct seq_file *m, void *arg)
+{
+	struct kernfs_open_file *of =3D m->private;
+	struct rftype *rft =3D of->kn->priv;
+
+	if (rft->seq_show)
+		return rft->seq_show(of, m, arg);
+	return 0;
+}
+
+static ssize_t rdtgroup_file_write(struct kernfs_open_file *of, char *buf,
+				   size_t nbytes, loff_t off)
+{
+	struct rftype *rft =3D of->kn->priv;
+
+	if (rft->write)
+		return rft->write(of, buf, nbytes, off);
+
+	return -EINVAL;
+}
+
+static const struct kernfs_ops rdtgroup_kf_single_ops =3D {
+	.atomic_write_len	=3D PAGE_SIZE,
+	.write			=3D rdtgroup_file_write,
+	.seq_show		=3D rdtgroup_seqfile_show,
+};
+
+static const struct kernfs_ops kf_mondata_ops =3D {
+	.atomic_write_len	=3D PAGE_SIZE,
+	.seq_show		=3D rdtgroup_mondata_show,
+};
+
+static bool is_cpu_list(struct kernfs_open_file *of)
+{
+	struct rftype *rft =3D of->kn->priv;
+
+	return rft->flags & RFTYPE_FLAGS_CPUS_LIST;
+}
+
+static int rdtgroup_cpus_show(struct kernfs_open_file *of,
+			      struct seq_file *s, void *v)
+{
+	struct rdtgroup *rdtgrp;
+	struct cpumask *mask;
+	int ret =3D 0;
+
+	rdtgrp =3D rdtgroup_kn_lock_live(of->kn);
+
+	if (rdtgrp) {
+		if (rdtgrp->mode =3D=3D RDT_MODE_PSEUDO_LOCKED) {
+			if (!rdtgrp->plr->d) {
+				rdt_last_cmd_clear();
+				rdt_last_cmd_puts("Cache domain offline\n");
+				ret =3D -ENODEV;
+			} else {
+				mask =3D &rdtgrp->plr->d->hdr.cpu_mask;
+				seq_printf(s, is_cpu_list(of) ?
+					   "%*pbl\n" : "%*pb\n",
+					   cpumask_pr_args(mask));
+			}
+		} else {
+			seq_printf(s, is_cpu_list(of) ? "%*pbl\n" : "%*pb\n",
+				   cpumask_pr_args(&rdtgrp->cpu_mask));
+		}
+	} else {
+		ret =3D -ENOENT;
+	}
+	rdtgroup_kn_unlock(of->kn);
+
+	return ret;
+}
+
+/*
+ * Update the PGR_ASSOC MSR on all cpus in @cpu_mask,
+ *
+ * Per task closids/rmids must have been set up before calling this function.
+ * @r may be NULL.
+ */
+static void
+update_closid_rmid(const struct cpumask *cpu_mask, struct rdtgroup *r)
+{
+	struct resctrl_cpu_defaults defaults, *p =3D NULL;
+
+	if (r) {
+		defaults.closid =3D r->closid;
+		defaults.rmid =3D r->mon.rmid;
+		p =3D &defaults;
+	}
+
+	on_each_cpu_mask(cpu_mask, resctrl_arch_sync_cpu_closid_rmid, p, 1);
+}
+
+static int cpus_mon_write(struct rdtgroup *rdtgrp, cpumask_var_t newmask,
+			  cpumask_var_t tmpmask)
+{
+	struct rdtgroup *prgrp =3D rdtgrp->mon.parent, *crgrp;
+	struct list_head *head;
+
+	/* Check whether cpus belong to parent ctrl group */
+	cpumask_andnot(tmpmask, newmask, &prgrp->cpu_mask);
+	if (!cpumask_empty(tmpmask)) {
+		rdt_last_cmd_puts("Can only add CPUs to mongroup that belong to parent\n");
+		return -EINVAL;
+	}
+
+	/* Check whether cpus are dropped from this group */
+	cpumask_andnot(tmpmask, &rdtgrp->cpu_mask, newmask);
+	if (!cpumask_empty(tmpmask)) {
+		/* Give any dropped cpus to parent rdtgroup */
+		cpumask_or(&prgrp->cpu_mask, &prgrp->cpu_mask, tmpmask);
+		update_closid_rmid(tmpmask, prgrp);
+	}
+
+	/*
+	 * If we added cpus, remove them from previous group that owned them
+	 * and update per-cpu rmid
+	 */
+	cpumask_andnot(tmpmask, newmask, &rdtgrp->cpu_mask);
+	if (!cpumask_empty(tmpmask)) {
+		head =3D &prgrp->mon.crdtgrp_list;
+		list_for_each_entry(crgrp, head, mon.crdtgrp_list) {
+			if (crgrp =3D=3D rdtgrp)
+				continue;
+			cpumask_andnot(&crgrp->cpu_mask, &crgrp->cpu_mask,
+				       tmpmask);
+		}
+		update_closid_rmid(tmpmask, rdtgrp);
+	}
+
+	/* Done pushing/pulling - update this group with new mask */
+	cpumask_copy(&rdtgrp->cpu_mask, newmask);
+
+	return 0;
+}
+
+static void cpumask_rdtgrp_clear(struct rdtgroup *r, struct cpumask *m)
+{
+	struct rdtgroup *crgrp;
+
+	cpumask_andnot(&r->cpu_mask, &r->cpu_mask, m);
+	/* update the child mon group masks as well*/
+	list_for_each_entry(crgrp, &r->mon.crdtgrp_list, mon.crdtgrp_list)
+		cpumask_and(&crgrp->cpu_mask, &r->cpu_mask, &crgrp->cpu_mask);
+}
+
+static int cpus_ctrl_write(struct rdtgroup *rdtgrp, cpumask_var_t newmask,
+			   cpumask_var_t tmpmask, cpumask_var_t tmpmask1)
+{
+	struct rdtgroup *r, *crgrp;
+	struct list_head *head;
+
+	/* Check whether cpus are dropped from this group */
+	cpumask_andnot(tmpmask, &rdtgrp->cpu_mask, newmask);
+	if (!cpumask_empty(tmpmask)) {
+		/* Can't drop from default group */
+		if (rdtgrp =3D=3D &rdtgroup_default) {
+			rdt_last_cmd_puts("Can't drop CPUs from default group\n");
+			return -EINVAL;
+		}
+
+		/* Give any dropped cpus to rdtgroup_default */
+		cpumask_or(&rdtgroup_default.cpu_mask,
+			   &rdtgroup_default.cpu_mask, tmpmask);
+		update_closid_rmid(tmpmask, &rdtgroup_default);
+	}
+
+	/*
+	 * If we added cpus, remove them from previous group and
+	 * the prev group's child groups that owned them
+	 * and update per-cpu closid/rmid.
+	 */
+	cpumask_andnot(tmpmask, newmask, &rdtgrp->cpu_mask);
+	if (!cpumask_empty(tmpmask)) {
+		list_for_each_entry(r, &rdt_all_groups, rdtgroup_list) {
+			if (r =3D=3D rdtgrp)
+				continue;
+			cpumask_and(tmpmask1, &r->cpu_mask, tmpmask);
+			if (!cpumask_empty(tmpmask1))
+				cpumask_rdtgrp_clear(r, tmpmask1);
+		}
+		update_closid_rmid(tmpmask, rdtgrp);
+	}
+
+	/* Done pushing/pulling - update this group with new mask */
+	cpumask_copy(&rdtgrp->cpu_mask, newmask);
+
+	/*
+	 * Clear child mon group masks since there is a new parent mask
+	 * now and update the rmid for the cpus the child lost.
+	 */
+	head =3D &rdtgrp->mon.crdtgrp_list;
+	list_for_each_entry(crgrp, head, mon.crdtgrp_list) {
+		cpumask_and(tmpmask, &rdtgrp->cpu_mask, &crgrp->cpu_mask);
+		update_closid_rmid(tmpmask, rdtgrp);
+		cpumask_clear(&crgrp->cpu_mask);
+	}
+
+	return 0;
+}
+
+static ssize_t rdtgroup_cpus_write(struct kernfs_open_file *of,
+				   char *buf, size_t nbytes, loff_t off)
+{
+	cpumask_var_t tmpmask, newmask, tmpmask1;
+	struct rdtgroup *rdtgrp;
+	int ret;
+
+	if (!buf)
+		return -EINVAL;
+
+	if (!zalloc_cpumask_var(&tmpmask, GFP_KERNEL))
+		return -ENOMEM;
+	if (!zalloc_cpumask_var(&newmask, GFP_KERNEL)) {
+		free_cpumask_var(tmpmask);
+		return -ENOMEM;
+	}
+	if (!zalloc_cpumask_var(&tmpmask1, GFP_KERNEL)) {
+		free_cpumask_var(tmpmask);
+		free_cpumask_var(newmask);
+		return -ENOMEM;
+	}
+
+	rdtgrp =3D rdtgroup_kn_lock_live(of->kn);
+	if (!rdtgrp) {
+		ret =3D -ENOENT;
+		goto unlock;
+	}
+
+	if (rdtgrp->mode =3D=3D RDT_MODE_PSEUDO_LOCKED ||
+	    rdtgrp->mode =3D=3D RDT_MODE_PSEUDO_LOCKSETUP) {
+		ret =3D -EINVAL;
+		rdt_last_cmd_puts("Pseudo-locking in progress\n");
+		goto unlock;
+	}
+
+	if (is_cpu_list(of))
+		ret =3D cpulist_parse(buf, newmask);
+	else
+		ret =3D cpumask_parse(buf, newmask);
+
+	if (ret) {
+		rdt_last_cmd_puts("Bad CPU list/mask\n");
+		goto unlock;
+	}
+
+	/* check that user didn't specify any offline cpus */
+	cpumask_andnot(tmpmask, newmask, cpu_online_mask);
+	if (!cpumask_empty(tmpmask)) {
+		ret =3D -EINVAL;
+		rdt_last_cmd_puts("Can only assign online CPUs\n");
+		goto unlock;
+	}
+
+	if (rdtgrp->type =3D=3D RDTCTRL_GROUP)
+		ret =3D cpus_ctrl_write(rdtgrp, newmask, tmpmask, tmpmask1);
+	else if (rdtgrp->type =3D=3D RDTMON_GROUP)
+		ret =3D cpus_mon_write(rdtgrp, newmask, tmpmask);
+	else
+		ret =3D -EINVAL;
+
+unlock:
+	rdtgroup_kn_unlock(of->kn);
+	free_cpumask_var(tmpmask);
+	free_cpumask_var(newmask);
+	free_cpumask_var(tmpmask1);
+
+	return ret ?: nbytes;
+}
+
+/**
+ * rdtgroup_remove - the helper to remove resource group safely
+ * @rdtgrp: resource group to remove
+ *
+ * On resource group creation via a mkdir, an extra kernfs_node reference is
+ * taken to ensure that the rdtgroup structure remains accessible for the
+ * rdtgroup_kn_unlock() calls where it is removed.
+ *
+ * Drop the extra reference here, then free the rdtgroup structure.
+ *
+ * Return: void
+ */
+static void rdtgroup_remove(struct rdtgroup *rdtgrp)
+{
+	kernfs_put(rdtgrp->kn);
+	kfree(rdtgrp);
+}
+
+static void _update_task_closid_rmid(void *task)
+{
+	/*
+	 * If the task is still current on this CPU, update PQR_ASSOC MSR.
+	 * Otherwise, the MSR is updated when the task is scheduled in.
+	 */
+	if (task =3D=3D current)
+		resctrl_arch_sched_in(task);
+}
+
+static void update_task_closid_rmid(struct task_struct *t)
+{
+	if (IS_ENABLED(CONFIG_SMP) && task_curr(t))
+		smp_call_function_single(task_cpu(t), _update_task_closid_rmid, t, 1);
+	else
+		_update_task_closid_rmid(t);
+}
+
+static bool task_in_rdtgroup(struct task_struct *tsk, struct rdtgroup *rdtgr=
p)
+{
+	u32 closid, rmid =3D rdtgrp->mon.rmid;
+
+	if (rdtgrp->type =3D=3D RDTCTRL_GROUP)
+		closid =3D rdtgrp->closid;
+	else if (rdtgrp->type =3D=3D RDTMON_GROUP)
+		closid =3D rdtgrp->mon.parent->closid;
+	else
+		return false;
+
+	return resctrl_arch_match_closid(tsk, closid) &&
+	       resctrl_arch_match_rmid(tsk, closid, rmid);
+}
+
+static int __rdtgroup_move_task(struct task_struct *tsk,
+				struct rdtgroup *rdtgrp)
+{
+	/* If the task is already in rdtgrp, no need to move the task. */
+	if (task_in_rdtgroup(tsk, rdtgrp))
+		return 0;
+
+	/*
+	 * Set the task's closid/rmid before the PQR_ASSOC MSR can be
+	 * updated by them.
+	 *
+	 * For ctrl_mon groups, move both closid and rmid.
+	 * For monitor groups, can move the tasks only from
+	 * their parent CTRL group.
+	 */
+	if (rdtgrp->type =3D=3D RDTMON_GROUP &&
+	    !resctrl_arch_match_closid(tsk, rdtgrp->mon.parent->closid)) {
+		rdt_last_cmd_puts("Can't move task to different control group\n");
+		return -EINVAL;
+	}
+
+	if (rdtgrp->type =3D=3D RDTMON_GROUP)
+		resctrl_arch_set_closid_rmid(tsk, rdtgrp->mon.parent->closid,
+					     rdtgrp->mon.rmid);
+	else
+		resctrl_arch_set_closid_rmid(tsk, rdtgrp->closid,
+					     rdtgrp->mon.rmid);
+
+	/*
+	 * Ensure the task's closid and rmid are written before determining if
+	 * the task is current that will decide if it will be interrupted.
+	 * This pairs with the full barrier between the rq->curr update and
+	 * resctrl_arch_sched_in() during context switch.
+	 */
+	smp_mb();
+
+	/*
+	 * By now, the task's closid and rmid are set. If the task is current
+	 * on a CPU, the PQR_ASSOC MSR needs to be updated to make the resource
+	 * group go into effect. If the task is not current, the MSR will be
+	 * updated when the task is scheduled in.
+	 */
+	update_task_closid_rmid(tsk);
+
+	return 0;
+}
+
+static bool is_closid_match(struct task_struct *t, struct rdtgroup *r)
+{
+	return (resctrl_arch_alloc_capable() && (r->type =3D=3D RDTCTRL_GROUP) &&
+		resctrl_arch_match_closid(t, r->closid));
+}
+
+static bool is_rmid_match(struct task_struct *t, struct rdtgroup *r)
+{
+	return (resctrl_arch_mon_capable() && (r->type =3D=3D RDTMON_GROUP) &&
+		resctrl_arch_match_rmid(t, r->mon.parent->closid,
+					r->mon.rmid));
+}
+
+/**
+ * rdtgroup_tasks_assigned - Test if tasks have been assigned to resource gr=
oup
+ * @r: Resource group
+ *
+ * Return: 1 if tasks have been assigned to @r, 0 otherwise
+ */
+int rdtgroup_tasks_assigned(struct rdtgroup *r)
+{
+	struct task_struct *p, *t;
+	int ret =3D 0;
+
+	lockdep_assert_held(&rdtgroup_mutex);
+
+	rcu_read_lock();
+	for_each_process_thread(p, t) {
+		if (is_closid_match(t, r) || is_rmid_match(t, r)) {
+			ret =3D 1;
+			break;
+		}
+	}
+	rcu_read_unlock();
+
+	return ret;
+}
+
+static int rdtgroup_task_write_permission(struct task_struct *task,
+					  struct kernfs_open_file *of)
+{
+	const struct cred *tcred =3D get_task_cred(task);
+	const struct cred *cred =3D current_cred();
+	int ret =3D 0;
+
+	/*
+	 * Even if we're attaching all tasks in the thread group, we only
+	 * need to check permissions on one of them.
+	 */
+	if (!uid_eq(cred->euid, GLOBAL_ROOT_UID) &&
+	    !uid_eq(cred->euid, tcred->uid) &&
+	    !uid_eq(cred->euid, tcred->suid)) {
+		rdt_last_cmd_printf("No permission to move task %d\n", task->pid);
+		ret =3D -EPERM;
+	}
+
+	put_cred(tcred);
+	return ret;
+}
+
+static int rdtgroup_move_task(pid_t pid, struct rdtgroup *rdtgrp,
+			      struct kernfs_open_file *of)
+{
+	struct task_struct *tsk;
+	int ret;
+
+	rcu_read_lock();
+	if (pid) {
+		tsk =3D find_task_by_vpid(pid);
+		if (!tsk) {
+			rcu_read_unlock();
+			rdt_last_cmd_printf("No task %d\n", pid);
+			return -ESRCH;
+		}
+	} else {
+		tsk =3D current;
+	}
+
+	get_task_struct(tsk);
+	rcu_read_unlock();
+
+	ret =3D rdtgroup_task_write_permission(tsk, of);
+	if (!ret)
+		ret =3D __rdtgroup_move_task(tsk, rdtgrp);
+
+	put_task_struct(tsk);
+	return ret;
+}
+
+static ssize_t rdtgroup_tasks_write(struct kernfs_open_file *of,
+				    char *buf, size_t nbytes, loff_t off)
+{
+	struct rdtgroup *rdtgrp;
+	char *pid_str;
+	int ret =3D 0;
+	pid_t pid;
+
+	rdtgrp =3D rdtgroup_kn_lock_live(of->kn);
+	if (!rdtgrp) {
+		rdtgroup_kn_unlock(of->kn);
+		return -ENOENT;
+	}
+	rdt_last_cmd_clear();
+
+	if (rdtgrp->mode =3D=3D RDT_MODE_PSEUDO_LOCKED ||
+	    rdtgrp->mode =3D=3D RDT_MODE_PSEUDO_LOCKSETUP) {
+		ret =3D -EINVAL;
+		rdt_last_cmd_puts("Pseudo-locking in progress\n");
+		goto unlock;
+	}
+
+	while (buf && buf[0] !=3D '\0' && buf[0] !=3D '\n') {
+		pid_str =3D strim(strsep(&buf, ","));
+
+		if (kstrtoint(pid_str, 0, &pid)) {
+			rdt_last_cmd_printf("Task list parsing error pid %s\n", pid_str);
+			ret =3D -EINVAL;
+			break;
+		}
+
+		if (pid < 0) {
+			rdt_last_cmd_printf("Invalid pid %d\n", pid);
+			ret =3D -EINVAL;
+			break;
+		}
+
+		ret =3D rdtgroup_move_task(pid, rdtgrp, of);
+		if (ret) {
+			rdt_last_cmd_printf("Error while processing task %d\n", pid);
+			break;
+		}
+	}
+
+unlock:
+	rdtgroup_kn_unlock(of->kn);
+
+	return ret ?: nbytes;
+}
+
+static void show_rdt_tasks(struct rdtgroup *r, struct seq_file *s)
+{
+	struct task_struct *p, *t;
+	pid_t pid;
+
+	rcu_read_lock();
+	for_each_process_thread(p, t) {
+		if (is_closid_match(t, r) || is_rmid_match(t, r)) {
+			pid =3D task_pid_vnr(t);
+			if (pid)
+				seq_printf(s, "%d\n", pid);
+		}
+	}
+	rcu_read_unlock();
+}
+
+static int rdtgroup_tasks_show(struct kernfs_open_file *of,
+			       struct seq_file *s, void *v)
+{
+	struct rdtgroup *rdtgrp;
+	int ret =3D 0;
+
+	rdtgrp =3D rdtgroup_kn_lock_live(of->kn);
+	if (rdtgrp)
+		show_rdt_tasks(rdtgrp, s);
+	else
+		ret =3D -ENOENT;
+	rdtgroup_kn_unlock(of->kn);
+
+	return ret;
+}
+
+static int rdtgroup_closid_show(struct kernfs_open_file *of,
+				struct seq_file *s, void *v)
+{
+	struct rdtgroup *rdtgrp;
+	int ret =3D 0;
+
+	rdtgrp =3D rdtgroup_kn_lock_live(of->kn);
+	if (rdtgrp)
+		seq_printf(s, "%u\n", rdtgrp->closid);
+	else
+		ret =3D -ENOENT;
+	rdtgroup_kn_unlock(of->kn);
+
+	return ret;
+}
+
+static int rdtgroup_rmid_show(struct kernfs_open_file *of,
+			      struct seq_file *s, void *v)
+{
+	struct rdtgroup *rdtgrp;
+	int ret =3D 0;
+
+	rdtgrp =3D rdtgroup_kn_lock_live(of->kn);
+	if (rdtgrp)
+		seq_printf(s, "%u\n", rdtgrp->mon.rmid);
+	else
+		ret =3D -ENOENT;
+	rdtgroup_kn_unlock(of->kn);
+
+	return ret;
+}
+
+#ifdef CONFIG_PROC_CPU_RESCTRL
+/*
+ * A task can only be part of one resctrl control group and of one monitor
+ * group which is associated to that control group.
+ *
+ * 1)   res:
+ *      mon:
+ *
+ *    resctrl is not available.
+ *
+ * 2)   res:/
+ *      mon:
+ *
+ *    Task is part of the root resctrl control group, and it is not associat=
ed
+ *    to any monitor group.
+ *
+ * 3)  res:/
+ *     mon:mon0
+ *
+ *    Task is part of the root resctrl control group and monitor group mon0.
+ *
+ * 4)  res:group0
+ *     mon:
+ *
+ *    Task is part of resctrl control group group0, and it is not associated
+ *    to any monitor group.
+ *
+ * 5) res:group0
+ *    mon:mon1
+ *
+ *    Task is part of resctrl control group group0 and monitor group mon1.
+ */
+int proc_resctrl_show(struct seq_file *s, struct pid_namespace *ns,
+		      struct pid *pid, struct task_struct *tsk)
+{
+	struct rdtgroup *rdtg;
+	int ret =3D 0;
+
+	mutex_lock(&rdtgroup_mutex);
+
+	/* Return empty if resctrl has not been mounted. */
+	if (!resctrl_mounted) {
+		seq_puts(s, "res:\nmon:\n");
+		goto unlock;
+	}
+
+	list_for_each_entry(rdtg, &rdt_all_groups, rdtgroup_list) {
+		struct rdtgroup *crg;
+
+		/*
+		 * Task information is only relevant for shareable
+		 * and exclusive groups.
+		 */
+		if (rdtg->mode !=3D RDT_MODE_SHAREABLE &&
+		    rdtg->mode !=3D RDT_MODE_EXCLUSIVE)
+			continue;
+
+		if (!resctrl_arch_match_closid(tsk, rdtg->closid))
+			continue;
+
+		seq_printf(s, "res:%s%s\n", (rdtg =3D=3D &rdtgroup_default) ? "/" : "",
+			   rdt_kn_name(rdtg->kn));
+		seq_puts(s, "mon:");
+		list_for_each_entry(crg, &rdtg->mon.crdtgrp_list,
+				    mon.crdtgrp_list) {
+			if (!resctrl_arch_match_rmid(tsk, crg->mon.parent->closid,
+						     crg->mon.rmid))
+				continue;
+			seq_printf(s, "%s", rdt_kn_name(crg->kn));
+			break;
+		}
+		seq_putc(s, '\n');
+		goto unlock;
+	}
+	/*
+	 * The above search should succeed. Otherwise return
+	 * with an error.
+	 */
+	ret =3D -ENOENT;
+unlock:
+	mutex_unlock(&rdtgroup_mutex);
+
+	return ret;
+}
+#endif
+
+static int rdt_last_cmd_status_show(struct kernfs_open_file *of,
+				    struct seq_file *seq, void *v)
+{
+	int len;
+
+	mutex_lock(&rdtgroup_mutex);
+	len =3D seq_buf_used(&last_cmd_status);
+	if (len)
+		seq_printf(seq, "%.*s", len, last_cmd_status_buf);
+	else
+		seq_puts(seq, "ok\n");
+	mutex_unlock(&rdtgroup_mutex);
+	return 0;
+}
+
+static void *rdt_kn_parent_priv(struct kernfs_node *kn)
+{
+	/*
+	 * The parent pointer is only valid within RCU section since it can be
+	 * replaced.
+	 */
+	guard(rcu)();
+	return rcu_dereference(kn->__parent)->priv;
+}
+
+static int rdt_num_closids_show(struct kernfs_open_file *of,
+				struct seq_file *seq, void *v)
+{
+	struct resctrl_schema *s =3D rdt_kn_parent_priv(of->kn);
+
+	seq_printf(seq, "%u\n", s->num_closid);
+	return 0;
+}
+
+static int rdt_default_ctrl_show(struct kernfs_open_file *of,
+				 struct seq_file *seq, void *v)
+{
+	struct resctrl_schema *s =3D rdt_kn_parent_priv(of->kn);
+	struct rdt_resource *r =3D s->res;
+
+	seq_printf(seq, "%x\n", resctrl_get_default_ctrl(r));
+	return 0;
+}
+
+static int rdt_min_cbm_bits_show(struct kernfs_open_file *of,
+				 struct seq_file *seq, void *v)
+{
+	struct resctrl_schema *s =3D rdt_kn_parent_priv(of->kn);
+	struct rdt_resource *r =3D s->res;
+
+	seq_printf(seq, "%u\n", r->cache.min_cbm_bits);
+	return 0;
+}
+
+static int rdt_shareable_bits_show(struct kernfs_open_file *of,
+				   struct seq_file *seq, void *v)
+{
+	struct resctrl_schema *s =3D rdt_kn_parent_priv(of->kn);
+	struct rdt_resource *r =3D s->res;
+
+	seq_printf(seq, "%x\n", r->cache.shareable_bits);
+	return 0;
+}
+
+/*
+ * rdt_bit_usage_show - Display current usage of resources
+ *
+ * A domain is a shared resource that can now be allocated differently. Here
+ * we display the current regions of the domain as an annotated bitmask.
+ * For each domain of this resource its allocation bitmask
+ * is annotated as below to indicate the current usage of the corresponding =
bit:
+ *   0 - currently unused
+ *   X - currently available for sharing and used by software and hardware
+ *   H - currently used by hardware only but available for software use
+ *   S - currently used and shareable by software only
+ *   E - currently used exclusively by one resource group
+ *   P - currently pseudo-locked by one resource group
+ */
+static int rdt_bit_usage_show(struct kernfs_open_file *of,
+			      struct seq_file *seq, void *v)
+{
+	struct resctrl_schema *s =3D rdt_kn_parent_priv(of->kn);
+	/*
+	 * Use unsigned long even though only 32 bits are used to ensure
+	 * test_bit() is used safely.
+	 */
+	unsigned long sw_shareable =3D 0, hw_shareable =3D 0;
+	unsigned long exclusive =3D 0, pseudo_locked =3D 0;
+	struct rdt_resource *r =3D s->res;
+	struct rdt_ctrl_domain *dom;
+	int i, hwb, swb, excl, psl;
+	enum rdtgrp_mode mode;
+	bool sep =3D false;
+	u32 ctrl_val;
+
+	cpus_read_lock();
+	mutex_lock(&rdtgroup_mutex);
+	hw_shareable =3D r->cache.shareable_bits;
+	list_for_each_entry(dom, &r->ctrl_domains, hdr.list) {
+		if (sep)
+			seq_putc(seq, ';');
+		sw_shareable =3D 0;
+		exclusive =3D 0;
+		seq_printf(seq, "%d=3D", dom->hdr.id);
+		for (i =3D 0; i < closids_supported(); i++) {
+			if (!closid_allocated(i))
+				continue;
+			ctrl_val =3D resctrl_arch_get_config(r, dom, i,
+							   s->conf_type);
+			mode =3D rdtgroup_mode_by_closid(i);
+			switch (mode) {
+			case RDT_MODE_SHAREABLE:
+				sw_shareable |=3D ctrl_val;
+				break;
+			case RDT_MODE_EXCLUSIVE:
+				exclusive |=3D ctrl_val;
+				break;
+			case RDT_MODE_PSEUDO_LOCKSETUP:
+			/*
+			 * RDT_MODE_PSEUDO_LOCKSETUP is possible
+			 * here but not included since the CBM
+			 * associated with this CLOSID in this mode
+			 * is not initialized and no task or cpu can be
+			 * assigned this CLOSID.
+			 */
+				break;
+			case RDT_MODE_PSEUDO_LOCKED:
+			case RDT_NUM_MODES:
+				WARN(1,
+				     "invalid mode for closid %d\n", i);
+				break;
+			}
+		}
+		for (i =3D r->cache.cbm_len - 1; i >=3D 0; i--) {
+			pseudo_locked =3D dom->plr ? dom->plr->cbm : 0;
+			hwb =3D test_bit(i, &hw_shareable);
+			swb =3D test_bit(i, &sw_shareable);
+			excl =3D test_bit(i, &exclusive);
+			psl =3D test_bit(i, &pseudo_locked);
+			if (hwb && swb)
+				seq_putc(seq, 'X');
+			else if (hwb && !swb)
+				seq_putc(seq, 'H');
+			else if (!hwb && swb)
+				seq_putc(seq, 'S');
+			else if (excl)
+				seq_putc(seq, 'E');
+			else if (psl)
+				seq_putc(seq, 'P');
+			else /* Unused bits remain */
+				seq_putc(seq, '0');
+		}
+		sep =3D true;
+	}
+	seq_putc(seq, '\n');
+	mutex_unlock(&rdtgroup_mutex);
+	cpus_read_unlock();
+	return 0;
+}
+
+static int rdt_min_bw_show(struct kernfs_open_file *of,
+			   struct seq_file *seq, void *v)
+{
+	struct resctrl_schema *s =3D rdt_kn_parent_priv(of->kn);
+	struct rdt_resource *r =3D s->res;
+
+	seq_printf(seq, "%u\n", r->membw.min_bw);
+	return 0;
+}
+
+static int rdt_num_rmids_show(struct kernfs_open_file *of,
+			      struct seq_file *seq, void *v)
+{
+	struct rdt_resource *r =3D rdt_kn_parent_priv(of->kn);
+
+	seq_printf(seq, "%d\n", r->num_rmid);
+
+	return 0;
+}
+
+static int rdt_mon_features_show(struct kernfs_open_file *of,
+				 struct seq_file *seq, void *v)
+{
+	struct rdt_resource *r =3D rdt_kn_parent_priv(of->kn);
+	struct mon_evt *mevt;
+
+	list_for_each_entry(mevt, &r->evt_list, list) {
+		seq_printf(seq, "%s\n", mevt->name);
+		if (mevt->configurable)
+			seq_printf(seq, "%s_config\n", mevt->name);
+	}
+
+	return 0;
+}
+
+static int rdt_bw_gran_show(struct kernfs_open_file *of,
+			    struct seq_file *seq, void *v)
+{
+	struct resctrl_schema *s =3D rdt_kn_parent_priv(of->kn);
+	struct rdt_resource *r =3D s->res;
+
+	seq_printf(seq, "%u\n", r->membw.bw_gran);
+	return 0;
+}
+
+static int rdt_delay_linear_show(struct kernfs_open_file *of,
+				 struct seq_file *seq, void *v)
+{
+	struct resctrl_schema *s =3D rdt_kn_parent_priv(of->kn);
+	struct rdt_resource *r =3D s->res;
+
+	seq_printf(seq, "%u\n", r->membw.delay_linear);
+	return 0;
+}
+
+static int max_threshold_occ_show(struct kernfs_open_file *of,
+				  struct seq_file *seq, void *v)
+{
+	seq_printf(seq, "%u\n", resctrl_rmid_realloc_threshold);
+
+	return 0;
+}
+
+static int rdt_thread_throttle_mode_show(struct kernfs_open_file *of,
+					 struct seq_file *seq, void *v)
+{
+	struct resctrl_schema *s =3D rdt_kn_parent_priv(of->kn);
+	struct rdt_resource *r =3D s->res;
+
+	switch (r->membw.throttle_mode) {
+	case THREAD_THROTTLE_PER_THREAD:
+		seq_puts(seq, "per-thread\n");
+		return 0;
+	case THREAD_THROTTLE_MAX:
+		seq_puts(seq, "max\n");
+		return 0;
+	case THREAD_THROTTLE_UNDEFINED:
+		seq_puts(seq, "undefined\n");
+		return 0;
+	}
+
+	WARN_ON_ONCE(1);
+
+	return 0;
+}
+
+static ssize_t max_threshold_occ_write(struct kernfs_open_file *of,
+				       char *buf, size_t nbytes, loff_t off)
+{
+	unsigned int bytes;
+	int ret;
+
+	ret =3D kstrtouint(buf, 0, &bytes);
+	if (ret)
+		return ret;
+
+	if (bytes > resctrl_rmid_realloc_limit)
+		return -EINVAL;
+
+	resctrl_rmid_realloc_threshold =3D resctrl_arch_round_mon_val(bytes);
+
+	return nbytes;
+}
+
+/*
+ * rdtgroup_mode_show - Display mode of this resource group
+ */
+static int rdtgroup_mode_show(struct kernfs_open_file *of,
+			      struct seq_file *s, void *v)
+{
+	struct rdtgroup *rdtgrp;
+
+	rdtgrp =3D rdtgroup_kn_lock_live(of->kn);
+	if (!rdtgrp) {
+		rdtgroup_kn_unlock(of->kn);
+		return -ENOENT;
+	}
+
+	seq_printf(s, "%s\n", rdtgroup_mode_str(rdtgrp->mode));
+
+	rdtgroup_kn_unlock(of->kn);
+	return 0;
+}
+
+static enum resctrl_conf_type resctrl_peer_type(enum resctrl_conf_type my_ty=
pe)
+{
+	switch (my_type) {
+	case CDP_CODE:
+		return CDP_DATA;
+	case CDP_DATA:
+		return CDP_CODE;
+	default:
+	case CDP_NONE:
+		return CDP_NONE;
+	}
+}
+
+static int rdt_has_sparse_bitmasks_show(struct kernfs_open_file *of,
+					struct seq_file *seq, void *v)
+{
+	struct resctrl_schema *s =3D rdt_kn_parent_priv(of->kn);
+	struct rdt_resource *r =3D s->res;
+
+	seq_printf(seq, "%u\n", r->cache.arch_has_sparse_bitmasks);
+
+	return 0;
+}
+
+/**
+ * __rdtgroup_cbm_overlaps - Does CBM for intended closid overlap with other
+ * @r: Resource to which domain instance @d belongs.
+ * @d: The domain instance for which @closid is being tested.
+ * @cbm: Capacity bitmask being tested.
+ * @closid: Intended closid for @cbm.
+ * @type: CDP type of @r.
+ * @exclusive: Only check if overlaps with exclusive resource groups
+ *
+ * Checks if provided @cbm intended to be used for @closid on domain
+ * @d overlaps with any other closids or other hardware usage associated
+ * with this domain. If @exclusive is true then only overlaps with
+ * resource groups in exclusive mode will be considered. If @exclusive
+ * is false then overlaps with any resource group or hardware entities
+ * will be considered.
+ *
+ * @cbm is unsigned long, even if only 32 bits are used, to make the
+ * bitmap functions work correctly.
+ *
+ * Return: false if CBM does not overlap, true if it does.
+ */
+static bool __rdtgroup_cbm_overlaps(struct rdt_resource *r, struct rdt_ctrl_=
domain *d,
+				    unsigned long cbm, int closid,
+				    enum resctrl_conf_type type, bool exclusive)
+{
+	enum rdtgrp_mode mode;
+	unsigned long ctrl_b;
+	int i;
+
+	/* Check for any overlap with regions used by hardware directly */
+	if (!exclusive) {
+		ctrl_b =3D r->cache.shareable_bits;
+		if (bitmap_intersects(&cbm, &ctrl_b, r->cache.cbm_len))
+			return true;
+	}
+
+	/* Check for overlap with other resource groups */
+	for (i =3D 0; i < closids_supported(); i++) {
+		ctrl_b =3D resctrl_arch_get_config(r, d, i, type);
+		mode =3D rdtgroup_mode_by_closid(i);
+		if (closid_allocated(i) && i !=3D closid &&
+		    mode !=3D RDT_MODE_PSEUDO_LOCKSETUP) {
+			if (bitmap_intersects(&cbm, &ctrl_b, r->cache.cbm_len)) {
+				if (exclusive) {
+					if (mode =3D=3D RDT_MODE_EXCLUSIVE)
+						return true;
+					continue;
+				}
+				return true;
+			}
+		}
+	}
+
+	return false;
+}
+
+/**
+ * rdtgroup_cbm_overlaps - Does CBM overlap with other use of hardware
+ * @s: Schema for the resource to which domain instance @d belongs.
+ * @d: The domain instance for which @closid is being tested.
+ * @cbm: Capacity bitmask being tested.
+ * @closid: Intended closid for @cbm.
+ * @exclusive: Only check if overlaps with exclusive resource groups
+ *
+ * Resources that can be allocated using a CBM can use the CBM to control
+ * the overlap of these allocations. rdtgroup_cmb_overlaps() is the test
+ * for overlap. Overlap test is not limited to the specific resource for
+ * which the CBM is intended though - when dealing with CDP resources that
+ * share the underlying hardware the overlap check should be performed on
+ * the CDP resource sharing the hardware also.
+ *
+ * Refer to description of __rdtgroup_cbm_overlaps() for the details of the
+ * overlap test.
+ *
+ * Return: true if CBM overlap detected, false if there is no overlap
+ */
+bool rdtgroup_cbm_overlaps(struct resctrl_schema *s, struct rdt_ctrl_domain =
*d,
+			   unsigned long cbm, int closid, bool exclusive)
+{
+	enum resctrl_conf_type peer_type =3D resctrl_peer_type(s->conf_type);
+	struct rdt_resource *r =3D s->res;
+
+	if (__rdtgroup_cbm_overlaps(r, d, cbm, closid, s->conf_type,
+				    exclusive))
+		return true;
+
+	if (!resctrl_arch_get_cdp_enabled(r->rid))
+		return false;
+	return  __rdtgroup_cbm_overlaps(r, d, cbm, closid, peer_type, exclusive);
+}
+
+/**
+ * rdtgroup_mode_test_exclusive - Test if this resource group can be exclusi=
ve
+ * @rdtgrp: Resource group identified through its closid.
+ *
+ * An exclusive resource group implies that there should be no sharing of
+ * its allocated resources. At the time this group is considered to be
+ * exclusive this test can determine if its current schemata supports this
+ * setting by testing for overlap with all other resource groups.
+ *
+ * Return: true if resource group can be exclusive, false if there is overlap
+ * with allocations of other resource groups and thus this resource group
+ * cannot be exclusive.
+ */
+static bool rdtgroup_mode_test_exclusive(struct rdtgroup *rdtgrp)
+{
+	int closid =3D rdtgrp->closid;
+	struct rdt_ctrl_domain *d;
+	struct resctrl_schema *s;
+	struct rdt_resource *r;
+	bool has_cache =3D false;
+	u32 ctrl;
+
+	/* Walking r->domains, ensure it can't race with cpuhp */
+	lockdep_assert_cpus_held();
+
+	list_for_each_entry(s, &resctrl_schema_all, list) {
+		r =3D s->res;
+		if (r->rid =3D=3D RDT_RESOURCE_MBA || r->rid =3D=3D RDT_RESOURCE_SMBA)
+			continue;
+		has_cache =3D true;
+		list_for_each_entry(d, &r->ctrl_domains, hdr.list) {
+			ctrl =3D resctrl_arch_get_config(r, d, closid,
+						       s->conf_type);
+			if (rdtgroup_cbm_overlaps(s, d, ctrl, closid, false)) {
+				rdt_last_cmd_puts("Schemata overlaps\n");
+				return false;
+			}
+		}
+	}
+
+	if (!has_cache) {
+		rdt_last_cmd_puts("Cannot be exclusive without CAT/CDP\n");
+		return false;
+	}
+
+	return true;
+}
+
+/*
+ * rdtgroup_mode_write - Modify the resource group's mode
+ */
+static ssize_t rdtgroup_mode_write(struct kernfs_open_file *of,
+				   char *buf, size_t nbytes, loff_t off)
+{
+	struct rdtgroup *rdtgrp;
+	enum rdtgrp_mode mode;
+	int ret =3D 0;
+
+	/* Valid input requires a trailing newline */
+	if (nbytes =3D=3D 0 || buf[nbytes - 1] !=3D '\n')
+		return -EINVAL;
+	buf[nbytes - 1] =3D '\0';
+
+	rdtgrp =3D rdtgroup_kn_lock_live(of->kn);
+	if (!rdtgrp) {
+		rdtgroup_kn_unlock(of->kn);
+		return -ENOENT;
+	}
+
+	rdt_last_cmd_clear();
+
+	mode =3D rdtgrp->mode;
+
+	if ((!strcmp(buf, "shareable") && mode =3D=3D RDT_MODE_SHAREABLE) ||
+	    (!strcmp(buf, "exclusive") && mode =3D=3D RDT_MODE_EXCLUSIVE) ||
+	    (!strcmp(buf, "pseudo-locksetup") &&
+	     mode =3D=3D RDT_MODE_PSEUDO_LOCKSETUP) ||
+	    (!strcmp(buf, "pseudo-locked") && mode =3D=3D RDT_MODE_PSEUDO_LOCKED))
+		goto out;
+
+	if (mode =3D=3D RDT_MODE_PSEUDO_LOCKED) {
+		rdt_last_cmd_puts("Cannot change pseudo-locked group\n");
+		ret =3D -EINVAL;
+		goto out;
+	}
+
+	if (!strcmp(buf, "shareable")) {
+		if (rdtgrp->mode =3D=3D RDT_MODE_PSEUDO_LOCKSETUP) {
+			ret =3D rdtgroup_locksetup_exit(rdtgrp);
+			if (ret)
+				goto out;
+		}
+		rdtgrp->mode =3D RDT_MODE_SHAREABLE;
+	} else if (!strcmp(buf, "exclusive")) {
+		if (!rdtgroup_mode_test_exclusive(rdtgrp)) {
+			ret =3D -EINVAL;
+			goto out;
+		}
+		if (rdtgrp->mode =3D=3D RDT_MODE_PSEUDO_LOCKSETUP) {
+			ret =3D rdtgroup_locksetup_exit(rdtgrp);
+			if (ret)
+				goto out;
+		}
+		rdtgrp->mode =3D RDT_MODE_EXCLUSIVE;
+	} else if (IS_ENABLED(CONFIG_RESCTRL_FS_PSEUDO_LOCK) &&
+		   !strcmp(buf, "pseudo-locksetup")) {
+		ret =3D rdtgroup_locksetup_enter(rdtgrp);
+		if (ret)
+			goto out;
+		rdtgrp->mode =3D RDT_MODE_PSEUDO_LOCKSETUP;
+	} else {
+		rdt_last_cmd_puts("Unknown or unsupported mode\n");
+		ret =3D -EINVAL;
+	}
+
+out:
+	rdtgroup_kn_unlock(of->kn);
+	return ret ?: nbytes;
+}
+
+/**
+ * rdtgroup_cbm_to_size - Translate CBM to size in bytes
+ * @r: RDT resource to which @d belongs.
+ * @d: RDT domain instance.
+ * @cbm: bitmask for which the size should be computed.
+ *
+ * The bitmask provided associated with the RDT domain instance @d will be
+ * translated into how many bytes it represents. The size in bytes is
+ * computed by first dividing the total cache size by the CBM length to
+ * determine how many bytes each bit in the bitmask represents. The result
+ * is multiplied with the number of bits set in the bitmask.
+ *
+ * @cbm is unsigned long, even if only 32 bits are used to make the
+ * bitmap functions work correctly.
+ */
+unsigned int rdtgroup_cbm_to_size(struct rdt_resource *r,
+				  struct rdt_ctrl_domain *d, unsigned long cbm)
+{
+	unsigned int size =3D 0;
+	struct cacheinfo *ci;
+	int num_b;
+
+	if (WARN_ON_ONCE(r->ctrl_scope !=3D RESCTRL_L2_CACHE && r->ctrl_scope !=3D =
RESCTRL_L3_CACHE))
+		return size;
+
+	num_b =3D bitmap_weight(&cbm, r->cache.cbm_len);
+	ci =3D get_cpu_cacheinfo_level(cpumask_any(&d->hdr.cpu_mask), r->ctrl_scope=
);
+	if (ci)
+		size =3D ci->size / r->cache.cbm_len * num_b;
+
+	return size;
+}
+
+bool is_mba_sc(struct rdt_resource *r)
+{
+	if (!r)
+		r =3D resctrl_arch_get_resource(RDT_RESOURCE_MBA);
+
+	/*
+	 * The software controller support is only applicable to MBA resource.
+	 * Make sure to check for resource type.
+	 */
+	if (r->rid !=3D RDT_RESOURCE_MBA)
+		return false;
+
+	return r->membw.mba_sc;
+}
+
+/*
+ * rdtgroup_size_show - Display size in bytes of allocated regions
+ *
+ * The "size" file mirrors the layout of the "schemata" file, printing the
+ * size in bytes of each region instead of the capacity bitmask.
+ */
+static int rdtgroup_size_show(struct kernfs_open_file *of,
+			      struct seq_file *s, void *v)
+{
+	struct resctrl_schema *schema;
+	enum resctrl_conf_type type;
+	struct rdt_ctrl_domain *d;
+	struct rdtgroup *rdtgrp;
+	struct rdt_resource *r;
+	unsigned int size;
+	int ret =3D 0;
+	u32 closid;
+	bool sep;
+	u32 ctrl;
+
+	rdtgrp =3D rdtgroup_kn_lock_live(of->kn);
+	if (!rdtgrp) {
+		rdtgroup_kn_unlock(of->kn);
+		return -ENOENT;
+	}
+
+	if (rdtgrp->mode =3D=3D RDT_MODE_PSEUDO_LOCKED) {
+		if (!rdtgrp->plr->d) {
+			rdt_last_cmd_clear();
+			rdt_last_cmd_puts("Cache domain offline\n");
+			ret =3D -ENODEV;
+		} else {
+			seq_printf(s, "%*s:", max_name_width,
+				   rdtgrp->plr->s->name);
+			size =3D rdtgroup_cbm_to_size(rdtgrp->plr->s->res,
+						    rdtgrp->plr->d,
+						    rdtgrp->plr->cbm);
+			seq_printf(s, "%d=3D%u\n", rdtgrp->plr->d->hdr.id, size);
+		}
+		goto out;
+	}
+
+	closid =3D rdtgrp->closid;
+
+	list_for_each_entry(schema, &resctrl_schema_all, list) {
+		r =3D schema->res;
+		type =3D schema->conf_type;
+		sep =3D false;
+		seq_printf(s, "%*s:", max_name_width, schema->name);
+		list_for_each_entry(d, &r->ctrl_domains, hdr.list) {
+			if (sep)
+				seq_putc(s, ';');
+			if (rdtgrp->mode =3D=3D RDT_MODE_PSEUDO_LOCKSETUP) {
+				size =3D 0;
+			} else {
+				if (is_mba_sc(r))
+					ctrl =3D d->mbps_val[closid];
+				else
+					ctrl =3D resctrl_arch_get_config(r, d,
+								       closid,
+								       type);
+				if (r->rid =3D=3D RDT_RESOURCE_MBA ||
+				    r->rid =3D=3D RDT_RESOURCE_SMBA)
+					size =3D ctrl;
+				else
+					size =3D rdtgroup_cbm_to_size(r, d, ctrl);
+			}
+			seq_printf(s, "%d=3D%u", d->hdr.id, size);
+			sep =3D true;
+		}
+		seq_putc(s, '\n');
+	}
+
+out:
+	rdtgroup_kn_unlock(of->kn);
+
+	return ret;
+}
+
+static void mondata_config_read(struct resctrl_mon_config_info *mon_info)
+{
+	smp_call_function_any(&mon_info->d->hdr.cpu_mask,
+			      resctrl_arch_mon_event_config_read, mon_info, 1);
+}
+
+static int mbm_config_show(struct seq_file *s, struct rdt_resource *r, u32 e=
vtid)
+{
+	struct resctrl_mon_config_info mon_info;
+	struct rdt_mon_domain *dom;
+	bool sep =3D false;
+
+	cpus_read_lock();
+	mutex_lock(&rdtgroup_mutex);
+
+	list_for_each_entry(dom, &r->mon_domains, hdr.list) {
+		if (sep)
+			seq_puts(s, ";");
+
+		memset(&mon_info, 0, sizeof(struct resctrl_mon_config_info));
+		mon_info.r =3D r;
+		mon_info.d =3D dom;
+		mon_info.evtid =3D evtid;
+		mondata_config_read(&mon_info);
+
+		seq_printf(s, "%d=3D0x%02x", dom->hdr.id, mon_info.mon_config);
+		sep =3D true;
+	}
+	seq_puts(s, "\n");
+
+	mutex_unlock(&rdtgroup_mutex);
+	cpus_read_unlock();
+
+	return 0;
+}
+
+static int mbm_total_bytes_config_show(struct kernfs_open_file *of,
+				       struct seq_file *seq, void *v)
+{
+	struct rdt_resource *r =3D rdt_kn_parent_priv(of->kn);
+
+	mbm_config_show(seq, r, QOS_L3_MBM_TOTAL_EVENT_ID);
+
+	return 0;
+}
+
+static int mbm_local_bytes_config_show(struct kernfs_open_file *of,
+				       struct seq_file *seq, void *v)
+{
+	struct rdt_resource *r =3D rdt_kn_parent_priv(of->kn);
+
+	mbm_config_show(seq, r, QOS_L3_MBM_LOCAL_EVENT_ID);
+
+	return 0;
+}
+
+static void mbm_config_write_domain(struct rdt_resource *r,
+				    struct rdt_mon_domain *d, u32 evtid, u32 val)
+{
+	struct resctrl_mon_config_info mon_info =3D {0};
+
+	/*
+	 * Read the current config value first. If both are the same then
+	 * no need to write it again.
+	 */
+	mon_info.r =3D r;
+	mon_info.d =3D d;
+	mon_info.evtid =3D evtid;
+	mondata_config_read(&mon_info);
+	if (mon_info.mon_config =3D=3D val)
+		return;
+
+	mon_info.mon_config =3D val;
+
+	/*
+	 * Update MSR_IA32_EVT_CFG_BASE MSR on one of the CPUs in the
+	 * domain. The MSRs offset from MSR MSR_IA32_EVT_CFG_BASE
+	 * are scoped at the domain level. Writing any of these MSRs
+	 * on one CPU is observed by all the CPUs in the domain.
+	 */
+	smp_call_function_any(&d->hdr.cpu_mask, resctrl_arch_mon_event_config_write,
+			      &mon_info, 1);
+
+	/*
+	 * When an Event Configuration is changed, the bandwidth counters
+	 * for all RMIDs and Events will be cleared by the hardware. The
+	 * hardware also sets MSR_IA32_QM_CTR.Unavailable (bit 62) for
+	 * every RMID on the next read to any event for every RMID.
+	 * Subsequent reads will have MSR_IA32_QM_CTR.Unavailable (bit 62)
+	 * cleared while it is tracked by the hardware. Clear the
+	 * mbm_local and mbm_total counts for all the RMIDs.
+	 */
+	resctrl_arch_reset_rmid_all(r, d);
+}
+
+static int mon_config_write(struct rdt_resource *r, char *tok, u32 evtid)
+{
+	char *dom_str =3D NULL, *id_str;
+	unsigned long dom_id, val;
+	struct rdt_mon_domain *d;
+
+	/* Walking r->domains, ensure it can't race with cpuhp */
+	lockdep_assert_cpus_held();
+
+next:
+	if (!tok || tok[0] =3D=3D '\0')
+		return 0;
+
+	/* Start processing the strings for each domain */
+	dom_str =3D strim(strsep(&tok, ";"));
+	id_str =3D strsep(&dom_str, "=3D");
+
+	if (!id_str || kstrtoul(id_str, 10, &dom_id)) {
+		rdt_last_cmd_puts("Missing '=3D' or non-numeric domain id\n");
+		return -EINVAL;
+	}
+
+	if (!dom_str || kstrtoul(dom_str, 16, &val)) {
+		rdt_last_cmd_puts("Non-numeric event configuration value\n");
+		return -EINVAL;
+	}
+
+	/* Value from user cannot be more than the supported set of events */
+	if ((val & r->mbm_cfg_mask) !=3D val) {
+		rdt_last_cmd_printf("Invalid event configuration: max valid mask is 0x%02x=
\n",
+				    r->mbm_cfg_mask);
+		return -EINVAL;
+	}
+
+	list_for_each_entry(d, &r->mon_domains, hdr.list) {
+		if (d->hdr.id =3D=3D dom_id) {
+			mbm_config_write_domain(r, d, evtid, val);
+			goto next;
+		}
+	}
+
+	return -EINVAL;
+}
+
+static ssize_t mbm_total_bytes_config_write(struct kernfs_open_file *of,
+					    char *buf, size_t nbytes,
+					    loff_t off)
+{
+	struct rdt_resource *r =3D rdt_kn_parent_priv(of->kn);
+	int ret;
+
+	/* Valid input requires a trailing newline */
+	if (nbytes =3D=3D 0 || buf[nbytes - 1] !=3D '\n')
+		return -EINVAL;
+
+	cpus_read_lock();
+	mutex_lock(&rdtgroup_mutex);
+
+	rdt_last_cmd_clear();
+
+	buf[nbytes - 1] =3D '\0';
+
+	ret =3D mon_config_write(r, buf, QOS_L3_MBM_TOTAL_EVENT_ID);
+
+	mutex_unlock(&rdtgroup_mutex);
+	cpus_read_unlock();
+
+	return ret ?: nbytes;
+}
+
+static ssize_t mbm_local_bytes_config_write(struct kernfs_open_file *of,
+					    char *buf, size_t nbytes,
+					    loff_t off)
+{
+	struct rdt_resource *r =3D rdt_kn_parent_priv(of->kn);
+	int ret;
+
+	/* Valid input requires a trailing newline */
+	if (nbytes =3D=3D 0 || buf[nbytes - 1] !=3D '\n')
+		return -EINVAL;
+
+	cpus_read_lock();
+	mutex_lock(&rdtgroup_mutex);
+
+	rdt_last_cmd_clear();
+
+	buf[nbytes - 1] =3D '\0';
+
+	ret =3D mon_config_write(r, buf, QOS_L3_MBM_LOCAL_EVENT_ID);
+
+	mutex_unlock(&rdtgroup_mutex);
+	cpus_read_unlock();
+
+	return ret ?: nbytes;
+}
+
+/* rdtgroup information files for one cache resource. */
+static struct rftype res_common_files[] =3D {
+	{
+		.name		=3D "last_cmd_status",
+		.mode		=3D 0444,
+		.kf_ops		=3D &rdtgroup_kf_single_ops,
+		.seq_show	=3D rdt_last_cmd_status_show,
+		.fflags		=3D RFTYPE_TOP_INFO,
+	},
+	{
+		.name		=3D "num_closids",
+		.mode		=3D 0444,
+		.kf_ops		=3D &rdtgroup_kf_single_ops,
+		.seq_show	=3D rdt_num_closids_show,
+		.fflags		=3D RFTYPE_CTRL_INFO,
+	},
+	{
+		.name		=3D "mon_features",
+		.mode		=3D 0444,
+		.kf_ops		=3D &rdtgroup_kf_single_ops,
+		.seq_show	=3D rdt_mon_features_show,
+		.fflags		=3D RFTYPE_MON_INFO,
+	},
+	{
+		.name		=3D "num_rmids",
+		.mode		=3D 0444,
+		.kf_ops		=3D &rdtgroup_kf_single_ops,
+		.seq_show	=3D rdt_num_rmids_show,
+		.fflags		=3D RFTYPE_MON_INFO,
+	},
+	{
+		.name		=3D "cbm_mask",
+		.mode		=3D 0444,
+		.kf_ops		=3D &rdtgroup_kf_single_ops,
+		.seq_show	=3D rdt_default_ctrl_show,
+		.fflags		=3D RFTYPE_CTRL_INFO | RFTYPE_RES_CACHE,
+	},
+	{
+		.name		=3D "min_cbm_bits",
+		.mode		=3D 0444,
+		.kf_ops		=3D &rdtgroup_kf_single_ops,
+		.seq_show	=3D rdt_min_cbm_bits_show,
+		.fflags		=3D RFTYPE_CTRL_INFO | RFTYPE_RES_CACHE,
+	},
+	{
+		.name		=3D "shareable_bits",
+		.mode		=3D 0444,
+		.kf_ops		=3D &rdtgroup_kf_single_ops,
+		.seq_show	=3D rdt_shareable_bits_show,
+		.fflags		=3D RFTYPE_CTRL_INFO | RFTYPE_RES_CACHE,
+	},
+	{
+		.name		=3D "bit_usage",
+		.mode		=3D 0444,
+		.kf_ops		=3D &rdtgroup_kf_single_ops,
+		.seq_show	=3D rdt_bit_usage_show,
+		.fflags		=3D RFTYPE_CTRL_INFO | RFTYPE_RES_CACHE,
+	},
+	{
+		.name		=3D "min_bandwidth",
+		.mode		=3D 0444,
+		.kf_ops		=3D &rdtgroup_kf_single_ops,
+		.seq_show	=3D rdt_min_bw_show,
+		.fflags		=3D RFTYPE_CTRL_INFO | RFTYPE_RES_MB,
+	},
+	{
+		.name		=3D "bandwidth_gran",
+		.mode		=3D 0444,
+		.kf_ops		=3D &rdtgroup_kf_single_ops,
+		.seq_show	=3D rdt_bw_gran_show,
+		.fflags		=3D RFTYPE_CTRL_INFO | RFTYPE_RES_MB,
+	},
+	{
+		.name		=3D "delay_linear",
+		.mode		=3D 0444,
+		.kf_ops		=3D &rdtgroup_kf_single_ops,
+		.seq_show	=3D rdt_delay_linear_show,
+		.fflags		=3D RFTYPE_CTRL_INFO | RFTYPE_RES_MB,
+	},
+	/*
+	 * Platform specific which (if any) capabilities are provided by
+	 * thread_throttle_mode. Defer "fflags" initialization to platform
+	 * discovery.
+	 */
+	{
+		.name		=3D "thread_throttle_mode",
+		.mode		=3D 0444,
+		.kf_ops		=3D &rdtgroup_kf_single_ops,
+		.seq_show	=3D rdt_thread_throttle_mode_show,
+	},
+	{
+		.name		=3D "max_threshold_occupancy",
+		.mode		=3D 0644,
+		.kf_ops		=3D &rdtgroup_kf_single_ops,
+		.write		=3D max_threshold_occ_write,
+		.seq_show	=3D max_threshold_occ_show,
+		.fflags		=3D RFTYPE_MON_INFO | RFTYPE_RES_CACHE,
+	},
+	{
+		.name		=3D "mbm_total_bytes_config",
+		.mode		=3D 0644,
+		.kf_ops		=3D &rdtgroup_kf_single_ops,
+		.seq_show	=3D mbm_total_bytes_config_show,
+		.write		=3D mbm_total_bytes_config_write,
+	},
+	{
+		.name		=3D "mbm_local_bytes_config",
+		.mode		=3D 0644,
+		.kf_ops		=3D &rdtgroup_kf_single_ops,
+		.seq_show	=3D mbm_local_bytes_config_show,
+		.write		=3D mbm_local_bytes_config_write,
+	},
+	{
+		.name		=3D "cpus",
+		.mode		=3D 0644,
+		.kf_ops		=3D &rdtgroup_kf_single_ops,
+		.write		=3D rdtgroup_cpus_write,
+		.seq_show	=3D rdtgroup_cpus_show,
+		.fflags		=3D RFTYPE_BASE,
+	},
+	{
+		.name		=3D "cpus_list",
+		.mode		=3D 0644,
+		.kf_ops		=3D &rdtgroup_kf_single_ops,
+		.write		=3D rdtgroup_cpus_write,
+		.seq_show	=3D rdtgroup_cpus_show,
+		.flags		=3D RFTYPE_FLAGS_CPUS_LIST,
+		.fflags		=3D RFTYPE_BASE,
+	},
+	{
+		.name		=3D "tasks",
+		.mode		=3D 0644,
+		.kf_ops		=3D &rdtgroup_kf_single_ops,
+		.write		=3D rdtgroup_tasks_write,
+		.seq_show	=3D rdtgroup_tasks_show,
+		.fflags		=3D RFTYPE_BASE,
+	},
+	{
+		.name		=3D "mon_hw_id",
+		.mode		=3D 0444,
+		.kf_ops		=3D &rdtgroup_kf_single_ops,
+		.seq_show	=3D rdtgroup_rmid_show,
+		.fflags		=3D RFTYPE_MON_BASE | RFTYPE_DEBUG,
+	},
+	{
+		.name		=3D "schemata",
+		.mode		=3D 0644,
+		.kf_ops		=3D &rdtgroup_kf_single_ops,
+		.write		=3D rdtgroup_schemata_write,
+		.seq_show	=3D rdtgroup_schemata_show,
+		.fflags		=3D RFTYPE_CTRL_BASE,
+	},
+	{
+		.name		=3D "mba_MBps_event",
+		.mode		=3D 0644,
+		.kf_ops		=3D &rdtgroup_kf_single_ops,
+		.write		=3D rdtgroup_mba_mbps_event_write,
+		.seq_show	=3D rdtgroup_mba_mbps_event_show,
+	},
+	{
+		.name		=3D "mode",
+		.mode		=3D 0644,
+		.kf_ops		=3D &rdtgroup_kf_single_ops,
+		.write		=3D rdtgroup_mode_write,
+		.seq_show	=3D rdtgroup_mode_show,
+		.fflags		=3D RFTYPE_CTRL_BASE,
+	},
+	{
+		.name		=3D "size",
+		.mode		=3D 0444,
+		.kf_ops		=3D &rdtgroup_kf_single_ops,
+		.seq_show	=3D rdtgroup_size_show,
+		.fflags		=3D RFTYPE_CTRL_BASE,
+	},
+	{
+		.name		=3D "sparse_masks",
+		.mode		=3D 0444,
+		.kf_ops		=3D &rdtgroup_kf_single_ops,
+		.seq_show	=3D rdt_has_sparse_bitmasks_show,
+		.fflags		=3D RFTYPE_CTRL_INFO | RFTYPE_RES_CACHE,
+	},
+	{
+		.name		=3D "ctrl_hw_id",
+		.mode		=3D 0444,
+		.kf_ops		=3D &rdtgroup_kf_single_ops,
+		.seq_show	=3D rdtgroup_closid_show,
+		.fflags		=3D RFTYPE_CTRL_BASE | RFTYPE_DEBUG,
+	},
+};
+
+static int rdtgroup_add_files(struct kernfs_node *kn, unsigned long fflags)
+{
+	struct rftype *rfts, *rft;
+	int ret, len;
+
+	rfts =3D res_common_files;
+	len =3D ARRAY_SIZE(res_common_files);
+
+	lockdep_assert_held(&rdtgroup_mutex);
+
+	if (resctrl_debug)
+		fflags |=3D RFTYPE_DEBUG;
+
+	for (rft =3D rfts; rft < rfts + len; rft++) {
+		if (rft->fflags && ((fflags & rft->fflags) =3D=3D rft->fflags)) {
+			ret =3D rdtgroup_add_file(kn, rft);
+			if (ret)
+				goto error;
+		}
+	}
+
+	return 0;
+error:
+	pr_warn("Failed to add %s, err=3D%d\n", rft->name, ret);
+	while (--rft >=3D rfts) {
+		if ((fflags & rft->fflags) =3D=3D rft->fflags)
+			kernfs_remove_by_name(kn, rft->name);
+	}
+	return ret;
+}
+
+static struct rftype *rdtgroup_get_rftype_by_name(const char *name)
+{
+	struct rftype *rfts, *rft;
+	int len;
+
+	rfts =3D res_common_files;
+	len =3D ARRAY_SIZE(res_common_files);
+
+	for (rft =3D rfts; rft < rfts + len; rft++) {
+		if (!strcmp(rft->name, name))
+			return rft;
+	}
+
+	return NULL;
+}
+
+static void thread_throttle_mode_init(void)
+{
+	enum membw_throttle_mode throttle_mode =3D THREAD_THROTTLE_UNDEFINED;
+	struct rdt_resource *r_mba, *r_smba;
+
+	r_mba =3D resctrl_arch_get_resource(RDT_RESOURCE_MBA);
+	if (r_mba->alloc_capable &&
+	    r_mba->membw.throttle_mode !=3D THREAD_THROTTLE_UNDEFINED)
+		throttle_mode =3D r_mba->membw.throttle_mode;
+
+	r_smba =3D resctrl_arch_get_resource(RDT_RESOURCE_SMBA);
+	if (r_smba->alloc_capable &&
+	    r_smba->membw.throttle_mode !=3D THREAD_THROTTLE_UNDEFINED)
+		throttle_mode =3D r_smba->membw.throttle_mode;
+
+	if (throttle_mode =3D=3D THREAD_THROTTLE_UNDEFINED)
+		return;
+
+	resctrl_file_fflags_init("thread_throttle_mode",
+				 RFTYPE_CTRL_INFO | RFTYPE_RES_MB);
+}
+
+void resctrl_file_fflags_init(const char *config, unsigned long fflags)
+{
+	struct rftype *rft;
+
+	rft =3D rdtgroup_get_rftype_by_name(config);
+	if (rft)
+		rft->fflags =3D fflags;
+}
+
+/**
+ * rdtgroup_kn_mode_restrict - Restrict user access to named resctrl file
+ * @r: The resource group with which the file is associated.
+ * @name: Name of the file
+ *
+ * The permissions of named resctrl file, directory, or link are modified
+ * to not allow read, write, or execute by any user.
+ *
+ * WARNING: This function is intended to communicate to the user that the
+ * resctrl file has been locked down - that it is not relevant to the
+ * particular state the system finds itself in. It should not be relied
+ * on to protect from user access because after the file's permissions
+ * are restricted the user can still change the permissions using chmod
+ * from the command line.
+ *
+ * Return: 0 on success, <0 on failure.
+ */
+int rdtgroup_kn_mode_restrict(struct rdtgroup *r, const char *name)
+{
+	struct iattr iattr =3D {.ia_valid =3D ATTR_MODE,};
+	struct kernfs_node *kn;
+	int ret =3D 0;
+
+	kn =3D kernfs_find_and_get_ns(r->kn, name, NULL);
+	if (!kn)
+		return -ENOENT;
+
+	switch (kernfs_type(kn)) {
+	case KERNFS_DIR:
+		iattr.ia_mode =3D S_IFDIR;
+		break;
+	case KERNFS_FILE:
+		iattr.ia_mode =3D S_IFREG;
+		break;
+	case KERNFS_LINK:
+		iattr.ia_mode =3D S_IFLNK;
+		break;
+	}
+
+	ret =3D kernfs_setattr(kn, &iattr);
+	kernfs_put(kn);
+	return ret;
+}
+
+/**
+ * rdtgroup_kn_mode_restore - Restore user access to named resctrl file
+ * @r: The resource group with which the file is associated.
+ * @name: Name of the file
+ * @mask: Mask of permissions that should be restored
+ *
+ * Restore the permissions of the named file. If @name is a directory the
+ * permissions of its parent will be used.
+ *
+ * Return: 0 on success, <0 on failure.
+ */
+int rdtgroup_kn_mode_restore(struct rdtgroup *r, const char *name,
+			     umode_t mask)
+{
+	struct iattr iattr =3D {.ia_valid =3D ATTR_MODE,};
+	struct kernfs_node *kn, *parent;
+	struct rftype *rfts, *rft;
+	int ret, len;
+
+	rfts =3D res_common_files;
+	len =3D ARRAY_SIZE(res_common_files);
+
+	for (rft =3D rfts; rft < rfts + len; rft++) {
+		if (!strcmp(rft->name, name))
+			iattr.ia_mode =3D rft->mode & mask;
+	}
+
+	kn =3D kernfs_find_and_get_ns(r->kn, name, NULL);
+	if (!kn)
+		return -ENOENT;
+
+	switch (kernfs_type(kn)) {
+	case KERNFS_DIR:
+		parent =3D kernfs_get_parent(kn);
+		if (parent) {
+			iattr.ia_mode |=3D parent->mode;
+			kernfs_put(parent);
+		}
+		iattr.ia_mode |=3D S_IFDIR;
+		break;
+	case KERNFS_FILE:
+		iattr.ia_mode |=3D S_IFREG;
+		break;
+	case KERNFS_LINK:
+		iattr.ia_mode |=3D S_IFLNK;
+		break;
+	}
+
+	ret =3D kernfs_setattr(kn, &iattr);
+	kernfs_put(kn);
+	return ret;
+}
+
+static int rdtgroup_mkdir_info_resdir(void *priv, char *name,
+				      unsigned long fflags)
+{
+	struct kernfs_node *kn_subdir;
+	int ret;
+
+	kn_subdir =3D kernfs_create_dir(kn_info, name,
+				      kn_info->mode, priv);
+	if (IS_ERR(kn_subdir))
+		return PTR_ERR(kn_subdir);
+
+	ret =3D rdtgroup_kn_set_ugid(kn_subdir);
+	if (ret)
+		return ret;
+
+	ret =3D rdtgroup_add_files(kn_subdir, fflags);
+	if (!ret)
+		kernfs_activate(kn_subdir);
+
+	return ret;
+}
+
+static unsigned long fflags_from_resource(struct rdt_resource *r)
+{
+	switch (r->rid) {
+	case RDT_RESOURCE_L3:
+	case RDT_RESOURCE_L2:
+		return RFTYPE_RES_CACHE;
+	case RDT_RESOURCE_MBA:
+	case RDT_RESOURCE_SMBA:
+		return RFTYPE_RES_MB;
+	}
+
+	return WARN_ON_ONCE(1);
+}
+
+static int rdtgroup_create_info_dir(struct kernfs_node *parent_kn)
+{
+	struct resctrl_schema *s;
+	struct rdt_resource *r;
+	unsigned long fflags;
+	char name[32];
+	int ret;
+
+	/* create the directory */
+	kn_info =3D kernfs_create_dir(parent_kn, "info", parent_kn->mode, NULL);
+	if (IS_ERR(kn_info))
+		return PTR_ERR(kn_info);
+
+	ret =3D rdtgroup_add_files(kn_info, RFTYPE_TOP_INFO);
+	if (ret)
+		goto out_destroy;
+
+	/* loop over enabled controls, these are all alloc_capable */
+	list_for_each_entry(s, &resctrl_schema_all, list) {
+		r =3D s->res;
+		fflags =3D fflags_from_resource(r) | RFTYPE_CTRL_INFO;
+		ret =3D rdtgroup_mkdir_info_resdir(s, s->name, fflags);
+		if (ret)
+			goto out_destroy;
+	}
+
+	for_each_mon_capable_rdt_resource(r) {
+		fflags =3D fflags_from_resource(r) | RFTYPE_MON_INFO;
+		sprintf(name, "%s_MON", r->name);
+		ret =3D rdtgroup_mkdir_info_resdir(r, name, fflags);
+		if (ret)
+			goto out_destroy;
+	}
+
+	ret =3D rdtgroup_kn_set_ugid(kn_info);
+	if (ret)
+		goto out_destroy;
+
+	kernfs_activate(kn_info);
+
+	return 0;
+
+out_destroy:
+	kernfs_remove(kn_info);
+	return ret;
+}
+
+static int
+mongroup_create_dir(struct kernfs_node *parent_kn, struct rdtgroup *prgrp,
+		    char *name, struct kernfs_node **dest_kn)
+{
+	struct kernfs_node *kn;
+	int ret;
+
+	/* create the directory */
+	kn =3D kernfs_create_dir(parent_kn, name, parent_kn->mode, prgrp);
+	if (IS_ERR(kn))
+		return PTR_ERR(kn);
+
+	if (dest_kn)
+		*dest_kn =3D kn;
+
+	ret =3D rdtgroup_kn_set_ugid(kn);
+	if (ret)
+		goto out_destroy;
+
+	kernfs_activate(kn);
+
+	return 0;
+
+out_destroy:
+	kernfs_remove(kn);
+	return ret;
+}
+
+static inline bool is_mba_linear(void)
+{
+	return resctrl_arch_get_resource(RDT_RESOURCE_MBA)->membw.delay_linear;
+}
+
+static int mba_sc_domain_allocate(struct rdt_resource *r, struct rdt_ctrl_do=
main *d)
+{
+	u32 num_closid =3D resctrl_arch_get_num_closid(r);
+	int cpu =3D cpumask_any(&d->hdr.cpu_mask);
+	int i;
+
+	d->mbps_val =3D kcalloc_node(num_closid, sizeof(*d->mbps_val),
+				   GFP_KERNEL, cpu_to_node(cpu));
+	if (!d->mbps_val)
+		return -ENOMEM;
+
+	for (i =3D 0; i < num_closid; i++)
+		d->mbps_val[i] =3D MBA_MAX_MBPS;
+
+	return 0;
+}
+
+static void mba_sc_domain_destroy(struct rdt_resource *r,
+				  struct rdt_ctrl_domain *d)
+{
+	kfree(d->mbps_val);
+	d->mbps_val =3D NULL;
+}
+
+/*
+ * MBA software controller is supported only if
+ * MBM is supported and MBA is in linear scale,
+ * and the MBM monitor scope is the same as MBA
+ * control scope.
+ */
+static bool supports_mba_mbps(void)
+{
+	struct rdt_resource *rmbm =3D resctrl_arch_get_resource(RDT_RESOURCE_L3);
+	struct rdt_resource *r =3D resctrl_arch_get_resource(RDT_RESOURCE_MBA);
+
+	return (resctrl_is_mbm_enabled() &&
+		r->alloc_capable && is_mba_linear() &&
+		r->ctrl_scope =3D=3D rmbm->mon_scope);
+}
+
+/*
+ * Enable or disable the MBA software controller
+ * which helps user specify bandwidth in MBps.
+ */
+static int set_mba_sc(bool mba_sc)
+{
+	struct rdt_resource *r =3D resctrl_arch_get_resource(RDT_RESOURCE_MBA);
+	u32 num_closid =3D resctrl_arch_get_num_closid(r);
+	struct rdt_ctrl_domain *d;
+	unsigned long fflags;
+	int i;
+
+	if (!supports_mba_mbps() || mba_sc =3D=3D is_mba_sc(r))
+		return -EINVAL;
+
+	r->membw.mba_sc =3D mba_sc;
+
+	rdtgroup_default.mba_mbps_event =3D mba_mbps_default_event;
+
+	list_for_each_entry(d, &r->ctrl_domains, hdr.list) {
+		for (i =3D 0; i < num_closid; i++)
+			d->mbps_val[i] =3D MBA_MAX_MBPS;
+	}
+
+	fflags =3D mba_sc ? RFTYPE_CTRL_BASE | RFTYPE_MON_BASE : 0;
+	resctrl_file_fflags_init("mba_MBps_event", fflags);
+
+	return 0;
+}
+
+/*
+ * We don't allow rdtgroup directories to be created anywhere
+ * except the root directory. Thus when looking for the rdtgroup
+ * structure for a kernfs node we are either looking at a directory,
+ * in which case the rdtgroup structure is pointed at by the "priv"
+ * field, otherwise we have a file, and need only look to the parent
+ * to find the rdtgroup.
+ */
+static struct rdtgroup *kernfs_to_rdtgroup(struct kernfs_node *kn)
+{
+	if (kernfs_type(kn) =3D=3D KERNFS_DIR) {
+		/*
+		 * All the resource directories use "kn->priv"
+		 * to point to the "struct rdtgroup" for the
+		 * resource. "info" and its subdirectories don't
+		 * have rdtgroup structures, so return NULL here.
+		 */
+		if (kn =3D=3D kn_info ||
+		    rcu_access_pointer(kn->__parent) =3D=3D kn_info)
+			return NULL;
+		else
+			return kn->priv;
+	} else {
+		return rdt_kn_parent_priv(kn);
+	}
+}
+
+static void rdtgroup_kn_get(struct rdtgroup *rdtgrp, struct kernfs_node *kn)
+{
+	atomic_inc(&rdtgrp->waitcount);
+	kernfs_break_active_protection(kn);
+}
+
+static void rdtgroup_kn_put(struct rdtgroup *rdtgrp, struct kernfs_node *kn)
+{
+	if (atomic_dec_and_test(&rdtgrp->waitcount) &&
+	    (rdtgrp->flags & RDT_DELETED)) {
+		if (rdtgrp->mode =3D=3D RDT_MODE_PSEUDO_LOCKSETUP ||
+		    rdtgrp->mode =3D=3D RDT_MODE_PSEUDO_LOCKED)
+			rdtgroup_pseudo_lock_remove(rdtgrp);
+		kernfs_unbreak_active_protection(kn);
+		rdtgroup_remove(rdtgrp);
+	} else {
+		kernfs_unbreak_active_protection(kn);
+	}
+}
+
+struct rdtgroup *rdtgroup_kn_lock_live(struct kernfs_node *kn)
+{
+	struct rdtgroup *rdtgrp =3D kernfs_to_rdtgroup(kn);
+
+	if (!rdtgrp)
+		return NULL;
+
+	rdtgroup_kn_get(rdtgrp, kn);
+
+	cpus_read_lock();
+	mutex_lock(&rdtgroup_mutex);
+
+	/* Was this group deleted while we waited? */
+	if (rdtgrp->flags & RDT_DELETED)
+		return NULL;
+
+	return rdtgrp;
+}
+
+void rdtgroup_kn_unlock(struct kernfs_node *kn)
+{
+	struct rdtgroup *rdtgrp =3D kernfs_to_rdtgroup(kn);
+
+	if (!rdtgrp)
+		return;
+
+	mutex_unlock(&rdtgroup_mutex);
+	cpus_read_unlock();
+
+	rdtgroup_kn_put(rdtgrp, kn);
+}
+
+static int mkdir_mondata_all(struct kernfs_node *parent_kn,
+			     struct rdtgroup *prgrp,
+			     struct kernfs_node **mon_data_kn);
+
+static void rdt_disable_ctx(void)
+{
+	resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L3, false);
+	resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L2, false);
+	set_mba_sc(false);
+
+	resctrl_debug =3D false;
+}
+
+static int rdt_enable_ctx(struct rdt_fs_context *ctx)
+{
+	int ret =3D 0;
+
+	if (ctx->enable_cdpl2) {
+		ret =3D resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L2, true);
+		if (ret)
+			goto out_done;
+	}
+
+	if (ctx->enable_cdpl3) {
+		ret =3D resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L3, true);
+		if (ret)
+			goto out_cdpl2;
+	}
+
+	if (ctx->enable_mba_mbps) {
+		ret =3D set_mba_sc(true);
+		if (ret)
+			goto out_cdpl3;
+	}
+
+	if (ctx->enable_debug)
+		resctrl_debug =3D true;
+
+	return 0;
+
+out_cdpl3:
+	resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L3, false);
+out_cdpl2:
+	resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L2, false);
+out_done:
+	return ret;
+}
+
+static int schemata_list_add(struct rdt_resource *r, enum resctrl_conf_type =
type)
+{
+	struct resctrl_schema *s;
+	const char *suffix =3D "";
+	int ret, cl;
+
+	s =3D kzalloc(sizeof(*s), GFP_KERNEL);
+	if (!s)
+		return -ENOMEM;
+
+	s->res =3D r;
+	s->num_closid =3D resctrl_arch_get_num_closid(r);
+	if (resctrl_arch_get_cdp_enabled(r->rid))
+		s->num_closid /=3D 2;
+
+	s->conf_type =3D type;
+	switch (type) {
+	case CDP_CODE:
+		suffix =3D "CODE";
+		break;
+	case CDP_DATA:
+		suffix =3D "DATA";
+		break;
+	case CDP_NONE:
+		suffix =3D "";
+		break;
+	}
+
+	ret =3D snprintf(s->name, sizeof(s->name), "%s%s", r->name, suffix);
+	if (ret >=3D sizeof(s->name)) {
+		kfree(s);
+		return -EINVAL;
+	}
+
+	cl =3D strlen(s->name);
+
+	/*
+	 * If CDP is supported by this resource, but not enabled,
+	 * include the suffix. This ensures the tabular format of the
+	 * schemata file does not change between mounts of the filesystem.
+	 */
+	if (r->cdp_capable && !resctrl_arch_get_cdp_enabled(r->rid))
+		cl +=3D 4;
+
+	if (cl > max_name_width)
+		max_name_width =3D cl;
+
+	switch (r->schema_fmt) {
+	case RESCTRL_SCHEMA_BITMAP:
+		s->fmt_str =3D "%d=3D%x";
+		break;
+	case RESCTRL_SCHEMA_RANGE:
+		s->fmt_str =3D "%d=3D%u";
+		break;
+	}
+
+	if (WARN_ON_ONCE(!s->fmt_str)) {
+		kfree(s);
+		return -EINVAL;
+	}
+
+	INIT_LIST_HEAD(&s->list);
+	list_add(&s->list, &resctrl_schema_all);
+
+	return 0;
+}
+
+static int schemata_list_create(void)
+{
+	struct rdt_resource *r;
+	int ret =3D 0;
+
+	for_each_alloc_capable_rdt_resource(r) {
+		if (resctrl_arch_get_cdp_enabled(r->rid)) {
+			ret =3D schemata_list_add(r, CDP_CODE);
+			if (ret)
+				break;
+
+			ret =3D schemata_list_add(r, CDP_DATA);
+		} else {
+			ret =3D schemata_list_add(r, CDP_NONE);
+		}
+
+		if (ret)
+			break;
+	}
+
+	return ret;
+}
+
+static void schemata_list_destroy(void)
+{
+	struct resctrl_schema *s, *tmp;
+
+	list_for_each_entry_safe(s, tmp, &resctrl_schema_all, list) {
+		list_del(&s->list);
+		kfree(s);
+	}
+}
+
+static int rdt_get_tree(struct fs_context *fc)
+{
+	struct rdt_fs_context *ctx =3D rdt_fc2context(fc);
+	unsigned long flags =3D RFTYPE_CTRL_BASE;
+	struct rdt_mon_domain *dom;
+	struct rdt_resource *r;
+	int ret;
+
+	cpus_read_lock();
+	mutex_lock(&rdtgroup_mutex);
+	/*
+	 * resctrl file system can only be mounted once.
+	 */
+	if (resctrl_mounted) {
+		ret =3D -EBUSY;
+		goto out;
+	}
+
+	ret =3D rdtgroup_setup_root(ctx);
+	if (ret)
+		goto out;
+
+	ret =3D rdt_enable_ctx(ctx);
+	if (ret)
+		goto out_root;
+
+	ret =3D schemata_list_create();
+	if (ret) {
+		schemata_list_destroy();
+		goto out_ctx;
+	}
+
+	ret =3D closid_init();
+	if (ret)
+		goto out_schemata_free;
+
+	if (resctrl_arch_mon_capable())
+		flags |=3D RFTYPE_MON;
+
+	ret =3D rdtgroup_add_files(rdtgroup_default.kn, flags);
+	if (ret)
+		goto out_closid_exit;
+
+	kernfs_activate(rdtgroup_default.kn);
+
+	ret =3D rdtgroup_create_info_dir(rdtgroup_default.kn);
+	if (ret < 0)
+		goto out_closid_exit;
+
+	if (resctrl_arch_mon_capable()) {
+		ret =3D mongroup_create_dir(rdtgroup_default.kn,
+					  &rdtgroup_default, "mon_groups",
+					  &kn_mongrp);
+		if (ret < 0)
+			goto out_info;
+
+		ret =3D mkdir_mondata_all(rdtgroup_default.kn,
+					&rdtgroup_default, &kn_mondata);
+		if (ret < 0)
+			goto out_mongrp;
+		rdtgroup_default.mon.mon_data_kn =3D kn_mondata;
+	}
+
+	ret =3D rdt_pseudo_lock_init();
+	if (ret)
+		goto out_mondata;
+
+	ret =3D kernfs_get_tree(fc);
+	if (ret < 0)
+		goto out_psl;
+
+	if (resctrl_arch_alloc_capable())
+		resctrl_arch_enable_alloc();
+	if (resctrl_arch_mon_capable())
+		resctrl_arch_enable_mon();
+
+	if (resctrl_arch_alloc_capable() || resctrl_arch_mon_capable())
+		resctrl_mounted =3D true;
+
+	if (resctrl_is_mbm_enabled()) {
+		r =3D resctrl_arch_get_resource(RDT_RESOURCE_L3);
+		list_for_each_entry(dom, &r->mon_domains, hdr.list)
+			mbm_setup_overflow_handler(dom, MBM_OVERFLOW_INTERVAL,
+						   RESCTRL_PICK_ANY_CPU);
+	}
+
+	goto out;
+
+out_psl:
+	rdt_pseudo_lock_release();
+out_mondata:
+	if (resctrl_arch_mon_capable())
+		kernfs_remove(kn_mondata);
+out_mongrp:
+	if (resctrl_arch_mon_capable())
+		kernfs_remove(kn_mongrp);
+out_info:
+	kernfs_remove(kn_info);
+out_closid_exit:
+	closid_exit();
+out_schemata_free:
+	schemata_list_destroy();
+out_ctx:
+	rdt_disable_ctx();
+out_root:
+	rdtgroup_destroy_root();
+out:
+	rdt_last_cmd_clear();
+	mutex_unlock(&rdtgroup_mutex);
+	cpus_read_unlock();
+	return ret;
+}
+
+enum rdt_param {
+	Opt_cdp,
+	Opt_cdpl2,
+	Opt_mba_mbps,
+	Opt_debug,
+	nr__rdt_params
+};
+
+static const struct fs_parameter_spec rdt_fs_parameters[] =3D {
+	fsparam_flag("cdp",		Opt_cdp),
+	fsparam_flag("cdpl2",		Opt_cdpl2),
+	fsparam_flag("mba_MBps",	Opt_mba_mbps),
+	fsparam_flag("debug",		Opt_debug),
+	{}
+};
+
+static int rdt_parse_param(struct fs_context *fc, struct fs_parameter *param)
+{
+	struct rdt_fs_context *ctx =3D rdt_fc2context(fc);
+	struct fs_parse_result result;
+	const char *msg;
+	int opt;
+
+	opt =3D fs_parse(fc, rdt_fs_parameters, param, &result);
+	if (opt < 0)
+		return opt;
+
+	switch (opt) {
+	case Opt_cdp:
+		ctx->enable_cdpl3 =3D true;
+		return 0;
+	case Opt_cdpl2:
+		ctx->enable_cdpl2 =3D true;
+		return 0;
+	case Opt_mba_mbps:
+		msg =3D "mba_MBps requires MBM and linear scale MBA at L3 scope";
+		if (!supports_mba_mbps())
+			return invalfc(fc, msg);
+		ctx->enable_mba_mbps =3D true;
+		return 0;
+	case Opt_debug:
+		ctx->enable_debug =3D true;
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+static void rdt_fs_context_free(struct fs_context *fc)
+{
+	struct rdt_fs_context *ctx =3D rdt_fc2context(fc);
+
+	kernfs_free_fs_context(fc);
+	kfree(ctx);
+}
+
+static const struct fs_context_operations rdt_fs_context_ops =3D {
+	.free		=3D rdt_fs_context_free,
+	.parse_param	=3D rdt_parse_param,
+	.get_tree	=3D rdt_get_tree,
+};
+
+static int rdt_init_fs_context(struct fs_context *fc)
+{
+	struct rdt_fs_context *ctx;
+
+	ctx =3D kzalloc(sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+
+	ctx->kfc.magic =3D RDTGROUP_SUPER_MAGIC;
+	fc->fs_private =3D &ctx->kfc;
+	fc->ops =3D &rdt_fs_context_ops;
+	put_user_ns(fc->user_ns);
+	fc->user_ns =3D get_user_ns(&init_user_ns);
+	fc->global =3D true;
+	return 0;
+}
+
+/*
+ * Move tasks from one to the other group. If @from is NULL, then all tasks
+ * in the systems are moved unconditionally (used for teardown).
+ *
+ * If @mask is not NULL the cpus on which moved tasks are running are set
+ * in that mask so the update smp function call is restricted to affected
+ * cpus.
+ */
+static void rdt_move_group_tasks(struct rdtgroup *from, struct rdtgroup *to,
+				 struct cpumask *mask)
+{
+	struct task_struct *p, *t;
+
+	read_lock(&tasklist_lock);
+	for_each_process_thread(p, t) {
+		if (!from || is_closid_match(t, from) ||
+		    is_rmid_match(t, from)) {
+			resctrl_arch_set_closid_rmid(t, to->closid,
+						     to->mon.rmid);
+
+			/*
+			 * Order the closid/rmid stores above before the loads
+			 * in task_curr(). This pairs with the full barrier
+			 * between the rq->curr update and
+			 * resctrl_arch_sched_in() during context switch.
+			 */
+			smp_mb();
+
+			/*
+			 * If the task is on a CPU, set the CPU in the mask.
+			 * The detection is inaccurate as tasks might move or
+			 * schedule before the smp function call takes place.
+			 * In such a case the function call is pointless, but
+			 * there is no other side effect.
+			 */
+			if (IS_ENABLED(CONFIG_SMP) && mask && task_curr(t))
+				cpumask_set_cpu(task_cpu(t), mask);
+		}
+	}
+	read_unlock(&tasklist_lock);
+}
+
+static void free_all_child_rdtgrp(struct rdtgroup *rdtgrp)
+{
+	struct rdtgroup *sentry, *stmp;
+	struct list_head *head;
+
+	head =3D &rdtgrp->mon.crdtgrp_list;
+	list_for_each_entry_safe(sentry, stmp, head, mon.crdtgrp_list) {
+		free_rmid(sentry->closid, sentry->mon.rmid);
+		list_del(&sentry->mon.crdtgrp_list);
+
+		if (atomic_read(&sentry->waitcount) !=3D 0)
+			sentry->flags =3D RDT_DELETED;
+		else
+			rdtgroup_remove(sentry);
+	}
+}
+
+/*
+ * Forcibly remove all of subdirectories under root.
+ */
+static void rmdir_all_sub(void)
+{
+	struct rdtgroup *rdtgrp, *tmp;
+
+	/* Move all tasks to the default resource group */
+	rdt_move_group_tasks(NULL, &rdtgroup_default, NULL);
+
+	list_for_each_entry_safe(rdtgrp, tmp, &rdt_all_groups, rdtgroup_list) {
+		/* Free any child rmids */
+		free_all_child_rdtgrp(rdtgrp);
+
+		/* Remove each rdtgroup other than root */
+		if (rdtgrp =3D=3D &rdtgroup_default)
+			continue;
+
+		if (rdtgrp->mode =3D=3D RDT_MODE_PSEUDO_LOCKSETUP ||
+		    rdtgrp->mode =3D=3D RDT_MODE_PSEUDO_LOCKED)
+			rdtgroup_pseudo_lock_remove(rdtgrp);
+
+		/*
+		 * Give any CPUs back to the default group. We cannot copy
+		 * cpu_online_mask because a CPU might have executed the
+		 * offline callback already, but is still marked online.
+		 */
+		cpumask_or(&rdtgroup_default.cpu_mask,
+			   &rdtgroup_default.cpu_mask, &rdtgrp->cpu_mask);
+
+		free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
+
+		kernfs_remove(rdtgrp->kn);
+		list_del(&rdtgrp->rdtgroup_list);
+
+		if (atomic_read(&rdtgrp->waitcount) !=3D 0)
+			rdtgrp->flags =3D RDT_DELETED;
+		else
+			rdtgroup_remove(rdtgrp);
+	}
+	/* Notify online CPUs to update per cpu storage and PQR_ASSOC MSR */
+	update_closid_rmid(cpu_online_mask, &rdtgroup_default);
+
+	kernfs_remove(kn_info);
+	kernfs_remove(kn_mongrp);
+	kernfs_remove(kn_mondata);
+}
+
+/**
+ * mon_get_kn_priv() - Get the mon_data priv data for this event.
+ *
+ * The same values are used across the mon_data directories of all control a=
nd
+ * monitor groups for the same event in the same domain. Keep a list of
+ * allocated structures and re-use an existing one with the same values for
+ * @rid, @domid, etc.
+ *
+ * @rid:    The resource id for the event file being created.
+ * @domid:  The domain id for the event file being created.
+ * @mevt:   The type of event file being created.
+ * @do_sum: Whether SNC summing monitors are being created.
+ */
+static struct mon_data *mon_get_kn_priv(enum resctrl_res_level rid, int domi=
d,
+					struct mon_evt *mevt,
+					bool do_sum)
+{
+	struct mon_data *priv;
+
+	lockdep_assert_held(&rdtgroup_mutex);
+
+	list_for_each_entry(priv, &mon_data_kn_priv_list, list) {
+		if (priv->rid =3D=3D rid && priv->domid =3D=3D domid &&
+		    priv->sum =3D=3D do_sum && priv->evtid =3D=3D mevt->evtid)
+			return priv;
+	}
+
+	priv =3D kzalloc(sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return NULL;
+
+	priv->rid =3D rid;
+	priv->domid =3D domid;
+	priv->sum =3D do_sum;
+	priv->evtid =3D mevt->evtid;
+	list_add_tail(&priv->list, &mon_data_kn_priv_list);
+
+	return priv;
+}
+
+/**
+ * mon_put_kn_priv() - Free all allocated mon_data structures.
+ *
+ * Called when resctrl file system is unmounted.
+ */
+static void mon_put_kn_priv(void)
+{
+	struct mon_data *priv, *tmp;
+
+	lockdep_assert_held(&rdtgroup_mutex);
+
+	list_for_each_entry_safe(priv, tmp, &mon_data_kn_priv_list, list) {
+		list_del(&priv->list);
+		kfree(priv);
+	}
+}
+
+static void resctrl_fs_teardown(void)
+{
+	lockdep_assert_held(&rdtgroup_mutex);
+
+	/* Cleared by rdtgroup_destroy_root() */
+	if (!rdtgroup_default.kn)
+		return;
+
+	rmdir_all_sub();
+	mon_put_kn_priv();
+	rdt_pseudo_lock_release();
+	rdtgroup_default.mode =3D RDT_MODE_SHAREABLE;
+	closid_exit();
+	schemata_list_destroy();
+	rdtgroup_destroy_root();
+}
+
+static void rdt_kill_sb(struct super_block *sb)
+{
+	struct rdt_resource *r;
+
+	cpus_read_lock();
+	mutex_lock(&rdtgroup_mutex);
+
+	rdt_disable_ctx();
+
+	/* Put everything back to default values. */
+	for_each_alloc_capable_rdt_resource(r)
+		resctrl_arch_reset_all_ctrls(r);
+
+	resctrl_fs_teardown();
+	if (resctrl_arch_alloc_capable())
+		resctrl_arch_disable_alloc();
+	if (resctrl_arch_mon_capable())
+		resctrl_arch_disable_mon();
+	resctrl_mounted =3D false;
+	kernfs_kill_sb(sb);
+	mutex_unlock(&rdtgroup_mutex);
+	cpus_read_unlock();
+}
+
+static struct file_system_type rdt_fs_type =3D {
+	.name			=3D "resctrl",
+	.init_fs_context	=3D rdt_init_fs_context,
+	.parameters		=3D rdt_fs_parameters,
+	.kill_sb		=3D rdt_kill_sb,
+};
+
+static int mon_addfile(struct kernfs_node *parent_kn, const char *name,
+		       void *priv)
+{
+	struct kernfs_node *kn;
+	int ret =3D 0;
+
+	kn =3D __kernfs_create_file(parent_kn, name, 0444,
+				  GLOBAL_ROOT_UID, GLOBAL_ROOT_GID, 0,
+				  &kf_mondata_ops, priv, NULL, NULL);
+	if (IS_ERR(kn))
+		return PTR_ERR(kn);
+
+	ret =3D rdtgroup_kn_set_ugid(kn);
+	if (ret) {
+		kernfs_remove(kn);
+		return ret;
+	}
+
+	return ret;
+}
+
+static void mon_rmdir_one_subdir(struct kernfs_node *pkn, char *name, char *=
subname)
+{
+	struct kernfs_node *kn;
+
+	kn =3D kernfs_find_and_get(pkn, name);
+	if (!kn)
+		return;
+	kernfs_put(kn);
+
+	if (kn->dir.subdirs <=3D 1)
+		kernfs_remove(kn);
+	else
+		kernfs_remove_by_name(kn, subname);
+}
+
+/*
+ * Remove all subdirectories of mon_data of ctrl_mon groups
+ * and monitor groups for the given domain.
+ * Remove files and directories containing "sum" of domain data
+ * when last domain being summed is removed.
+ */
+static void rmdir_mondata_subdir_allrdtgrp(struct rdt_resource *r,
+					   struct rdt_mon_domain *d)
+{
+	struct rdtgroup *prgrp, *crgrp;
+	char subname[32];
+	bool snc_mode;
+	char name[32];
+
+	snc_mode =3D r->mon_scope =3D=3D RESCTRL_L3_NODE;
+	sprintf(name, "mon_%s_%02d", r->name, snc_mode ? d->ci->id : d->hdr.id);
+	if (snc_mode)
+		sprintf(subname, "mon_sub_%s_%02d", r->name, d->hdr.id);
+
+	list_for_each_entry(prgrp, &rdt_all_groups, rdtgroup_list) {
+		mon_rmdir_one_subdir(prgrp->mon.mon_data_kn, name, subname);
+
+		list_for_each_entry(crgrp, &prgrp->mon.crdtgrp_list, mon.crdtgrp_list)
+			mon_rmdir_one_subdir(crgrp->mon.mon_data_kn, name, subname);
+	}
+}
+
+static int mon_add_all_files(struct kernfs_node *kn, struct rdt_mon_domain *=
d,
+			     struct rdt_resource *r, struct rdtgroup *prgrp,
+			     bool do_sum)
+{
+	struct rmid_read rr =3D {0};
+	struct mon_data *priv;
+	struct mon_evt *mevt;
+	int ret, domid;
+
+	if (WARN_ON(list_empty(&r->evt_list)))
+		return -EPERM;
+
+	list_for_each_entry(mevt, &r->evt_list, list) {
+		domid =3D do_sum ? d->ci->id : d->hdr.id;
+		priv =3D mon_get_kn_priv(r->rid, domid, mevt, do_sum);
+		if (WARN_ON_ONCE(!priv))
+			return -EINVAL;
+
+		ret =3D mon_addfile(kn, mevt->name, priv);
+		if (ret)
+			return ret;
+
+		if (!do_sum && resctrl_is_mbm_event(mevt->evtid))
+			mon_event_read(&rr, r, d, prgrp, &d->hdr.cpu_mask, mevt->evtid, true);
+	}
+
+	return 0;
+}
+
+static int mkdir_mondata_subdir(struct kernfs_node *parent_kn,
+				struct rdt_mon_domain *d,
+				struct rdt_resource *r, struct rdtgroup *prgrp)
+{
+	struct kernfs_node *kn, *ckn;
+	char name[32];
+	bool snc_mode;
+	int ret =3D 0;
+
+	lockdep_assert_held(&rdtgroup_mutex);
+
+	snc_mode =3D r->mon_scope =3D=3D RESCTRL_L3_NODE;
+	sprintf(name, "mon_%s_%02d", r->name, snc_mode ? d->ci->id : d->hdr.id);
+	kn =3D kernfs_find_and_get(parent_kn, name);
+	if (kn) {
+		/*
+		 * rdtgroup_mutex will prevent this directory from being
+		 * removed. No need to keep this hold.
+		 */
+		kernfs_put(kn);
+	} else {
+		kn =3D kernfs_create_dir(parent_kn, name, parent_kn->mode, prgrp);
+		if (IS_ERR(kn))
+			return PTR_ERR(kn);
+
+		ret =3D rdtgroup_kn_set_ugid(kn);
+		if (ret)
+			goto out_destroy;
+		ret =3D mon_add_all_files(kn, d, r, prgrp, snc_mode);
+		if (ret)
+			goto out_destroy;
+	}
+
+	if (snc_mode) {
+		sprintf(name, "mon_sub_%s_%02d", r->name, d->hdr.id);
+		ckn =3D kernfs_create_dir(kn, name, parent_kn->mode, prgrp);
+		if (IS_ERR(ckn)) {
+			ret =3D -EINVAL;
+			goto out_destroy;
+		}
+
+		ret =3D rdtgroup_kn_set_ugid(ckn);
+		if (ret)
+			goto out_destroy;
+
+		ret =3D mon_add_all_files(ckn, d, r, prgrp, false);
+		if (ret)
+			goto out_destroy;
+	}
+
+	kernfs_activate(kn);
+	return 0;
+
+out_destroy:
+	kernfs_remove(kn);
+	return ret;
+}
+
+/*
+ * Add all subdirectories of mon_data for "ctrl_mon" groups
+ * and "monitor" groups with given domain id.
+ */
+static void mkdir_mondata_subdir_allrdtgrp(struct rdt_resource *r,
+					   struct rdt_mon_domain *d)
+{
+	struct kernfs_node *parent_kn;
+	struct rdtgroup *prgrp, *crgrp;
+	struct list_head *head;
+
+	list_for_each_entry(prgrp, &rdt_all_groups, rdtgroup_list) {
+		parent_kn =3D prgrp->mon.mon_data_kn;
+		mkdir_mondata_subdir(parent_kn, d, r, prgrp);
+
+		head =3D &prgrp->mon.crdtgrp_list;
+		list_for_each_entry(crgrp, head, mon.crdtgrp_list) {
+			parent_kn =3D crgrp->mon.mon_data_kn;
+			mkdir_mondata_subdir(parent_kn, d, r, crgrp);
+		}
+	}
+}
+
+static int mkdir_mondata_subdir_alldom(struct kernfs_node *parent_kn,
+				       struct rdt_resource *r,
+				       struct rdtgroup *prgrp)
+{
+	struct rdt_mon_domain *dom;
+	int ret;
+
+	/* Walking r->domains, ensure it can't race with cpuhp */
+	lockdep_assert_cpus_held();
+
+	list_for_each_entry(dom, &r->mon_domains, hdr.list) {
+		ret =3D mkdir_mondata_subdir(parent_kn, dom, r, prgrp);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+/*
+ * This creates a directory mon_data which contains the monitored data.
+ *
+ * mon_data has one directory for each domain which are named
+ * in the format mon_<domain_name>_<domain_id>. For ex: A mon_data
+ * with L3 domain looks as below:
+ * ./mon_data:
+ * mon_L3_00
+ * mon_L3_01
+ * mon_L3_02
+ * ...
+ *
+ * Each domain directory has one file per event:
+ * ./mon_L3_00/:
+ * llc_occupancy
+ *
+ */
+static int mkdir_mondata_all(struct kernfs_node *parent_kn,
+			     struct rdtgroup *prgrp,
+			     struct kernfs_node **dest_kn)
+{
+	struct rdt_resource *r;
+	struct kernfs_node *kn;
+	int ret;
+
+	/*
+	 * Create the mon_data directory first.
+	 */
+	ret =3D mongroup_create_dir(parent_kn, prgrp, "mon_data", &kn);
+	if (ret)
+		return ret;
+
+	if (dest_kn)
+		*dest_kn =3D kn;
+
+	/*
+	 * Create the subdirectories for each domain. Note that all events
+	 * in a domain like L3 are grouped into a resource whose domain is L3
+	 */
+	for_each_mon_capable_rdt_resource(r) {
+		ret =3D mkdir_mondata_subdir_alldom(kn, r, prgrp);
+		if (ret)
+			goto out_destroy;
+	}
+
+	return 0;
+
+out_destroy:
+	kernfs_remove(kn);
+	return ret;
+}
+
+/**
+ * cbm_ensure_valid - Enforce validity on provided CBM
+ * @_val:	Candidate CBM
+ * @r:		RDT resource to which the CBM belongs
+ *
+ * The provided CBM represents all cache portions available for use. This
+ * may be represented by a bitmap that does not consist of contiguous ones
+ * and thus be an invalid CBM.
+ * Here the provided CBM is forced to be a valid CBM by only considering
+ * the first set of contiguous bits as valid and clearing all bits.
+ * The intention here is to provide a valid default CBM with which a new
+ * resource group is initialized. The user can follow this with a
+ * modification to the CBM if the default does not satisfy the
+ * requirements.
+ */
+static u32 cbm_ensure_valid(u32 _val, struct rdt_resource *r)
+{
+	unsigned int cbm_len =3D r->cache.cbm_len;
+	unsigned long first_bit, zero_bit;
+	unsigned long val =3D _val;
+
+	if (!val)
+		return 0;
+
+	first_bit =3D find_first_bit(&val, cbm_len);
+	zero_bit =3D find_next_zero_bit(&val, cbm_len, first_bit);
+
+	/* Clear any remaining bits to ensure contiguous region */
+	bitmap_clear(&val, zero_bit, cbm_len - zero_bit);
+	return (u32)val;
+}
+
+/*
+ * Initialize cache resources per RDT domain
+ *
+ * Set the RDT domain up to start off with all usable allocations. That is,
+ * all shareable and unused bits. All-zero CBM is invalid.
+ */
+static int __init_one_rdt_domain(struct rdt_ctrl_domain *d, struct resctrl_s=
chema *s,
+				 u32 closid)
+{
+	enum resctrl_conf_type peer_type =3D resctrl_peer_type(s->conf_type);
+	enum resctrl_conf_type t =3D s->conf_type;
+	struct resctrl_staged_config *cfg;
+	struct rdt_resource *r =3D s->res;
+	u32 used_b =3D 0, unused_b =3D 0;
+	unsigned long tmp_cbm;
+	enum rdtgrp_mode mode;
+	u32 peer_ctl, ctrl_val;
+	int i;
+
+	cfg =3D &d->staged_config[t];
+	cfg->have_new_ctrl =3D false;
+	cfg->new_ctrl =3D r->cache.shareable_bits;
+	used_b =3D r->cache.shareable_bits;
+	for (i =3D 0; i < closids_supported(); i++) {
+		if (closid_allocated(i) && i !=3D closid) {
+			mode =3D rdtgroup_mode_by_closid(i);
+			if (mode =3D=3D RDT_MODE_PSEUDO_LOCKSETUP)
+				/*
+				 * ctrl values for locksetup aren't relevant
+				 * until the schemata is written, and the mode
+				 * becomes RDT_MODE_PSEUDO_LOCKED.
+				 */
+				continue;
+			/*
+			 * If CDP is active include peer domain's
+			 * usage to ensure there is no overlap
+			 * with an exclusive group.
+			 */
+			if (resctrl_arch_get_cdp_enabled(r->rid))
+				peer_ctl =3D resctrl_arch_get_config(r, d, i,
+								   peer_type);
+			else
+				peer_ctl =3D 0;
+			ctrl_val =3D resctrl_arch_get_config(r, d, i,
+							   s->conf_type);
+			used_b |=3D ctrl_val | peer_ctl;
+			if (mode =3D=3D RDT_MODE_SHAREABLE)
+				cfg->new_ctrl |=3D ctrl_val | peer_ctl;
+		}
+	}
+	if (d->plr && d->plr->cbm > 0)
+		used_b |=3D d->plr->cbm;
+	unused_b =3D used_b ^ (BIT_MASK(r->cache.cbm_len) - 1);
+	unused_b &=3D BIT_MASK(r->cache.cbm_len) - 1;
+	cfg->new_ctrl |=3D unused_b;
+	/*
+	 * Force the initial CBM to be valid, user can
+	 * modify the CBM based on system availability.
+	 */
+	cfg->new_ctrl =3D cbm_ensure_valid(cfg->new_ctrl, r);
+	/*
+	 * Assign the u32 CBM to an unsigned long to ensure that
+	 * bitmap_weight() does not access out-of-bound memory.
+	 */
+	tmp_cbm =3D cfg->new_ctrl;
+	if (bitmap_weight(&tmp_cbm, r->cache.cbm_len) < r->cache.min_cbm_bits) {
+		rdt_last_cmd_printf("No space on %s:%d\n", s->name, d->hdr.id);
+		return -ENOSPC;
+	}
+	cfg->have_new_ctrl =3D true;
+
+	return 0;
+}
+
+/*
+ * Initialize cache resources with default values.
+ *
+ * A new RDT group is being created on an allocation capable (CAT)
+ * supporting system. Set this group up to start off with all usable
+ * allocations.
+ *
+ * If there are no more shareable bits available on any domain then
+ * the entire allocation will fail.
+ */
+static int rdtgroup_init_cat(struct resctrl_schema *s, u32 closid)
+{
+	struct rdt_ctrl_domain *d;
+	int ret;
+
+	list_for_each_entry(d, &s->res->ctrl_domains, hdr.list) {
+		ret =3D __init_one_rdt_domain(d, s, closid);
+		if (ret < 0)
+			return ret;
+	}
+
+	return 0;
+}
+
+/* Initialize MBA resource with default values. */
+static void rdtgroup_init_mba(struct rdt_resource *r, u32 closid)
+{
+	struct resctrl_staged_config *cfg;
+	struct rdt_ctrl_domain *d;
+
+	list_for_each_entry(d, &r->ctrl_domains, hdr.list) {
+		if (is_mba_sc(r)) {
+			d->mbps_val[closid] =3D MBA_MAX_MBPS;
+			continue;
+		}
+
+		cfg =3D &d->staged_config[CDP_NONE];
+		cfg->new_ctrl =3D resctrl_get_default_ctrl(r);
+		cfg->have_new_ctrl =3D true;
+	}
+}
+
+/* Initialize the RDT group's allocations. */
+static int rdtgroup_init_alloc(struct rdtgroup *rdtgrp)
+{
+	struct resctrl_schema *s;
+	struct rdt_resource *r;
+	int ret =3D 0;
+
+	rdt_staged_configs_clear();
+
+	list_for_each_entry(s, &resctrl_schema_all, list) {
+		r =3D s->res;
+		if (r->rid =3D=3D RDT_RESOURCE_MBA ||
+		    r->rid =3D=3D RDT_RESOURCE_SMBA) {
+			rdtgroup_init_mba(r, rdtgrp->closid);
+			if (is_mba_sc(r))
+				continue;
+		} else {
+			ret =3D rdtgroup_init_cat(s, rdtgrp->closid);
+			if (ret < 0)
+				goto out;
+		}
+
+		ret =3D resctrl_arch_update_domains(r, rdtgrp->closid);
+		if (ret < 0) {
+			rdt_last_cmd_puts("Failed to initialize allocations\n");
+			goto out;
+		}
+	}
+
+	rdtgrp->mode =3D RDT_MODE_SHAREABLE;
+
+out:
+	rdt_staged_configs_clear();
+	return ret;
+}
+
+static int mkdir_rdt_prepare_rmid_alloc(struct rdtgroup *rdtgrp)
+{
+	int ret;
+
+	if (!resctrl_arch_mon_capable())
+		return 0;
+
+	ret =3D alloc_rmid(rdtgrp->closid);
+	if (ret < 0) {
+		rdt_last_cmd_puts("Out of RMIDs\n");
+		return ret;
+	}
+	rdtgrp->mon.rmid =3D ret;
+
+	ret =3D mkdir_mondata_all(rdtgrp->kn, rdtgrp, &rdtgrp->mon.mon_data_kn);
+	if (ret) {
+		rdt_last_cmd_puts("kernfs subdir error\n");
+		free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
+		return ret;
+	}
+
+	return 0;
+}
+
+static void mkdir_rdt_prepare_rmid_free(struct rdtgroup *rgrp)
+{
+	if (resctrl_arch_mon_capable())
+		free_rmid(rgrp->closid, rgrp->mon.rmid);
+}
+
+/*
+ * We allow creating mon groups only with in a directory called "mon_groups"
+ * which is present in every ctrl_mon group. Check if this is a valid
+ * "mon_groups" directory.
+ *
+ * 1. The directory should be named "mon_groups".
+ * 2. The mon group itself should "not" be named "mon_groups".
+ *   This makes sure "mon_groups" directory always has a ctrl_mon group
+ *   as parent.
+ */
+static bool is_mon_groups(struct kernfs_node *kn, const char *name)
+{
+	return (!strcmp(rdt_kn_name(kn), "mon_groups") &&
+		strcmp(name, "mon_groups"));
+}
+
+static int mkdir_rdt_prepare(struct kernfs_node *parent_kn,
+			     const char *name, umode_t mode,
+			     enum rdt_group_type rtype, struct rdtgroup **r)
+{
+	struct rdtgroup *prdtgrp, *rdtgrp;
+	unsigned long files =3D 0;
+	struct kernfs_node *kn;
+	int ret;
+
+	prdtgrp =3D rdtgroup_kn_lock_live(parent_kn);
+	if (!prdtgrp) {
+		ret =3D -ENODEV;
+		goto out_unlock;
+	}
+
+	/*
+	 * Check that the parent directory for a monitor group is a "mon_groups"
+	 * directory.
+	 */
+	if (rtype =3D=3D RDTMON_GROUP && !is_mon_groups(parent_kn, name)) {
+		ret =3D -EPERM;
+		goto out_unlock;
+	}
+
+	if (rtype =3D=3D RDTMON_GROUP &&
+	    (prdtgrp->mode =3D=3D RDT_MODE_PSEUDO_LOCKSETUP ||
+	     prdtgrp->mode =3D=3D RDT_MODE_PSEUDO_LOCKED)) {
+		ret =3D -EINVAL;
+		rdt_last_cmd_puts("Pseudo-locking in progress\n");
+		goto out_unlock;
+	}
+
+	/* allocate the rdtgroup. */
+	rdtgrp =3D kzalloc(sizeof(*rdtgrp), GFP_KERNEL);
+	if (!rdtgrp) {
+		ret =3D -ENOSPC;
+		rdt_last_cmd_puts("Kernel out of memory\n");
+		goto out_unlock;
+	}
+	*r =3D rdtgrp;
+	rdtgrp->mon.parent =3D prdtgrp;
+	rdtgrp->type =3D rtype;
+	INIT_LIST_HEAD(&rdtgrp->mon.crdtgrp_list);
+
+	/* kernfs creates the directory for rdtgrp */
+	kn =3D kernfs_create_dir(parent_kn, name, mode, rdtgrp);
+	if (IS_ERR(kn)) {
+		ret =3D PTR_ERR(kn);
+		rdt_last_cmd_puts("kernfs create error\n");
+		goto out_free_rgrp;
+	}
+	rdtgrp->kn =3D kn;
+
+	/*
+	 * kernfs_remove() will drop the reference count on "kn" which
+	 * will free it. But we still need it to stick around for the
+	 * rdtgroup_kn_unlock(kn) call. Take one extra reference here,
+	 * which will be dropped by kernfs_put() in rdtgroup_remove().
+	 */
+	kernfs_get(kn);
+
+	ret =3D rdtgroup_kn_set_ugid(kn);
+	if (ret) {
+		rdt_last_cmd_puts("kernfs perm error\n");
+		goto out_destroy;
+	}
+
+	if (rtype =3D=3D RDTCTRL_GROUP) {
+		files =3D RFTYPE_BASE | RFTYPE_CTRL;
+		if (resctrl_arch_mon_capable())
+			files |=3D RFTYPE_MON;
+	} else {
+		files =3D RFTYPE_BASE | RFTYPE_MON;
+	}
+
+	ret =3D rdtgroup_add_files(kn, files);
+	if (ret) {
+		rdt_last_cmd_puts("kernfs fill error\n");
+		goto out_destroy;
+	}
+
+	/*
+	 * The caller unlocks the parent_kn upon success.
+	 */
+	return 0;
+
+out_destroy:
+	kernfs_put(rdtgrp->kn);
+	kernfs_remove(rdtgrp->kn);
+out_free_rgrp:
+	kfree(rdtgrp);
+out_unlock:
+	rdtgroup_kn_unlock(parent_kn);
+	return ret;
+}
+
+static void mkdir_rdt_prepare_clean(struct rdtgroup *rgrp)
+{
+	kernfs_remove(rgrp->kn);
+	rdtgroup_remove(rgrp);
+}
+
+/*
+ * Create a monitor group under "mon_groups" directory of a control
+ * and monitor group(ctrl_mon). This is a resource group
+ * to monitor a subset of tasks and cpus in its parent ctrl_mon group.
+ */
+static int rdtgroup_mkdir_mon(struct kernfs_node *parent_kn,
+			      const char *name, umode_t mode)
+{
+	struct rdtgroup *rdtgrp, *prgrp;
+	int ret;
+
+	ret =3D mkdir_rdt_prepare(parent_kn, name, mode, RDTMON_GROUP, &rdtgrp);
+	if (ret)
+		return ret;
+
+	prgrp =3D rdtgrp->mon.parent;
+	rdtgrp->closid =3D prgrp->closid;
+
+	ret =3D mkdir_rdt_prepare_rmid_alloc(rdtgrp);
+	if (ret) {
+		mkdir_rdt_prepare_clean(rdtgrp);
+		goto out_unlock;
+	}
+
+	kernfs_activate(rdtgrp->kn);
+
+	/*
+	 * Add the rdtgrp to the list of rdtgrps the parent
+	 * ctrl_mon group has to track.
+	 */
+	list_add_tail(&rdtgrp->mon.crdtgrp_list, &prgrp->mon.crdtgrp_list);
+
+out_unlock:
+	rdtgroup_kn_unlock(parent_kn);
+	return ret;
+}
+
+/*
+ * These are rdtgroups created under the root directory. Can be used
+ * to allocate and monitor resources.
+ */
+static int rdtgroup_mkdir_ctrl_mon(struct kernfs_node *parent_kn,
+				   const char *name, umode_t mode)
+{
+	struct rdtgroup *rdtgrp;
+	struct kernfs_node *kn;
+	u32 closid;
+	int ret;
+
+	ret =3D mkdir_rdt_prepare(parent_kn, name, mode, RDTCTRL_GROUP, &rdtgrp);
+	if (ret)
+		return ret;
+
+	kn =3D rdtgrp->kn;
+	ret =3D closid_alloc();
+	if (ret < 0) {
+		rdt_last_cmd_puts("Out of CLOSIDs\n");
+		goto out_common_fail;
+	}
+	closid =3D ret;
+	ret =3D 0;
+
+	rdtgrp->closid =3D closid;
+
+	ret =3D mkdir_rdt_prepare_rmid_alloc(rdtgrp);
+	if (ret)
+		goto out_closid_free;
+
+	kernfs_activate(rdtgrp->kn);
+
+	ret =3D rdtgroup_init_alloc(rdtgrp);
+	if (ret < 0)
+		goto out_rmid_free;
+
+	list_add(&rdtgrp->rdtgroup_list, &rdt_all_groups);
+
+	if (resctrl_arch_mon_capable()) {
+		/*
+		 * Create an empty mon_groups directory to hold the subset
+		 * of tasks and cpus to monitor.
+		 */
+		ret =3D mongroup_create_dir(kn, rdtgrp, "mon_groups", NULL);
+		if (ret) {
+			rdt_last_cmd_puts("kernfs subdir error\n");
+			goto out_del_list;
+		}
+		if (is_mba_sc(NULL))
+			rdtgrp->mba_mbps_event =3D mba_mbps_default_event;
+	}
+
+	goto out_unlock;
+
+out_del_list:
+	list_del(&rdtgrp->rdtgroup_list);
+out_rmid_free:
+	mkdir_rdt_prepare_rmid_free(rdtgrp);
+out_closid_free:
+	closid_free(closid);
+out_common_fail:
+	mkdir_rdt_prepare_clean(rdtgrp);
+out_unlock:
+	rdtgroup_kn_unlock(parent_kn);
+	return ret;
+}
+
+static int rdtgroup_mkdir(struct kernfs_node *parent_kn, const char *name,
+			  umode_t mode)
+{
+	/* Do not accept '\n' to avoid unparsable situation. */
+	if (strchr(name, '\n'))
+		return -EINVAL;
+
+	/*
+	 * If the parent directory is the root directory and RDT
+	 * allocation is supported, add a control and monitoring
+	 * subdirectory
+	 */
+	if (resctrl_arch_alloc_capable() && parent_kn =3D=3D rdtgroup_default.kn)
+		return rdtgroup_mkdir_ctrl_mon(parent_kn, name, mode);
+
+	/* Else, attempt to add a monitoring subdirectory. */
+	if (resctrl_arch_mon_capable())
+		return rdtgroup_mkdir_mon(parent_kn, name, mode);
+
+	return -EPERM;
+}
+
+static int rdtgroup_rmdir_mon(struct rdtgroup *rdtgrp, cpumask_var_t tmpmask)
+{
+	struct rdtgroup *prdtgrp =3D rdtgrp->mon.parent;
+	u32 closid, rmid;
+	int cpu;
+
+	/* Give any tasks back to the parent group */
+	rdt_move_group_tasks(rdtgrp, prdtgrp, tmpmask);
+
+	/*
+	 * Update per cpu closid/rmid of the moved CPUs first.
+	 * Note: the closid will not change, but the arch code still needs it.
+	 */
+	closid =3D prdtgrp->closid;
+	rmid =3D prdtgrp->mon.rmid;
+	for_each_cpu(cpu, &rdtgrp->cpu_mask)
+		resctrl_arch_set_cpu_default_closid_rmid(cpu, closid, rmid);
+
+	/*
+	 * Update the MSR on moved CPUs and CPUs which have moved
+	 * task running on them.
+	 */
+	cpumask_or(tmpmask, tmpmask, &rdtgrp->cpu_mask);
+	update_closid_rmid(tmpmask, NULL);
+
+	rdtgrp->flags =3D RDT_DELETED;
+	free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
+
+	/*
+	 * Remove the rdtgrp from the parent ctrl_mon group's list
+	 */
+	WARN_ON(list_empty(&prdtgrp->mon.crdtgrp_list));
+	list_del(&rdtgrp->mon.crdtgrp_list);
+
+	kernfs_remove(rdtgrp->kn);
+
+	return 0;
+}
+
+static int rdtgroup_ctrl_remove(struct rdtgroup *rdtgrp)
+{
+	rdtgrp->flags =3D RDT_DELETED;
+	list_del(&rdtgrp->rdtgroup_list);
+
+	kernfs_remove(rdtgrp->kn);
+	return 0;
+}
+
+static int rdtgroup_rmdir_ctrl(struct rdtgroup *rdtgrp, cpumask_var_t tmpmas=
k)
+{
+	u32 closid, rmid;
+	int cpu;
+
+	/* Give any tasks back to the default group */
+	rdt_move_group_tasks(rdtgrp, &rdtgroup_default, tmpmask);
+
+	/* Give any CPUs back to the default group */
+	cpumask_or(&rdtgroup_default.cpu_mask,
+		   &rdtgroup_default.cpu_mask, &rdtgrp->cpu_mask);
+
+	/* Update per cpu closid and rmid of the moved CPUs first */
+	closid =3D rdtgroup_default.closid;
+	rmid =3D rdtgroup_default.mon.rmid;
+	for_each_cpu(cpu, &rdtgrp->cpu_mask)
+		resctrl_arch_set_cpu_default_closid_rmid(cpu, closid, rmid);
+
+	/*
+	 * Update the MSR on moved CPUs and CPUs which have moved
+	 * task running on them.
+	 */
+	cpumask_or(tmpmask, tmpmask, &rdtgrp->cpu_mask);
+	update_closid_rmid(tmpmask, NULL);
+
+	free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
+	closid_free(rdtgrp->closid);
+
+	rdtgroup_ctrl_remove(rdtgrp);
+
+	/*
+	 * Free all the child monitor group rmids.
+	 */
+	free_all_child_rdtgrp(rdtgrp);
+
+	return 0;
+}
+
+static struct kernfs_node *rdt_kn_parent(struct kernfs_node *kn)
+{
+	/*
+	 * Valid within the RCU section it was obtained or while rdtgroup_mutex
+	 * is held.
+	 */
+	return rcu_dereference_check(kn->__parent, lockdep_is_held(&rdtgroup_mutex)=
);
+}
+
+static int rdtgroup_rmdir(struct kernfs_node *kn)
+{
+	struct kernfs_node *parent_kn;
+	struct rdtgroup *rdtgrp;
+	cpumask_var_t tmpmask;
+	int ret =3D 0;
+
+	if (!zalloc_cpumask_var(&tmpmask, GFP_KERNEL))
+		return -ENOMEM;
+
+	rdtgrp =3D rdtgroup_kn_lock_live(kn);
+	if (!rdtgrp) {
+		ret =3D -EPERM;
+		goto out;
+	}
+	parent_kn =3D rdt_kn_parent(kn);
+
+	/*
+	 * If the rdtgroup is a ctrl_mon group and parent directory
+	 * is the root directory, remove the ctrl_mon group.
+	 *
+	 * If the rdtgroup is a mon group and parent directory
+	 * is a valid "mon_groups" directory, remove the mon group.
+	 */
+	if (rdtgrp->type =3D=3D RDTCTRL_GROUP && parent_kn =3D=3D rdtgroup_default.=
kn &&
+	    rdtgrp !=3D &rdtgroup_default) {
+		if (rdtgrp->mode =3D=3D RDT_MODE_PSEUDO_LOCKSETUP ||
+		    rdtgrp->mode =3D=3D RDT_MODE_PSEUDO_LOCKED) {
+			ret =3D rdtgroup_ctrl_remove(rdtgrp);
+		} else {
+			ret =3D rdtgroup_rmdir_ctrl(rdtgrp, tmpmask);
+		}
+	} else if (rdtgrp->type =3D=3D RDTMON_GROUP &&
+		 is_mon_groups(parent_kn, rdt_kn_name(kn))) {
+		ret =3D rdtgroup_rmdir_mon(rdtgrp, tmpmask);
+	} else {
+		ret =3D -EPERM;
+	}
+
+out:
+	rdtgroup_kn_unlock(kn);
+	free_cpumask_var(tmpmask);
+	return ret;
+}
+
+/**
+ * mongrp_reparent() - replace parent CTRL_MON group of a MON group
+ * @rdtgrp:		the MON group whose parent should be replaced
+ * @new_prdtgrp:	replacement parent CTRL_MON group for @rdtgrp
+ * @cpus:		cpumask provided by the caller for use during this call
+ *
+ * Replaces the parent CTRL_MON group for a MON group, resulting in all memb=
er
+ * tasks' CLOSID immediately changing to that of the new parent group.
+ * Monitoring data for the group is unaffected by this operation.
+ */
+static void mongrp_reparent(struct rdtgroup *rdtgrp,
+			    struct rdtgroup *new_prdtgrp,
+			    cpumask_var_t cpus)
+{
+	struct rdtgroup *prdtgrp =3D rdtgrp->mon.parent;
+
+	WARN_ON(rdtgrp->type !=3D RDTMON_GROUP);
+	WARN_ON(new_prdtgrp->type !=3D RDTCTRL_GROUP);
+
+	/* Nothing to do when simply renaming a MON group. */
+	if (prdtgrp =3D=3D new_prdtgrp)
+		return;
+
+	WARN_ON(list_empty(&prdtgrp->mon.crdtgrp_list));
+	list_move_tail(&rdtgrp->mon.crdtgrp_list,
+		       &new_prdtgrp->mon.crdtgrp_list);
+
+	rdtgrp->mon.parent =3D new_prdtgrp;
+	rdtgrp->closid =3D new_prdtgrp->closid;
+
+	/* Propagate updated closid to all tasks in this group. */
+	rdt_move_group_tasks(rdtgrp, rdtgrp, cpus);
+
+	update_closid_rmid(cpus, NULL);
+}
+
+static int rdtgroup_rename(struct kernfs_node *kn,
+			   struct kernfs_node *new_parent, const char *new_name)
+{
+	struct kernfs_node *kn_parent;
+	struct rdtgroup *new_prdtgrp;
+	struct rdtgroup *rdtgrp;
+	cpumask_var_t tmpmask;
+	int ret;
+
+	rdtgrp =3D kernfs_to_rdtgroup(kn);
+	new_prdtgrp =3D kernfs_to_rdtgroup(new_parent);
+	if (!rdtgrp || !new_prdtgrp)
+		return -ENOENT;
+
+	/* Release both kernfs active_refs before obtaining rdtgroup mutex. */
+	rdtgroup_kn_get(rdtgrp, kn);
+	rdtgroup_kn_get(new_prdtgrp, new_parent);
+
+	mutex_lock(&rdtgroup_mutex);
+
+	rdt_last_cmd_clear();
+
+	/*
+	 * Don't allow kernfs_to_rdtgroup() to return a parent rdtgroup if
+	 * either kernfs_node is a file.
+	 */
+	if (kernfs_type(kn) !=3D KERNFS_DIR ||
+	    kernfs_type(new_parent) !=3D KERNFS_DIR) {
+		rdt_last_cmd_puts("Source and destination must be directories");
+		ret =3D -EPERM;
+		goto out;
+	}
+
+	if ((rdtgrp->flags & RDT_DELETED) || (new_prdtgrp->flags & RDT_DELETED)) {
+		ret =3D -ENOENT;
+		goto out;
+	}
+
+	kn_parent =3D rdt_kn_parent(kn);
+	if (rdtgrp->type !=3D RDTMON_GROUP || !kn_parent ||
+	    !is_mon_groups(kn_parent, rdt_kn_name(kn))) {
+		rdt_last_cmd_puts("Source must be a MON group\n");
+		ret =3D -EPERM;
+		goto out;
+	}
+
+	if (!is_mon_groups(new_parent, new_name)) {
+		rdt_last_cmd_puts("Destination must be a mon_groups subdirectory\n");
+		ret =3D -EPERM;
+		goto out;
+	}
+
+	/*
+	 * If the MON group is monitoring CPUs, the CPUs must be assigned to the
+	 * current parent CTRL_MON group and therefore cannot be assigned to
+	 * the new parent, making the move illegal.
+	 */
+	if (!cpumask_empty(&rdtgrp->cpu_mask) &&
+	    rdtgrp->mon.parent !=3D new_prdtgrp) {
+		rdt_last_cmd_puts("Cannot move a MON group that monitors CPUs\n");
+		ret =3D -EPERM;
+		goto out;
+	}
+
+	/*
+	 * Allocate the cpumask for use in mongrp_reparent() to avoid the
+	 * possibility of failing to allocate it after kernfs_rename() has
+	 * succeeded.
+	 */
+	if (!zalloc_cpumask_var(&tmpmask, GFP_KERNEL)) {
+		ret =3D -ENOMEM;
+		goto out;
+	}
+
+	/*
+	 * Perform all input validation and allocations needed to ensure
+	 * mongrp_reparent() will succeed before calling kernfs_rename(),
+	 * otherwise it would be necessary to revert this call if
+	 * mongrp_reparent() failed.
+	 */
+	ret =3D kernfs_rename(kn, new_parent, new_name);
+	if (!ret)
+		mongrp_reparent(rdtgrp, new_prdtgrp, tmpmask);
+
+	free_cpumask_var(tmpmask);
+
+out:
+	mutex_unlock(&rdtgroup_mutex);
+	rdtgroup_kn_put(rdtgrp, kn);
+	rdtgroup_kn_put(new_prdtgrp, new_parent);
+	return ret;
+}
+
+static int rdtgroup_show_options(struct seq_file *seq, struct kernfs_root *k=
f)
+{
+	if (resctrl_arch_get_cdp_enabled(RDT_RESOURCE_L3))
+		seq_puts(seq, ",cdp");
+
+	if (resctrl_arch_get_cdp_enabled(RDT_RESOURCE_L2))
+		seq_puts(seq, ",cdpl2");
+
+	if (is_mba_sc(resctrl_arch_get_resource(RDT_RESOURCE_MBA)))
+		seq_puts(seq, ",mba_MBps");
+
+	if (resctrl_debug)
+		seq_puts(seq, ",debug");
+
+	return 0;
+}
+
+static struct kernfs_syscall_ops rdtgroup_kf_syscall_ops =3D {
+	.mkdir		=3D rdtgroup_mkdir,
+	.rmdir		=3D rdtgroup_rmdir,
+	.rename		=3D rdtgroup_rename,
+	.show_options	=3D rdtgroup_show_options,
+};
+
+static int rdtgroup_setup_root(struct rdt_fs_context *ctx)
+{
+	rdt_root =3D kernfs_create_root(&rdtgroup_kf_syscall_ops,
+				      KERNFS_ROOT_CREATE_DEACTIVATED |
+				      KERNFS_ROOT_EXTRA_OPEN_PERM_CHECK,
+				      &rdtgroup_default);
+	if (IS_ERR(rdt_root))
+		return PTR_ERR(rdt_root);
+
+	ctx->kfc.root =3D rdt_root;
+	rdtgroup_default.kn =3D kernfs_root_to_node(rdt_root);
+
+	return 0;
+}
+
+static void rdtgroup_destroy_root(void)
+{
+	lockdep_assert_held(&rdtgroup_mutex);
+
+	kernfs_destroy_root(rdt_root);
+	rdtgroup_default.kn =3D NULL;
+}
+
+static void rdtgroup_setup_default(void)
+{
+	mutex_lock(&rdtgroup_mutex);
+
+	rdtgroup_default.closid =3D RESCTRL_RESERVED_CLOSID;
+	rdtgroup_default.mon.rmid =3D RESCTRL_RESERVED_RMID;
+	rdtgroup_default.type =3D RDTCTRL_GROUP;
+	INIT_LIST_HEAD(&rdtgroup_default.mon.crdtgrp_list);
+
+	list_add(&rdtgroup_default.rdtgroup_list, &rdt_all_groups);
+
+	mutex_unlock(&rdtgroup_mutex);
+}
+
+static void domain_destroy_mon_state(struct rdt_mon_domain *d)
+{
+	bitmap_free(d->rmid_busy_llc);
+	kfree(d->mbm_total);
+	kfree(d->mbm_local);
+}
+
+void resctrl_offline_ctrl_domain(struct rdt_resource *r, struct rdt_ctrl_dom=
ain *d)
+{
+	mutex_lock(&rdtgroup_mutex);
+
+	if (supports_mba_mbps() && r->rid =3D=3D RDT_RESOURCE_MBA)
+		mba_sc_domain_destroy(r, d);
+
+	mutex_unlock(&rdtgroup_mutex);
+}
+
+void resctrl_offline_mon_domain(struct rdt_resource *r, struct rdt_mon_domai=
n *d)
+{
+	mutex_lock(&rdtgroup_mutex);
+
+	/*
+	 * If resctrl is mounted, remove all the
+	 * per domain monitor data directories.
+	 */
+	if (resctrl_mounted && resctrl_arch_mon_capable())
+		rmdir_mondata_subdir_allrdtgrp(r, d);
+
+	if (resctrl_is_mbm_enabled())
+		cancel_delayed_work(&d->mbm_over);
+	if (resctrl_arch_is_llc_occupancy_enabled() && has_busy_rmid(d)) {
+		/*
+		 * When a package is going down, forcefully
+		 * decrement rmid->ebusy. There is no way to know
+		 * that the L3 was flushed and hence may lead to
+		 * incorrect counts in rare scenarios, but leaving
+		 * the RMID as busy creates RMID leaks if the
+		 * package never comes back.
+		 */
+		__check_limbo(d, true);
+		cancel_delayed_work(&d->cqm_limbo);
+	}
+
+	domain_destroy_mon_state(d);
+
+	mutex_unlock(&rdtgroup_mutex);
+}
+
+/**
+ * domain_setup_mon_state() -  Initialise domain monitoring structures.
+ * @r:	The resource for the newly online domain.
+ * @d:	The newly online domain.
+ *
+ * Allocate monitor resources that belong to this domain.
+ * Called when the first CPU of a domain comes online, regardless of whether
+ * the filesystem is mounted.
+ * During boot this may be called before global allocations have been made by
+ * resctrl_mon_resource_init().
+ *
+ * Returns 0 for success, or -ENOMEM.
+ */
+static int domain_setup_mon_state(struct rdt_resource *r, struct rdt_mon_dom=
ain *d)
+{
+	u32 idx_limit =3D resctrl_arch_system_num_rmid_idx();
+	size_t tsize;
+
+	if (resctrl_arch_is_llc_occupancy_enabled()) {
+		d->rmid_busy_llc =3D bitmap_zalloc(idx_limit, GFP_KERNEL);
+		if (!d->rmid_busy_llc)
+			return -ENOMEM;
+	}
+	if (resctrl_arch_is_mbm_total_enabled()) {
+		tsize =3D sizeof(*d->mbm_total);
+		d->mbm_total =3D kcalloc(idx_limit, tsize, GFP_KERNEL);
+		if (!d->mbm_total) {
+			bitmap_free(d->rmid_busy_llc);
+			return -ENOMEM;
+		}
+	}
+	if (resctrl_arch_is_mbm_local_enabled()) {
+		tsize =3D sizeof(*d->mbm_local);
+		d->mbm_local =3D kcalloc(idx_limit, tsize, GFP_KERNEL);
+		if (!d->mbm_local) {
+			bitmap_free(d->rmid_busy_llc);
+			kfree(d->mbm_total);
+			return -ENOMEM;
+		}
+	}
+
+	return 0;
+}
+
+int resctrl_online_ctrl_domain(struct rdt_resource *r, struct rdt_ctrl_domai=
n *d)
+{
+	int err =3D 0;
+
+	mutex_lock(&rdtgroup_mutex);
+
+	if (supports_mba_mbps() && r->rid =3D=3D RDT_RESOURCE_MBA) {
+		/* RDT_RESOURCE_MBA is never mon_capable */
+		err =3D mba_sc_domain_allocate(r, d);
+	}
+
+	mutex_unlock(&rdtgroup_mutex);
+
+	return err;
+}
+
+int resctrl_online_mon_domain(struct rdt_resource *r, struct rdt_mon_domain =
*d)
+{
+	int err;
+
+	mutex_lock(&rdtgroup_mutex);
+
+	err =3D domain_setup_mon_state(r, d);
+	if (err)
+		goto out_unlock;
+
+	if (resctrl_is_mbm_enabled()) {
+		INIT_DELAYED_WORK(&d->mbm_over, mbm_handle_overflow);
+		mbm_setup_overflow_handler(d, MBM_OVERFLOW_INTERVAL,
+					   RESCTRL_PICK_ANY_CPU);
+	}
+
+	if (resctrl_arch_is_llc_occupancy_enabled())
+		INIT_DELAYED_WORK(&d->cqm_limbo, cqm_handle_limbo);
+
+	/*
+	 * If the filesystem is not mounted then only the default resource group
+	 * exists. Creation of its directories is deferred until mount time
+	 * by rdt_get_tree() calling mkdir_mondata_all().
+	 * If resctrl is mounted, add per domain monitor data directories.
+	 */
+	if (resctrl_mounted && resctrl_arch_mon_capable())
+		mkdir_mondata_subdir_allrdtgrp(r, d);
+
+out_unlock:
+	mutex_unlock(&rdtgroup_mutex);
+
+	return err;
+}
+
+void resctrl_online_cpu(unsigned int cpu)
+{
+	mutex_lock(&rdtgroup_mutex);
+	/* The CPU is set in default rdtgroup after online. */
+	cpumask_set_cpu(cpu, &rdtgroup_default.cpu_mask);
+	mutex_unlock(&rdtgroup_mutex);
+}
+
+static void clear_childcpus(struct rdtgroup *r, unsigned int cpu)
+{
+	struct rdtgroup *cr;
+
+	list_for_each_entry(cr, &r->mon.crdtgrp_list, mon.crdtgrp_list) {
+		if (cpumask_test_and_clear_cpu(cpu, &cr->cpu_mask))
+			break;
+	}
+}
+
+static struct rdt_mon_domain *get_mon_domain_from_cpu(int cpu,
+						      struct rdt_resource *r)
+{
+	struct rdt_mon_domain *d;
+
+	lockdep_assert_cpus_held();
+
+	list_for_each_entry(d, &r->mon_domains, hdr.list) {
+		/* Find the domain that contains this CPU */
+		if (cpumask_test_cpu(cpu, &d->hdr.cpu_mask))
+			return d;
+	}
+
+	return NULL;
+}
+
+void resctrl_offline_cpu(unsigned int cpu)
+{
+	struct rdt_resource *l3 =3D resctrl_arch_get_resource(RDT_RESOURCE_L3);
+	struct rdt_mon_domain *d;
+	struct rdtgroup *rdtgrp;
+
+	mutex_lock(&rdtgroup_mutex);
+	list_for_each_entry(rdtgrp, &rdt_all_groups, rdtgroup_list) {
+		if (cpumask_test_and_clear_cpu(cpu, &rdtgrp->cpu_mask)) {
+			clear_childcpus(rdtgrp, cpu);
+			break;
+		}
+	}
+
+	if (!l3->mon_capable)
+		goto out_unlock;
+
+	d =3D get_mon_domain_from_cpu(cpu, l3);
+	if (d) {
+		if (resctrl_is_mbm_enabled() && cpu =3D=3D d->mbm_work_cpu) {
+			cancel_delayed_work(&d->mbm_over);
+			mbm_setup_overflow_handler(d, 0, cpu);
+		}
+		if (resctrl_arch_is_llc_occupancy_enabled() &&
+		    cpu =3D=3D d->cqm_work_cpu && has_busy_rmid(d)) {
+			cancel_delayed_work(&d->cqm_limbo);
+			cqm_setup_limbo_handler(d, 0, cpu);
+		}
+	}
+
+out_unlock:
+	mutex_unlock(&rdtgroup_mutex);
+}
+
+/*
+ * resctrl_init - resctrl filesystem initialization
+ *
+ * Setup resctrl file system including set up root, create mount point,
+ * register resctrl filesystem, and initialize files under root directory.
+ *
+ * Return: 0 on success or -errno
+ */
+int resctrl_init(void)
+{
+	int ret =3D 0;
+
+	seq_buf_init(&last_cmd_status, last_cmd_status_buf,
+		     sizeof(last_cmd_status_buf));
+
+	rdtgroup_setup_default();
+
+	thread_throttle_mode_init();
+
+	ret =3D resctrl_mon_resource_init();
+	if (ret)
+		return ret;
+
+	ret =3D sysfs_create_mount_point(fs_kobj, "resctrl");
+	if (ret) {
+		resctrl_mon_resource_exit();
+		return ret;
+	}
+
+	ret =3D register_filesystem(&rdt_fs_type);
+	if (ret)
+		goto cleanup_mountpoint;
+
+	/*
+	 * Adding the resctrl debugfs directory here may not be ideal since
+	 * it would let the resctrl debugfs directory appear on the debugfs
+	 * filesystem before the resctrl filesystem is mounted.
+	 * It may also be ok since that would enable debugging of RDT before
+	 * resctrl is mounted.
+	 * The reason why the debugfs directory is created here and not in
+	 * rdt_get_tree() is because rdt_get_tree() takes rdtgroup_mutex and
+	 * during the debugfs directory creation also &sb->s_type->i_mutex_key
+	 * (the lockdep class of inode->i_rwsem). Other filesystem
+	 * interactions (eg. SyS_getdents) have the lock ordering:
+	 * &sb->s_type->i_mutex_key --> &mm->mmap_lock
+	 * During mmap(), called with &mm->mmap_lock, the rdtgroup_mutex
+	 * is taken, thus creating dependency:
+	 * &mm->mmap_lock --> rdtgroup_mutex for the latter that can cause
+	 * issues considering the other two lock dependencies.
+	 * By creating the debugfs directory here we avoid a dependency
+	 * that may cause deadlock (even though file operations cannot
+	 * occur until the filesystem is mounted, but I do not know how to
+	 * tell lockdep that).
+	 */
+	debugfs_resctrl =3D debugfs_create_dir("resctrl", NULL);
+
+	return 0;
+
+cleanup_mountpoint:
+	sysfs_remove_mount_point(fs_kobj, "resctrl");
+	resctrl_mon_resource_exit();
+
+	return ret;
+}
+
+static bool resctrl_online_domains_exist(void)
+{
+	struct rdt_resource *r;
+
+	/*
+	 * Only walk capable resources to allow resctrl_arch_get_resource()
+	 * to return dummy 'not capable' resources.
+	 */
+	for_each_alloc_capable_rdt_resource(r) {
+		if (!list_empty(&r->ctrl_domains))
+			return true;
+	}
+
+	for_each_mon_capable_rdt_resource(r) {
+		if (!list_empty(&r->mon_domains))
+			return true;
+	}
+
+	return false;
+}
+
+/**
+ * resctrl_exit() - Remove the resctrl filesystem and free resources.
+ *
+ * Called by the architecture code in response to a fatal error.
+ * Removes resctrl files and structures from kernfs to prevent further
+ * configuration.
+ *
+ * When called by the architecture code, all CPUs and resctrl domains must be
+ * offline. This ensures the limbo and overflow handlers are not scheduled to
+ * run, meaning the data structures they access can be freed by
+ * resctrl_mon_resource_exit().
+ *
+ * After resctrl_exit() returns, the architecture code should return an
+ * error from all resctrl_arch_ functions that can do this.
+ * resctrl_arch_get_resource() must continue to return struct rdt_resources
+ * with the correct rid field to ensure the filesystem can be unmounted.
+ */
+void resctrl_exit(void)
+{
+	cpus_read_lock();
+	WARN_ON_ONCE(resctrl_online_domains_exist());
+
+	mutex_lock(&rdtgroup_mutex);
+	resctrl_fs_teardown();
+	mutex_unlock(&rdtgroup_mutex);
+
+	cpus_read_unlock();
+
+	debugfs_remove_recursive(debugfs_resctrl);
+	debugfs_resctrl =3D NULL;
+	unregister_filesystem(&rdt_fs_type);
+
+	/*
+	 * Do not remove the sysfs mount point added by resctrl_init() so that
+	 * it can be used to umount resctrl.
+	 */
+
+	resctrl_mon_resource_exit();
+}

