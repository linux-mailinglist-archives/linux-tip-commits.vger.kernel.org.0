Return-Path: <linux-tip-commits+bounces-4784-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54944A823D2
	for <lists+linux-tip-commits@lfdr.de>; Wed,  9 Apr 2025 13:45:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C3FD1B876AC
	for <lists+linux-tip-commits@lfdr.de>; Wed,  9 Apr 2025 11:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F6D25E800;
	Wed,  9 Apr 2025 11:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qmsXxLhI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dMk6T9hX"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C5C25E467;
	Wed,  9 Apr 2025 11:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744199067; cv=none; b=Zibc0mvnPzIa+78jGWJ5qV7oIop43bQq9IOfp1ikWTAmzXEn7gAGRwDSQES3QBqw3sDwgq9DK8obmy1E3s11m0E8MvolOk39W5Rb0dKg+uBhTqzB0qb4t8W30ayZLlx6dRYFtx4i8IPlmX7hcYSHjVwEAiZhfPiHF6NDguqzCv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744199067; c=relaxed/simple;
	bh=2v/zXr4u3XD1visyYb5kUU1vTtQPaAMN1xEErsNWHp0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ub6NZqGFC//swAfdwP9SiBWdgImiilBpTvQTHsj3Jjj4J0MmfLE0tm1vjNNGwae/RZbnQlLZpkwe9+X50bW1+eA/asTwvtNERRPGmIkFoYtZVkJww8U/ZBhMRVUTkaHTvb6y+Ov6ApXHzVlauaFhzSVSq9H1ZFgNn0m3F102W90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qmsXxLhI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dMk6T9hX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 09 Apr 2025 11:44:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744199063;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=my1iciepGPjxtLMGwGDEpExirZA0BKwwPxgX7kOe2nA=;
	b=qmsXxLhI6XD9Olk9le8HulPeIPbQmAkeXxhUiA7vr/Mzpjac+3zsaNhcmofEmKPjzMJui8
	nSpmxVfDHJQDKx+2d6s10x0n9fg994Vj5sCw0Qzeol4XNP/czv6j17YyTgYStB+iIp+Ayv
	Fz39oRM8Pu7TGvE4HWoNPChA+lfo3y9BGneYGfjnkXh0TaagJVqkH099BdQNbhfkYOzXqE
	EGdVc7VqSpkKzfMmV9X2/Qq5zKunN4JxRR+sPYsXnr6/D0KVOXzfa7DJsIwWLRlHAr1TKH
	v/NQfbaJSvZyhboGNccKsupBzxsogXRG4LgFcddw5PXui49pCwghGf87LAUI6g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744199063;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=my1iciepGPjxtLMGwGDEpExirZA0BKwwPxgX7kOe2nA=;
	b=dMk6T9hXMDLdLMmGtyWie2YE7i0YjFWaiGVyJ7eLdS7rifLyVJeYKyI91/hq/eHPBoV315
	8E43yv5qRJuT1dAw==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/bugs: Add RSB mitigation document
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To:
 <ab73f4659ba697a974759f07befd41ae605e33dd.1744148254.git.jpoimboe@kernel.org>
References:
 <ab73f4659ba697a974759f07befd41ae605e33dd.1744148254.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174419905819.31282.12603333394926727490.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     83f6665a49c3d44ad0c08f837d352dd290f5d10b
Gitweb:        https://git.kernel.org/tip/83f6665a49c3d44ad0c08f837d352dd290f5d10b
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Tue, 08 Apr 2025 14:47:35 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 09 Apr 2025 12:42:09 +02:00

x86/bugs: Add RSB mitigation document

Create a document to summarize hard-earned knowledge about RSB-related
mitigations, with references, and replace the overly verbose yet
incomplete comments with a reference to the document.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/ab73f4659ba697a974759f07befd41ae605e33dd.1744148254.git.jpoimboe@kernel.org
---
 Documentation/admin-guide/hw-vuln/index.rst |   1 +-
 Documentation/admin-guide/hw-vuln/rsb.rst   | 268 +++++++++++++++++++-
 arch/x86/kernel/cpu/bugs.c                  |  64 +----
 3 files changed, 282 insertions(+), 51 deletions(-)
 create mode 100644 Documentation/admin-guide/hw-vuln/rsb.rst

diff --git a/Documentation/admin-guide/hw-vuln/index.rst b/Documentation/admin-guide/hw-vuln/index.rst
index ff0b440..451874b 100644
--- a/Documentation/admin-guide/hw-vuln/index.rst
+++ b/Documentation/admin-guide/hw-vuln/index.rst
@@ -22,3 +22,4 @@ are configurable at compile, boot or run time.
    srso
    gather_data_sampling
    reg-file-data-sampling
+   rsb
diff --git a/Documentation/admin-guide/hw-vuln/rsb.rst b/Documentation/admin-guide/hw-vuln/rsb.rst
new file mode 100644
index 0000000..21dbf9c
--- /dev/null
+++ b/Documentation/admin-guide/hw-vuln/rsb.rst
@@ -0,0 +1,268 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=======================
+RSB-related mitigations
+=======================
+
+.. warning::
+   Please keep this document up-to-date, otherwise you will be
+   volunteered to update it and convert it to a very long comment in
+   bugs.c!
+
+Since 2018 there have been many Spectre CVEs related to the Return Stack
+Buffer (RSB) (sometimes referred to as the Return Address Stack (RAS) or
+Return Address Predictor (RAP) on AMD).
+
+Information about these CVEs and how to mitigate them is scattered
+amongst a myriad of microarchitecture-specific documents.
+
+This document attempts to consolidate all the relevant information in
+once place and clarify the reasoning behind the current RSB-related
+mitigations.  It's meant to be as concise as possible, focused only on
+the current kernel mitigations: what are the RSB-related attack vectors
+and how are they currently being mitigated?
+
+It's *not* meant to describe how the RSB mechanism operates or how the
+exploits work.  More details about those can be found in the references
+below.
+
+Rather, this is basically a glorified comment, but too long to actually
+be one.  So when the next CVE comes along, a kernel developer can
+quickly refer to this as a refresher to see what we're actually doing
+and why.
+
+At a high level, there are two classes of RSB attacks: RSB poisoning
+(Intel and AMD) and RSB underflow (Intel only).  They must each be
+considered individually for each attack vector (and microarchitecture
+where applicable).
+
+----
+
+RSB poisoning (Intel and AMD)
+=============================
+
+SpectreRSB
+~~~~~~~~~~
+
+RSB poisoning is a technique used by SpectreRSB [#spectre-rsb]_ where
+an attacker poisons an RSB entry to cause a victim's return instruction
+to speculate to an attacker-controlled address.  This can happen when
+there are unbalanced CALLs/RETs after a context switch or VMEXIT.
+
+* All attack vectors can potentially be mitigated by flushing out any
+  poisoned RSB entries using an RSB filling sequence
+  [#intel-rsb-filling]_ [#amd-rsb-filling]_ when transitioning between
+  untrusted and trusted domains.  But this has a performance impact and
+  should be avoided whenever possible.
+
+  .. DANGER::
+     **FIXME**: Currently we're flushing 32 entries.  However, some CPU
+     models have more than 32 entries.  The loop count needs to be
+     increased for those.  More detailed information is needed about RSB
+     sizes.
+
+* On context switch, the user->user mitigation requires ensuring the
+  RSB gets filled or cleared whenever IBPB gets written [#cond-ibpb]_
+  during a context switch:
+
+  * AMD:
+	On Zen 4+, IBPB (or SBPB [#amd-sbpb]_ if used) clears the RSB.
+	This is indicated by IBPB_RET in CPUID [#amd-ibpb-rsb]_.
+
+	On Zen < 4, the RSB filling sequence [#amd-rsb-filling]_ must be
+	always be done in addition to IBPB [#amd-ibpb-no-rsb]_.  This is
+	indicated by X86_BUG_IBPB_NO_RET.
+
+  * Intel:
+	IBPB always clears the RSB:
+
+	"Software that executed before the IBPB command cannot control
+	the predicted targets of indirect branches executed after the
+	command on the same logical processor. The term indirect branch
+	in this context includes near return instructions, so these
+	predicted targets may come from the RSB." [#intel-ibpb-rsb]_
+
+* On context switch, user->kernel attacks are prevented by SMEP.  User
+  space can only insert user space addresses into the RSB.  Even
+  non-canonical addresses can't be inserted due to the page gap at the
+  end of the user canonical address space reserved by TASK_SIZE_MAX.
+  A SMEP #PF at instruction fetch prevents the kernel from speculatively
+  executing user space.
+
+  * AMD:
+	"Finally, branches that are predicted as 'ret' instructions get
+	their predicted targets from the Return Address Predictor (RAP).
+	AMD recommends software use a RAP stuffing sequence (mitigation
+	V2-3 in [2]) and/or Supervisor Mode Execution Protection (SMEP)
+	to ensure that the addresses in the RAP are safe for
+	speculation. Collectively, we refer to these mitigations as "RAP
+	Protection"." [#amd-smep-rsb]_
+
+  * Intel:
+	"On processors with enhanced IBRS, an RSB overwrite sequence may
+	not suffice to prevent the predicted target of a near return
+	from using an RSB entry created in a less privileged predictor
+	mode.  Software can prevent this by enabling SMEP (for
+	transitions from user mode to supervisor mode) and by having
+	IA32_SPEC_CTRL.IBRS set during VM exits." [#intel-smep-rsb]_
+
+* On VMEXIT, guest->host attacks are mitigated by eIBRS (and PBRSB
+  mitigation if needed):
+
+  * AMD:
+	"When Automatic IBRS is enabled, the internal return address
+	stack used for return address predictions is cleared on VMEXIT."
+	[#amd-eibrs-vmexit]_
+
+  * Intel:
+	"On processors with enhanced IBRS, an RSB overwrite sequence may
+	not suffice to prevent the predicted target of a near return
+	from using an RSB entry created in a less privileged predictor
+	mode.  Software can prevent this by enabling SMEP (for
+	transitions from user mode to supervisor mode) and by having
+	IA32_SPEC_CTRL.IBRS set during VM exits. Processors with
+	enhanced IBRS still support the usage model where IBRS is set
+	only in the OS/VMM for OSes that enable SMEP. To do this, such
+	processors will ensure that guest behavior cannot control the
+	RSB after a VM exit once IBRS is set, even if IBRS was not set
+	at the time of the VM exit." [#intel-eibrs-vmexit]_
+
+    Note that some Intel CPUs are susceptible to Post-barrier Return
+    Stack Buffer Predictions (PBRSB) [#intel-pbrsb]_, where the last
+    CALL from the guest can be used to predict the first unbalanced RET.
+    In this case the PBRSB mitigation is needed in addition to eIBRS.
+
+AMD RETBleed / SRSO / Branch Type Confusion
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+On AMD, poisoned RSB entries can also be created by the AMD RETBleed
+variant [#retbleed-paper]_ [#amd-btc]_ or by Speculative Return Stack
+Overflow [#amd-srso]_ (Inception [#inception-paper]_).  The kernel
+protects itself by replacing every RET in the kernel with a branch to a
+single safe RET.
+
+----
+
+RSB underflow (Intel only)
+==========================
+
+RSB Alternate (RSBA) ("Intel Retbleed")
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Some Intel Skylake-generation CPUs are susceptible to the Intel variant
+of RETBleed [#retbleed-paper]_ (Return Stack Buffer Underflow
+[#intel-rsbu]_).  If a RET is executed when the RSB buffer is empty due
+to mismatched CALLs/RETs or returning from a deep call stack, the branch
+predictor can fall back to using the Branch Target Buffer (BTB).  If a
+user forces a BTB collision then the RET can speculatively branch to a
+user-controlled address.
+
+* Note that RSB filling doesn't fully mitigate this issue.  If there
+  are enough unbalanced RETs, the RSB may still underflow and fall back
+  to using a poisoned BTB entry.
+
+* On context switch, user->user underflow attacks are mitigated by the
+  conditional IBPB [#cond-ibpb]_ on context switch which effectively
+  clears the BTB:
+
+  * "The indirect branch predictor barrier (IBPB) is an indirect branch
+    control mechanism that establishes a barrier, preventing software
+    that executed before the barrier from controlling the predicted
+    targets of indirect branches executed after the barrier on the same
+    logical processor." [#intel-ibpb-btb]_
+
+* On context switch and VMEXIT, user->kernel and guest->host RSB
+  underflows are mitigated by IBRS or eIBRS:
+
+  * "Enabling IBRS (including enhanced IBRS) will mitigate the "RSBU"
+    attack demonstrated by the researchers. As previously documented,
+    Intel recommends the use of enhanced IBRS, where supported. This
+    includes any processor that enumerates RRSBA but not RRSBA_DIS_S."
+    [#intel-rsbu]_
+
+  However, note that eIBRS and IBRS do not mitigate intra-mode attacks.
+  Like RRSBA below, this is mitigated by clearing the BHB on kernel
+  entry.
+
+  As an alternative to classic IBRS, call depth tracking (combined with
+  retpolines) can be used to track kernel returns and fill the RSB when
+  it gets close to being empty.
+
+Restricted RSB Alternate (RRSBA)
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Some newer Intel CPUs have Restricted RSB Alternate (RRSBA) behavior,
+which, similar to RSBA described above, also falls back to using the BTB
+on RSB underflow.  The only difference is that the predicted targets are
+restricted to the current domain when eIBRS is enabled:
+
+* "Restricted RSB Alternate (RRSBA) behavior allows alternate branch
+  predictors to be used by near RET instructions when the RSB is
+  empty.  When eIBRS is enabled, the predicted targets of these
+  alternate predictors are restricted to those belonging to the
+  indirect branch predictor entries of the current prediction domain.
+  [#intel-eibrs-rrsba]_
+
+When a CPU with RRSBA is vulnerable to Branch History Injection
+[#bhi-paper]_ [#intel-bhi]_, an RSB underflow could be used for an
+intra-mode BTI attack.  This is mitigated by clearing the BHB on
+kernel entry.
+
+However if the kernel uses retpolines instead of eIBRS, it needs to
+disable RRSBA:
+
+* "Where software is using retpoline as a mitigation for BHI or
+  intra-mode BTI, and the processor both enumerates RRSBA and
+  enumerates RRSBA_DIS controls, it should disable this behavior."
+  [#intel-retpoline-rrsba]_
+
+----
+
+References
+==========
+
+.. [#spectre-rsb] `Spectre Returns! Speculation Attacks using the Return Stack Buffer <https://arxiv.org/pdf/1807.07940.pdf>`_
+
+.. [#intel-rsb-filling] "Empty RSB Mitigation on Skylake-generation" in `Retpoline: A Branch Target Injection Mitigation <https://www.intel.com/content/www/us/en/developer/articles/technical/software-security-guidance/technical-documentation/retpoline-branch-target-injection-mitigation.html#inpage-nav-5-1>`_
+
+.. [#amd-rsb-filling] "Mitigation V2-3" in `Software Techniques for Managing Speculation <https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/programmer-references/software-techniques-for-managing-speculation.pdf>`_
+
+.. [#cond-ibpb] Whether IBPB is written depends on whether the prev and/or next task is protected from Spectre attacks.  It typically requires opting in per task or system-wide.  For more details see the documentation for the ``spectre_v2_user`` cmdline option in Documentation/admin-guide/kernel-parameters.txt.
+
+.. [#amd-sbpb] IBPB without flushing of branch type predictions.  Only exists for AMD.
+
+.. [#amd-ibpb-rsb] "Function 8000_0008h -- Processor Capacity Parameters and Extended Feature Identification" in `AMD64 Architecture Programmer's Manual Volume 3: General-Purpose and System Instructions <https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/programmer-references/24594.pdf>`_.  SBPB behaves the same way according to `this email <https://lore.kernel.org/5175b163a3736ca5fd01cedf406735636c99a>`_.
+
+.. [#amd-ibpb-no-rsb] `Spectre Attacks: Exploiting Speculative Execution <https://comsec.ethz.ch/wp-content/files/ibpb_sp25.pdf>`_
+
+.. [#intel-ibpb-rsb] "Introduction" in `Post-barrier Return Stack Buffer Predictions / CVE-2022-26373 / INTEL-SA-00706 <https://www.intel.com/content/www/us/en/developer/articles/technical/software-security-guidance/advisory-guidance/post-barrier-return-stack-buffer-predictions.html>`_
+
+.. [#amd-smep-rsb] "Existing Mitigations" in `Technical Guidance for Mitigating Branch Type Confusion <https://www.amd.com/content/dam/amd/en/documents/resources/technical-guidance-for-mitigating-branch-type-confusion.pdf>`_
+
+.. [#intel-smep-rsb] "Enhanced IBRS" in `Indirect Branch Restricted Speculation <https://www.intel.com/content/www/us/en/developer/articles/technical/software-security-guidance/technical-documentation/indirect-branch-restricted-speculation.html>`_
+
+.. [#amd-eibrs-vmexit] "Extended Feature Enable Register (EFER)" in `AMD64 Architecture Programmer's Manual Volume 2: System Programming <https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/programmer-references/24593.pdf>`_
+
+.. [#intel-eibrs-vmexit] "Enhanced IBRS" in `Indirect Branch Restricted Speculation <https://www.intel.com/content/www/us/en/developer/articles/technical/software-security-guidance/technical-documentation/indirect-branch-restricted-speculation.html>`_
+
+.. [#intel-pbrsb] `Post-barrier Return Stack Buffer Predictions / CVE-2022-26373 / INTEL-SA-00706 <https://www.intel.com/content/www/us/en/developer/articles/technical/software-security-guidance/advisory-guidance/post-barrier-return-stack-buffer-predictions.html>`_
+
+.. [#retbleed-paper] `RETBleed: Arbitrary Speculative Code Execution with Return Instruction <https://comsec.ethz.ch/wp-content/files/retbleed_sec22.pdf>`_
+
+.. [#amd-btc] `Technical Guidance for Mitigating Branch Type Confusion <https://www.amd.com/content/dam/amd/en/documents/resources/technical-guidance-for-mitigating-branch-type-confusion.pdf>`_
+
+.. [#amd-srso] `Technical Update Regarding Speculative Return Stack Overflow <https://www.amd.com/content/dam/amd/en/documents/corporate/cr/speculative-return-stack-overflow-whitepaper.pdf>`_
+
+.. [#inception-paper] `Inception: Exposing New Attack Surfaces with Training in Transient Execution <https://comsec.ethz.ch/wp-content/files/inception_sec23.pdf>`_
+
+.. [#intel-rsbu] `Return Stack Buffer Underflow / Return Stack Buffer Underflow / CVE-2022-29901, CVE-2022-28693 / INTEL-SA-00702 <https://www.intel.com/content/www/us/en/developer/articles/technical/software-security-guidance/advisory-guidance/return-stack-buffer-underflow.html>`_
+
+.. [#intel-ibpb-btb] `Indirect Branch Predictor Barrier' <https://www.intel.com/content/www/us/en/developer/articles/technical/software-security-guidance/technical-documentation/indirect-branch-predictor-barrier.html>`_
+
+.. [#intel-eibrs-rrsba] "Guidance for RSBU" in `Return Stack Buffer Underflow / Return Stack Buffer Underflow / CVE-2022-29901, CVE-2022-28693 / INTEL-SA-00702 <https://www.intel.com/content/www/us/en/developer/articles/technical/software-security-guidance/advisory-guidance/return-stack-buffer-underflow.html>`_
+
+.. [#bhi-paper] `Branch History Injection: On the Effectiveness of Hardware Mitigations Against Cross-Privilege Spectre-v2 Attacks <http://download.vusec.net/papers/bhi-spectre-bhb_sec22.pdf>`_
+
+.. [#intel-bhi] `Branch History Injection and Intra-mode Branch Target Injection / CVE-2022-0001, CVE-2022-0002 / INTEL-SA-00598 <https://www.intel.com/content/www/us/en/developer/articles/technical/software-security-guidance/technical-documentation/branch-history-injection.html>`_
+
+.. [#intel-retpoline-rrsba] "Retpoline" in `Branch History Injection and Intra-mode Branch Target Injection / CVE-2022-0001, CVE-2022-0002 / INTEL-SA-00598 <https://www.intel.com/content/www/us/en/developer/articles/technical/software-security-guidance/technical-documentation/branch-history-injection.html>`_
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index e2a672f..362602b 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1594,25 +1594,25 @@ static void __init spec_ctrl_disable_kernel_rrsba(void)
 static void __init spectre_v2_select_rsb_mitigation(enum spectre_v2_mitigation mode)
 {
 	/*
-	 * Similar to context switches, there are two types of RSB attacks
-	 * after VM exit:
+	 * WARNING! There are many subtleties to consider when changing *any*
+	 * code related to RSB-related mitigations.  Before doing so, carefully
+	 * read the following document, and update if necessary:
 	 *
-	 * 1) RSB underflow
+	 *   Documentation/admin-guide/hw-vuln/rsb.rst
 	 *
-	 * 2) Poisoned RSB entry
+	 * In an overly simplified nutshell:
 	 *
-	 * When retpoline is enabled, both are mitigated by filling/clearing
-	 * the RSB.
+	 *   - User->user RSB attacks are conditionally mitigated during
+	 *     context switches by cond_mitigation -> write_ibpb().
 	 *
-	 * When IBRS is enabled, while #1 would be mitigated by the IBRS branch
-	 * prediction isolation protections, RSB still needs to be cleared
-	 * because of #2.  Note that SMEP provides no protection here, unlike
-	 * user-space-poisoned RSB entries.
+	 *   - User->kernel and guest->host attacks are mitigated by eIBRS or
+	 *     RSB filling.
 	 *
-	 * eIBRS should protect against RSB poisoning, but if the EIBRS_PBRSB
-	 * bug is present then a LITE version of RSB protection is required,
-	 * just a single call needs to retire before a RET is executed.
+	 *     Though, depending on config, note that other alternative
+	 *     mitigations may end up getting used instead, e.g., IBPB on
+	 *     entry/vmexit, call depth tracking, or return thunks.
 	 */
+
 	switch (mode) {
 	case SPECTRE_V2_NONE:
 		break;
@@ -1832,44 +1832,6 @@ static void __init spectre_v2_select_mitigation(void)
 	spectre_v2_enabled = mode;
 	pr_info("%s\n", spectre_v2_strings[mode]);
 
-	/*
-	 * If Spectre v2 protection has been enabled, fill the RSB during a
-	 * context switch.  In general there are two types of RSB attacks
-	 * across context switches, for which the CALLs/RETs may be unbalanced.
-	 *
-	 * 1) RSB underflow
-	 *
-	 *    Some Intel parts have "bottomless RSB".  When the RSB is empty,
-	 *    speculated return targets may come from the branch predictor,
-	 *    which could have a user-poisoned BTB or BHB entry.
-	 *
-	 *    AMD has it even worse: *all* returns are speculated from the BTB,
-	 *    regardless of the state of the RSB.
-	 *
-	 *    When IBRS or eIBRS is enabled, the "user -> kernel" attack
-	 *    scenario is mitigated by the IBRS branch prediction isolation
-	 *    properties, so the RSB buffer filling wouldn't be necessary to
-	 *    protect against this type of attack.
-	 *
-	 *    The "user -> user" attack scenario is mitigated by RSB filling.
-	 *
-	 * 2) Poisoned RSB entry
-	 *
-	 *    If the 'next' in-kernel return stack is shorter than 'prev',
-	 *    'next' could be tricked into speculating with a user-poisoned RSB
-	 *    entry.
-	 *
-	 *    The "user -> kernel" attack scenario is mitigated by SMEP and
-	 *    eIBRS.
-	 *
-	 *    The "user -> user" scenario, also known as SpectreBHB, requires
-	 *    RSB clearing.
-	 *
-	 * So to mitigate all cases, unconditionally fill RSB on context
-	 * switches.
-	 *
-	 * FIXME: Is this pointless for retbleed-affected AMD?
-	 */
 	spectre_v2_select_rsb_mitigation(mode);
 
 	/*

