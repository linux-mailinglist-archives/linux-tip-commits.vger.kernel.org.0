Return-Path: <linux-tip-commits+bounces-6095-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A10C7B0217E
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Jul 2025 18:17:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35A24B6019E
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Jul 2025 16:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 650BF2F509B;
	Fri, 11 Jul 2025 16:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sK0Y1jXG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HbXRa6rh"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3552B2F49E6;
	Fri, 11 Jul 2025 16:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752250191; cv=none; b=Io1b5kKvLbt/9a8dl8TsT6hBU3aFtAfdv3Xkq3hCd6sy6jVyITFtnLMtAiVV/0TS945fShZrXqX5vNhuVLMAYimP2W/gcXkT+klRQr4ayh4maZWc7vqiTPbFF7JmjfoIb67PCp+Mar2buIHvAiAfsggt8uxcdKCkbX+DtXiHp70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752250191; c=relaxed/simple;
	bh=ok4UshvH+9XVULZBkAz1eoWtZvcw7cg/kFuuEHaFaqA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=f8rPF7DS9eEJNeVSdJQMTd4KsPM9eLMGaRmbwOYxtqsCKqVZ2ZkCV6yD98Xq11MTe2oc/aT6ud05TGb9sz3IxUa6g/vsMr2+sgfDp0U5k2i6xe8HJnXXmbt58GngxcMCyZib73tzIZofvDPbc07cmq0uEiJDTEw/4QiJFpgOH20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sK0Y1jXG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HbXRa6rh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 11 Jul 2025 16:09:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752250187;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VW1mv3w4O+zx2B+xBAOZrP2FkbBufMPC1xBHUNFDST0=;
	b=sK0Y1jXGNL+drgZ4ItqIW9nodqb4BQloQs0UEzW0fdlYqD2Byv7YuNpQf8dWDUqkwYu53l
	d9srMa0Q1CjBl7Lfth/wtiX+x1roTUxU09ZDlGDzmd6nI56xaIrG9VtzOd9mVPLIEg1a1j
	Hgi2gZzvyipIT12meIBZF4mdkpJIUFA5zqssVxVbImGjWENYmcz1e+zNrdgPaVwRtDhFyi
	NWik6L1+ZwRPZRipIuMHsm+25OlqlcRy8hYJKIg49/mzCpEjCghGz2louLN5Iw0BOUdKiS
	q/4TR4VXZkWTNqcUJDzg4KXJROQLOcvYitLFAPrHr+10pzh+uBvnoraEitcrpw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752250187;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VW1mv3w4O+zx2B+xBAOZrP2FkbBufMPC1xBHUNFDST0=;
	b=HbXRa6rhDN+B+I4DD9+cHoxmZUw8dcl7yMoLrBFIgQnywEpuye3KPdQ3TbzusJuocXcgm6
	XE/OpZ8mMm36uKBQ==
From: "tip-bot2 for David Kaplan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/bugs] Documentation/x86: Document new attack vector controls
Cc: David Kaplan <david.kaplan@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250709155731.3279419-1-david.kaplan@amd.com>
References: <20250709155731.3279419-1-david.kaplan@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175225018641.406.13978562607564976423.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/bugs branch of tip:

Commit-ID:     1caa1b0509eaec2ea111b875da4eddb44edc9ea5
Gitweb:        https://git.kernel.org/tip/1caa1b0509eaec2ea111b875da4eddb44edc9ea5
Author:        David Kaplan <david.kaplan@amd.com>
AuthorDate:    Wed, 09 Jul 2025 10:57:31 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 11 Jul 2025 17:51:43 +02:00

Documentation/x86: Document new attack vector controls

Document the 5 new attack vector command line options, how they
interact with existing vulnerability controls, and recommendations on when
they can be disabled.

Note that while mitigating against untrusted userspace requires both
user-to-kernel and user-to-user protection, these are kept separate.  The
kernel can control what code executes inside of it and that may affect the
risk associated with vulnerabilities especially if new kernel mitigations
are implemented.  The same isn't typically true of userspace.

In other words, the risk associated with user-to-user or guest-to-guest
attacks is unlikely to change over time.  While the risk associated with
user-to-kernel or guest-to-host attacks may change.  Therefore, these
controls are separated.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/20250709155731.3279419-1-david.kaplan@amd.com
---
 Documentation/admin-guide/hw-vuln/attack_vector_controls.rst | 238 +++++++-
 Documentation/admin-guide/hw-vuln/index.rst                  |   1 +-
 Documentation/admin-guide/kernel-parameters.txt              |   4 +-
 3 files changed, 243 insertions(+)
 create mode 100644 Documentation/admin-guide/hw-vuln/attack_vector_controls.rst

diff --git a/Documentation/admin-guide/hw-vuln/attack_vector_controls.rst b/Documentation/admin-guide/hw-vuln/attack_vector_controls.rst
new file mode 100644
index 0000000..b4de16f
--- /dev/null
+++ b/Documentation/admin-guide/hw-vuln/attack_vector_controls.rst
@@ -0,0 +1,238 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+Attack Vector Controls
+======================
+
+Attack vector controls provide a simple method to configure only the mitigations
+for CPU vulnerabilities which are relevant given the intended use of a system.
+Administrators are encouraged to consider which attack vectors are relevant and
+disable all others in order to recoup system performance.
+
+When new relevant CPU vulnerabilities are found, they will be added to these
+attack vector controls so administrators will likely not need to reconfigure
+their command line parameters as mitigations will continue to be correctly
+applied based on the chosen attack vector controls.
+
+Attack Vectors
+--------------
+
+There are 5 sets of attack-vector mitigations currently supported by the kernel:
+
+#. :ref:`user_kernel`
+#. :ref:`user_user`
+#. :ref:`guest_host`
+#. :ref:`guest_guest`
+#. :ref:`smt`
+
+To control the enabled attack vectors, see :ref:`cmdline`.
+
+.. _user_kernel:
+
+User-to-Kernel
+^^^^^^^^^^^^^^
+
+The user-to-kernel attack vector involves a malicious userspace program
+attempting to leak kernel data into userspace by exploiting a CPU vulnerability.
+The kernel data involved might be limited to certain kernel memory, or include
+all memory in the system, depending on the vulnerability exploited.
+
+If no untrusted userspace applications are being run, such as with single-user
+systems, consider disabling user-to-kernel mitigations.
+
+Note that the CPU vulnerabilities mitigated by Linux have generally not been
+shown to be exploitable from browser-based sandboxes.  User-to-kernel
+mitigations are therefore mostly relevant if unknown userspace applications may
+be run by untrusted users.
+
+*user-to-kernel mitigations are enabled by default*
+
+.. _user_user:
+
+User-to-User
+^^^^^^^^^^^^
+
+The user-to-user attack vector involves a malicious userspace program attempting
+to influence the behavior of another unsuspecting userspace program in order to
+exfiltrate data.  The vulnerability of a userspace program is based on the
+program itself and the interfaces it provides.
+
+If no untrusted userspace applications are being run, consider disabling
+user-to-user mitigations.
+
+Note that because the Linux kernel contains a mapping of all physical memory,
+preventing a malicious userspace program from leaking data from another
+userspace program requires mitigating user-to-kernel attacks as well for
+complete protection.
+
+*user-to-user mitigations are enabled by default*
+
+.. _guest_host:
+
+Guest-to-Host
+^^^^^^^^^^^^^
+
+The guest-to-host attack vector involves a malicious VM attempting to leak
+hypervisor data into the VM.  The data involved may be limited, or may
+potentially include all memory in the system, depending on the vulnerability
+exploited.
+
+If no untrusted VMs are being run, consider disabling guest-to-host mitigations.
+
+*guest-to-host mitigations are enabled by default if KVM support is present*
+
+.. _guest_guest:
+
+Guest-to-Guest
+^^^^^^^^^^^^^^
+
+The guest-to-guest attack vector involves a malicious VM attempting to influence
+the behavior of another unsuspecting VM in order to exfiltrate data.  The
+vulnerability of a VM is based on the code inside the VM itself and the
+interfaces it provides.
+
+If no untrusted VMs, or only a single VM is being run, consider disabling
+guest-to-guest mitigations.
+
+Similar to the user-to-user attack vector, preventing a malicious VM from
+leaking data from another VM requires mitigating guest-to-host attacks as well
+due to the Linux kernel phys map.
+
+*guest-to-guest mitigations are enabled by default if KVM support is present*
+
+.. _smt:
+
+Cross-Thread
+^^^^^^^^^^^^
+
+The cross-thread attack vector involves a malicious userspace program or
+malicious VM either observing or attempting to influence the behavior of code
+running on the SMT sibling thread in order to exfiltrate data.
+
+Many cross-thread attacks can only be mitigated if SMT is disabled, which will
+result in reduced CPU core count and reduced performance.
+
+If cross-thread mitigations are fully enabled ('auto,nosmt'), all mitigations
+for cross-thread attacks will be enabled.  SMT may be disabled depending on
+which vulnerabilities are present in the CPU.
+
+If cross-thread mitigations are partially enabled ('auto'), mitigations for
+cross-thread attacks will be enabled but SMT will not be disabled.
+
+If cross-thread mitigations are disabled, no mitigations for cross-thread
+attacks will be enabled.
+
+Cross-thread mitigation may not be required if core-scheduling or similar
+techniques are used to prevent untrusted workloads from running on SMT siblings.
+
+*cross-thread mitigations default to partially enabled*
+
+.. _cmdline:
+
+Command Line Controls
+---------------------
+
+Attack vectors are controlled through the mitigations= command line option.  The
+value provided begins with a global option and then may optionally include one
+or more options to disable various attack vectors.
+
+Format:
+	| ``mitigations=[global]``
+	| ``mitigations=[global],[attack vectors]``
+
+Global options:
+
+============ =============================================================
+Option       Description
+============ =============================================================
+'off'        All attack vectors disabled.
+'auto'       All attack vectors enabled, partial cross-thread mitigations.
+'auto,nosmt' All attack vectors enabled, full cross-thread mitigations.
+============ =============================================================
+
+Attack vector options:
+
+================= =======================================
+Option            Description
+================= =======================================
+'no_user_kernel'  Disables user-to-kernel mitigations.
+'no_user_user'    Disables user-to-user mitigations.
+'no_guest_host'   Disables guest-to-host mitigations.
+'no_guest_guest'  Disables guest-to-guest mitigations
+'no_cross_thread' Disables all cross-thread mitigations.
+================= =======================================
+
+Multiple attack vector options may be specified in a comma-separated list.  If
+the global option is not specified, it defaults to 'auto'.  The global option
+'off' is equivalent to disabling all attack vectors.
+
+Examples:
+	| ``mitigations=auto,no_user_kernel``
+
+	Enable all attack vectors except user-to-kernel.  Partial cross-thread
+	mitigations.
+
+	| ``mitigations=auto,nosmt,no_guest_host,no_guest_guest``
+
+	Enable all attack vectors and cross-thread mitigations except for
+	guest-to-host and guest-to-guest mitigations.
+
+	| ``mitigations=,no_cross_thread``
+
+	Enable all attack vectors but not cross-thread mitigations.
+
+Interactions with command-line options
+--------------------------------------
+
+Vulnerability-specific controls (e.g. "retbleed=off") take precedence over all
+attack vector controls.  Mitigations for individual vulnerabilities may be
+turned on or off via their command-line options regardless of the attack vector
+controls.
+
+Summary of attack-vector mitigations
+------------------------------------
+
+When a vulnerability is mitigated due to an attack-vector control, the default
+mitigation option for that particular vulnerability is used.  To use a different
+mitigation, please use the vulnerability-specific command line option.
+
+The table below summarizes which vulnerabilities are mitigated when different
+attack vectors are enabled and assuming the CPU is vulnerable.
+
+=============== ============== ============ ============= ============== ============ ========
+Vulnerability   User-to-Kernel User-to-User Guest-to-Host Guest-to-Guest Cross-Thread Notes
+=============== ============== ============ ============= ============== ============ ========
+BHI                   X                           X
+ITS                   X                           X
+GDS                   X              X            X              X            *       (Note 1)
+L1TF                  X                           X                           *       (Note 2)
+MDS                   X              X            X              X            *       (Note 2)
+MMIO                  X              X            X              X            *       (Note 2)
+Meltdown              X
+Retbleed              X                           X                           *       (Note 3)
+RFDS                  X              X            X              X
+Spectre_v1            X
+Spectre_v2            X                           X
+Spectre_v2_user                      X                           X            *       (Note 1)
+SRBDS                 X              X            X              X
+SRSO                  X                           X
+SSB                                                                                   (Note 4)
+TAA                   X              X            X              X            *       (Note 2)
+TSA                   X              X            X              X
+=============== ============== ============ ============= ============== ============ ========
+
+Notes:
+   1 --  Can be mitigated without disabling SMT.
+
+   2 --  Disables SMT if cross-thread mitigations are fully enabled  and the CPU
+   is vulnerable
+
+   3 --  Disables SMT if cross-thread mitigations are fully enabled, the CPU is
+   vulnerable, and STIBP is not supported
+
+   4 --  Speculative store bypass is always enabled by default (no kernel
+   mitigation applied) unless overridden with spec_store_bypass_disable option
+
+When an attack-vector is disabled, all mitigations for the vulnerabilities
+listed in the above table are disabled, unless mitigation is required for a
+different enabled attack-vector or a mitigation is explicitly selected via a
+vulnerability-specific command line option.
diff --git a/Documentation/admin-guide/hw-vuln/index.rst b/Documentation/admin-guide/hw-vuln/index.rst
index 09890a8..89ca636 100644
--- a/Documentation/admin-guide/hw-vuln/index.rst
+++ b/Documentation/admin-guide/hw-vuln/index.rst
@@ -9,6 +9,7 @@ are configurable at compile, boot or run time.
 .. toctree::
    :maxdepth: 1
 
+   attack_vector_controls
    spectre
    l1tf
    mds
diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 07e22ba..baa1d6a 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3790,6 +3790,10 @@
 					       mmio_stale_data=full,nosmt [X86]
 					       retbleed=auto,nosmt [X86]
 
+			[X86] After one of the above options, additionally
+			supports attack-vector based controls as documented in
+			Documentation/admin-guide/hw-vuln/attack_vector_controls.rst
+
 	mminit_loglevel=
 			[KNL,EARLY] When CONFIG_DEBUG_MEMORY_INIT is set, this
 			parameter allows control of the logging verbosity for

