Return-Path: <linux-tip-commits+bounces-3102-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA569F683F
	for <lists+linux-tip-commits@lfdr.de>; Wed, 18 Dec 2024 15:24:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E0771892DC7
	for <lists+linux-tip-commits@lfdr.de>; Wed, 18 Dec 2024 14:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0ECB1DE3DE;
	Wed, 18 Dec 2024 14:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zfjZptzN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Qd2gzAwW"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519FE1C5CAB;
	Wed, 18 Dec 2024 14:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734531759; cv=none; b=qBFf3jQQb/uTPb/gi5KgZcPiPjsWStIYlybJh4Apw0JuYpaUXlmin+COd2HQHhoCImf2Du8iRBFDaNCwZMXVtyM/6J2jTyRZ7aJkPfk9pi+FE1zVmq3k66UFCkJbyySa+rFdg5xsexVPgEcIsjLWo/98QZdhEzhmOpCPJEhuNu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734531759; c=relaxed/simple;
	bh=ZW1LICPHQG2co1aGRsGcsxkRLTD3LqQ+aGbI8GpG8Pg=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=pyjA3iDs7zw55ISv0DMQx2nKHWrT5UR1tDuGcFf34O0uz/x0vaquq7fCIiiEhvxe+c7WYWjxthPyaSUZzK+20c7qfIBQ0YET3wLqJSRzrIF/GheTbxWTRbsGdcdEs6mUZuCbdQAi/8MjMW+KCKTIHfSDmbdnmuGPdkLU467e+fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zfjZptzN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Qd2gzAwW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 18 Dec 2024 14:22:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734531756;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=phb8nVfftEEdfUQlKenyXr5x/T2Fb689GiH4i+h9jfM=;
	b=zfjZptzNIUb3YSGMsLoSpZmTfcrTwJfAlusD7cb+RfPt/WyFPAolL2Wa96AqxYNgwSV2QC
	uIcQeeCksaJZXWicTPkzHjviAu6XoOqLXdi87tlKq28keyIhTaJ8Fq8EFuH5ErUwoe5OOs
	s64U9CJxvQADVwLHa+Kymj3l87/pWV0gktTR+NJmVDYrka0mAzu91GPbr9s3oauy8Y6QjW
	e7mCCfxulX8F88uG/D9fmkNHZH3+RSc6j93gc7lHVBod+aG2faRhpQBQ5keaVKieYFmG6s
	EfKh+m5LSMnc0TbzWVatzvMIT5lbqhbt6EjLFmyT0OfWNsk2xR3jT8YB4eAlrw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734531756;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=phb8nVfftEEdfUQlKenyXr5x/T2Fb689GiH4i+h9jfM=;
	b=Qd2gzAwWWxv8IND9IBXhv6CbwhzIj62aWEwEgQoX5GAvhnoO/OVE8DJF0s4k58vktyLqeq
	wfNBJ7sl/2pwfSCg==
From: "tip-bot2 for Dave Hansen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpu: Move TSC CPUID leaf definition
Cc: Dave Hansen <dave.hansen@linux.intel.com>, Zhao Liu <zhao1.liu@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173453175576.7135.13776728539262077452.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     a86740a77bf0942e618cc5f022336cdd99530d10
Gitweb:        https://git.kernel.org/tip/a86740a77bf0942e618cc5f022336cdd99530d10
Author:        Dave Hansen <dave.hansen@linux.intel.com>
AuthorDate:    Fri, 13 Dec 2024 12:50:33 -08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 18 Dec 2024 06:17:36 -08:00

x86/cpu: Move TSC CPUID leaf definition

Prepare to use the TSC CPUID leaf definition more widely by moving
it to the common header.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/all/20241213205033.68799E53%40davehans-spike.ostc.intel.com
---
 arch/x86/events/intel/pt.c   | 1 +
 arch/x86/events/intel/pt.h   | 3 ---
 arch/x86/include/asm/cpuid.h | 1 +
 3 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
index 4b0373b..6081455 100644
--- a/arch/x86/events/intel/pt.c
+++ b/arch/x86/events/intel/pt.c
@@ -18,6 +18,7 @@
 #include <linux/slab.h>
 #include <linux/device.h>
 
+#include <asm/cpuid.h>
 #include <asm/perf_event.h>
 #include <asm/insn.h>
 #include <asm/io.h>
diff --git a/arch/x86/events/intel/pt.h b/arch/x86/events/intel/pt.h
index 7ee94fc..2ac3625 100644
--- a/arch/x86/events/intel/pt.h
+++ b/arch/x86/events/intel/pt.h
@@ -37,9 +37,6 @@ struct topa_entry {
 	u64	rsvd4	: 12;
 };
 
-/* TSC to Core Crystal Clock Ratio */
-#define CPUID_TSC_LEAF		0x15
-
 struct pt_pmu {
 	struct pmu		pmu;
 	u32			caps[PT_CPUID_REGS_NUM * PT_CPUID_LEAVES];
diff --git a/arch/x86/include/asm/cpuid.h b/arch/x86/include/asm/cpuid.h
index 8ba4d9f..9b0d14b 100644
--- a/arch/x86/include/asm/cpuid.h
+++ b/arch/x86/include/asm/cpuid.h
@@ -23,6 +23,7 @@ enum cpuid_regs_idx {
 
 #define CPUID_MWAIT_LEAF	0x5
 #define CPUID_DCA_LEAF		0x9
+#define CPUID_TSC_LEAF		0x15
 
 #ifdef CONFIG_X86_32
 bool have_cpuid_p(void);

