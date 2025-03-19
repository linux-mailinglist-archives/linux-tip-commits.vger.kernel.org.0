Return-Path: <linux-tip-commits+bounces-4373-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32307A68AFA
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Mar 2025 12:14:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 135773ACE2F
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Mar 2025 11:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDDD625DCF6;
	Wed, 19 Mar 2025 11:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sL10/XIJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5ehDy/5q"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5EF325D558;
	Wed, 19 Mar 2025 11:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742382240; cv=none; b=jNzxGeJxQIkUc7MGkDB4/54XNClT+U4Ib5iM4q99IRB7pYYhh/EdPRm1A7UfqUOVeHj99cnfoE6+x4UysJLITIWHuoDpUniMccvmto4jwuN0lp5Gk3xfDt8Hl8EkWSRtq0ihvcwM7Qd7qJTYKb6hdOSIeuJPUaa3SHuZDVmbxus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742382240; c=relaxed/simple;
	bh=3wYVIfQUDZ1L7Npb5FLwsK0yc/ZyO/8SahIGVmz37qE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=b8jepX53JU21R5/IlWPvDpGTxl1qRRd/IYH0E4fETcJAFSK3gll28iR8WowlE/l7ew5HXGKRcGOhLXhJnJPrnV3MG+F6mG4UcFF0tD8q8O1Aq1xWgV4EeNngHscOpdOhZtFjw3xwCh5/czhR1Zfm4wxvsDEl0xVq2FU53E6y+H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sL10/XIJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5ehDy/5q; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 19 Mar 2025 11:03:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742382236;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=60ySEfdFQ2rWm2wQyyF+azFPjWnOtUYqOwMS0bkYPII=;
	b=sL10/XIJvlWltGkijyuK39gf0SqLlgW9Z86zuhX2mnsUf6gpYxz8OZwlvLPEelbxyhgZEH
	/JOacedrO7FS8mfoybEuH2thujBhC0M3PSVBLbf1C32sY9+9CIV3p4a0J3KbPYA5bNLiD5
	ODFZFOaek+cqnb6tXFgCNgkVQgOV5qG0LHHLq/dJjM7ZmdOImMPaRxzsdv6VmfNaWh//8U
	GKUMEQHKf2gbXEV94iPUi6ifqNToeQj42x2uW7HIoZMyz6ss5zU12Ch2p7J01uNeqsgTni
	3RPFcaX3dY745MjuRkSEewNgDSBe6v4vAvNl2qcR72bngeunTv5K5wXTqXGEuA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742382236;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=60ySEfdFQ2rWm2wQyyF+azFPjWnOtUYqOwMS0bkYPII=;
	b=5ehDy/5qxW//5ObJd+9YXM2ga3k9ypiT70raLqQer7P/ZqdJdPHia3W7KAfE85Vh/ZkeZw
	JPFYitA6LR6i+BAg==
From: "tip-bot2 for Pawan Gupta" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/core] x86/rfds: Exclude P-only parts from the RFDS affected list
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250311-add-cpu-type-v8-5-e8514dcaaff2@linux.intel.com>
References: <20250311-add-cpu-type-v8-5-e8514dcaaff2@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174238223554.14745.16324041214602055294.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     722fa0dba74f206999244facb177a8bfe3d513e6
Gitweb:        https://git.kernel.org/tip/722fa0dba74f206999244facb177a8bfe3d513e6
Author:        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
AuthorDate:    Tue, 11 Mar 2025 08:03:08 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 19 Mar 2025 11:17:23 +01:00

x86/rfds: Exclude P-only parts from the RFDS affected list

The affected CPU table (cpu_vuln_blacklist) marks Alderlake and Raptorlake
P-only parts affected by RFDS. This is not true because only E-cores are
affected by RFDS. With the current family/model matching it is not possible
to differentiate the unaffected parts, as the affected and unaffected
hybrid variants have the same model number.

Add a cpu-type match as well for such parts so as to exclude P-only parts
being marked as affected.

Note, family/model and cpu-type enumeration could be inaccurate in
virtualized environments. In a guest affected status is decided by RFDS_NO
and RFDS_CLEAR bits exposed by VMMs.

Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/r/20250311-add-cpu-type-v8-5-e8514dcaaff2@linux.intel.com
---
 Documentation/admin-guide/hw-vuln/reg-file-data-sampling.rst | 8 +-------
 arch/x86/kernel/cpu/common.c                                 | 7 ++++--
 2 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/Documentation/admin-guide/hw-vuln/reg-file-data-sampling.rst b/Documentation/admin-guide/hw-vuln/reg-file-data-sampling.rst
index 0585d02..ad15417 100644
--- a/Documentation/admin-guide/hw-vuln/reg-file-data-sampling.rst
+++ b/Documentation/admin-guide/hw-vuln/reg-file-data-sampling.rst
@@ -29,14 +29,6 @@ Below is the list of affected Intel processors [#f1]_:
    RAPTORLAKE_S            06_BFH
    ===================  ============
 
-As an exception to this table, Intel Xeon E family parts ALDERLAKE(06_97H) and
-RAPTORLAKE(06_B7H) codenamed Catlow are not affected. They are reported as
-vulnerable in Linux because they share the same family/model with an affected
-part. Unlike their affected counterparts, they do not enumerate RFDS_CLEAR or
-CPUID.HYBRID. This information could be used to distinguish between the
-affected and unaffected parts, but it is deemed not worth adding complexity as
-the reporting is fixed automatically when these parts enumerate RFDS_NO.
-
 Mitigation
 ==========
 Intel released a microcode update that enables software to clear sensitive
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 5809534..a2b9a79 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1203,6 +1203,9 @@ static const __initconst struct x86_cpu_id cpu_vuln_whitelist[] = {
 #define VULNBL_INTEL_STEPS(vfm, max_stepping, issues)		   \
 	X86_MATCH_VFM_STEPS(vfm, X86_STEP_MIN, max_stepping, issues)
 
+#define VULNBL_INTEL_TYPE(vfm, cpu_type, issues)	\
+	X86_MATCH_VFM_CPU_TYPE(vfm, INTEL_CPU_TYPE_##cpu_type, issues)
+
 #define VULNBL_AMD(family, blacklist)		\
 	VULNBL(AMD, family, X86_MODEL_ANY, blacklist)
 
@@ -1251,9 +1254,9 @@ static const struct x86_cpu_id cpu_vuln_blacklist[] __initconst = {
 	VULNBL_INTEL_STEPS(INTEL_TIGERLAKE,	     X86_STEP_MAX,	GDS),
 	VULNBL_INTEL_STEPS(INTEL_LAKEFIELD,	     X86_STEP_MAX,	MMIO | MMIO_SBDS | RETBLEED),
 	VULNBL_INTEL_STEPS(INTEL_ROCKETLAKE,	     X86_STEP_MAX,	MMIO | RETBLEED | GDS),
-	VULNBL_INTEL_STEPS(INTEL_ALDERLAKE,	     X86_STEP_MAX,	RFDS),
+	VULNBL_INTEL_TYPE(INTEL_ALDERLAKE,		     ATOM,	RFDS),
 	VULNBL_INTEL_STEPS(INTEL_ALDERLAKE_L,	     X86_STEP_MAX,	RFDS),
-	VULNBL_INTEL_STEPS(INTEL_RAPTORLAKE,	     X86_STEP_MAX,	RFDS),
+	VULNBL_INTEL_TYPE(INTEL_RAPTORLAKE,		     ATOM,	RFDS),
 	VULNBL_INTEL_STEPS(INTEL_RAPTORLAKE_P,	     X86_STEP_MAX,	RFDS),
 	VULNBL_INTEL_STEPS(INTEL_RAPTORLAKE_S,	     X86_STEP_MAX,	RFDS),
 	VULNBL_INTEL_STEPS(INTEL_ATOM_GRACEMONT,     X86_STEP_MAX,	RFDS),

