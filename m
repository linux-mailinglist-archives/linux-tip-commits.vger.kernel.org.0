Return-Path: <linux-tip-commits+bounces-1548-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8733391CB4C
	for <lists+linux-tip-commits@lfdr.de>; Sat, 29 Jun 2024 07:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F24811F22EB5
	for <lists+linux-tip-commits@lfdr.de>; Sat, 29 Jun 2024 05:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 238602574F;
	Sat, 29 Jun 2024 05:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Po7TgReX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/zO6C3O8"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4924B2139D7;
	Sat, 29 Jun 2024 05:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719640167; cv=none; b=E9PwL4988P8/9XKbj6P1d3Nc4R4+k2akbxXZooXx6epkN7bt8cz9dCPp2L47zEhtA7ZwEIVJ+rl10nLUU1UDoWjecGXPD2uReP11s90I+36yRa9ej8o6n+6pfdwUFmmJ7xXhTx8YPdNTAqGPK43a3mQ8jW7XlDO+/Q18n7Ah+BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719640167; c=relaxed/simple;
	bh=eg3gR1VMY7M/28LC8QaaJZJuEM6oc16/cWeKJFaJ5cY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=vC94CJcaC4u4eyjF8m5nbKOHzHESkYQTDyYYoPsg0WexcojfDmnI0tOASsx3MhGOJSf94qYBi7zF7RAKddLFLvknikyFjKVdFOTjk84w2HNiDnXDoNOJIpb6gIeGLC1WsOsnd+r/APmYNcLU0XC7B4ftQteNCK0Eu2e04Ocng30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Po7TgReX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/zO6C3O8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 29 Jun 2024 05:49:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719640163;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cGRE7VU/a5XrVKC4payEeBzM7wdGGv2v3j7a+/Cmt/Y=;
	b=Po7TgReXB48d9WpvLr6ygfISrb/GS9lVGaqO4V89iuWkonnMKqSp5AQV5UnH+1TC3w3iNS
	7S5UjNIgPjQtRo3M92UzYWKcXI/3iaQguvoqyOZpTTp1jXZl72znPozn23dhTcYT/ivOUA
	xwqF6fcO2rS195VyqV1Nkxu5TvUvltIKStbwret3T7O4JUKRq1K0iF1akJ4R4KhWmo6+NJ
	Z/5LmtXbEbw7Z83+aFKTTOhMuVoQbMW1IKs8rBJJZcljy98RRpQ5Ir7NKGIbkUPnY/bEoO
	FU1Jdriwb5A5x1oaeESf/wup45ai6BVIkAb3lT1tCb7Nv0oIZgbClGP72CmYQA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719640163;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cGRE7VU/a5XrVKC4payEeBzM7wdGGv2v3j7a+/Cmt/Y=;
	b=/zO6C3O85eJhWQgeQiqj2lN1I6RyKrzsr19tfsEgqZ/ej9LcD7oJn6R9NwM1GAJvhajHmp
	M/TrrXSNfJgupVDg==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/bugs] x86/bugs: Add 'spectre_bhi=vmexit' cmdline option
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
 "Borislav Petkov (AMD)" <bp@alien8.de>,
 Daniel Sneddon <daniel.sneddon@linux.intel.com>,
 Nikolay Borisov <nik.borisov@suse.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <2cbad706a6d5e1da2829e5e123d8d5c80330148c.1719381528.git.jpoimboe@kernel.org>
References:
 <2cbad706a6d5e1da2829e5e123d8d5c80330148c.1719381528.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171964016261.2215.17849381714028894235.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/bugs branch of tip:

Commit-ID:     42c141fbb651b64db492aab35bc1d96eb4c20261
Gitweb:        https://git.kernel.org/tip/42c141fbb651b64db492aab35bc1d96eb4c20261
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Tue, 25 Jun 2024 23:02:02 -07:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 28 Jun 2024 15:35:54 +02:00

x86/bugs: Add 'spectre_bhi=vmexit' cmdline option

In cloud environments it can be useful to *only* enable the vmexit
mitigation and leave syscalls vulnerable.  Add that as an option.

This is similar to the old spectre_bhi=auto option which was removed
with the following commit:

  36d4fe147c87 ("x86/bugs: Remove CONFIG_BHI_MITIGATION_AUTO and spectre_bhi=auto")

with the main difference being that this has a more descriptive name and
is disabled by default.

Mitigation switch requested by Maksim Davydov <davydov-max@yandex-team.ru>.

  [ bp: Massage. ]

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Daniel Sneddon <daniel.sneddon@linux.intel.com>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Link: https://lore.kernel.org/r/2cbad706a6d5e1da2829e5e123d8d5c80330148c.1719381528.git.jpoimboe@kernel.org
---
 Documentation/admin-guide/kernel-parameters.txt | 12 +++++++++---
 arch/x86/kernel/cpu/bugs.c                      | 16 +++++++++++-----
 2 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 11e57ba..ddf4eff 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6136,9 +6136,15 @@
 			deployment of the HW BHI control and the SW BHB
 			clearing sequence.
 
-			on   - (default) Enable the HW or SW mitigation
-			       as needed.
-			off  - Disable the mitigation.
+			on     - (default) Enable the HW or SW mitigation as
+				 needed.  This protects the kernel from
+				 both syscalls and VMs.
+			vmexit - On systems which don't have the HW mitigation
+				 available, enable the SW mitigation on vmexit
+				 ONLY.  On such systems, the host kernel is
+				 protected from VM-originated BHI attacks, but
+				 may still be vulnerable to syscall attacks.
+			off    - Disable the mitigation.
 
 	spectre_v2=	[X86,EARLY] Control mitigation of Spectre variant 2
 			(indirect branch speculation) vulnerability.
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index b6f927f..45675da 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1625,6 +1625,7 @@ static bool __init spec_ctrl_bhi_dis(void)
 enum bhi_mitigations {
 	BHI_MITIGATION_OFF,
 	BHI_MITIGATION_ON,
+	BHI_MITIGATION_VMEXIT_ONLY,
 };
 
 static enum bhi_mitigations bhi_mitigation __ro_after_init =
@@ -1639,6 +1640,8 @@ static int __init spectre_bhi_parse_cmdline(char *str)
 		bhi_mitigation = BHI_MITIGATION_OFF;
 	else if (!strcmp(str, "on"))
 		bhi_mitigation = BHI_MITIGATION_ON;
+	else if (!strcmp(str, "vmexit"))
+		bhi_mitigation = BHI_MITIGATION_VMEXIT_ONLY;
 	else
 		pr_err("Ignoring unknown spectre_bhi option (%s)", str);
 
@@ -1659,19 +1662,22 @@ static void __init bhi_select_mitigation(void)
 			return;
 	}
 
+	/* Mitigate in hardware if supported */
 	if (spec_ctrl_bhi_dis())
 		return;
 
 	if (!IS_ENABLED(CONFIG_X86_64))
 		return;
 
-	/* Mitigate KVM by default */
-	setup_force_cpu_cap(X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT);
-	pr_info("Spectre BHI mitigation: SW BHB clearing on vm exit\n");
+	if (bhi_mitigation == BHI_MITIGATION_VMEXIT_ONLY) {
+		pr_info("Spectre BHI mitigation: SW BHB clearing on VM exit only\n");
+		setup_force_cpu_cap(X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT);
+		return;
+	}
 
-	/* Mitigate syscalls when the mitigation is forced =on */
+	pr_info("Spectre BHI mitigation: SW BHB clearing on syscall and VM exit\n");
 	setup_force_cpu_cap(X86_FEATURE_CLEAR_BHB_LOOP);
-	pr_info("Spectre BHI mitigation: SW BHB clearing on syscall\n");
+	setup_force_cpu_cap(X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT);
 }
 
 static void __init spectre_v2_select_mitigation(void)

