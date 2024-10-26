Return-Path: <linux-tip-commits+bounces-2611-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E2D49B1892
	for <lists+linux-tip-commits@lfdr.de>; Sat, 26 Oct 2024 16:25:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F1171F21066
	for <lists+linux-tip-commits@lfdr.de>; Sat, 26 Oct 2024 14:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C9BDF4ED;
	Sat, 26 Oct 2024 14:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ksq6w1Bj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cw0hQG0m"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFD779FD;
	Sat, 26 Oct 2024 14:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729952747; cv=none; b=alW3BoZbOP70dsePqJ3UnzknVHMBq5X8oP8IehC6rYwufFQjMbPOxlQcUzJz7Gysk7x/+Gzu3sfvtQYlQynCoxyjD1IGIEnAgWibtUKzW6z0Cqh+2EwcXzCkuvmJrdSIf/g99tDaGXQw3mMVoaYb/vZGMBHJdAvBBxvQn9pblIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729952747; c=relaxed/simple;
	bh=hHIRHChLjyWtBJ/5S9pXJQp00MwjxbgDuQj5UmOmdzM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=WROgAZsZMRdy9EIWWLAuOgkFKu6dlIGLtEJVe827MKymgx32BrtxA8YD++22DZ91XZNNyPAckCCciFk7eaOTFXsU7AzITtxRKl3gAjG1pxmw56H7qy8HkuI9yn6ZM9cadFP02Ifa9199eHI8q1Q4tO1QRFaasSgD3EFZd94cNIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ksq6w1Bj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cw0hQG0m; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 26 Oct 2024 14:25:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729952742;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wzYhVbYdJeuvqWa1aHDzu9DZQBFoDFW1wr82aVvp7eg=;
	b=ksq6w1BjFNTbvw1QU7BbYpXquALeIqyAKrE7yveUt9UoZ/fhVhghOU2qsfHFcKzbrvOGiO
	pM1yjqV0OPcVox4EkvbNIIgog2SuagA+6SzfbHibW9avapbNaXM2m1XIVeO03dWvx0ew8B
	667myGpdboFW5faSLqJffHSq6/+e8BnHCng64w6jrAu7NDlzdOURgZp9dVfnJBH8bJRKMN
	pzWgqBmVrRY/f96Y+bIAkHTJUNR1AbESMBLqJPdgthN+W5fpgyt24v69HV6yR6c89/SDO4
	zavYmbOnUIEQxy2myoDI+Iu0pKzBqa2A+wguJofISEmOwSuH9+SLXE2Aj4gVCg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729952742;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wzYhVbYdJeuvqWa1aHDzu9DZQBFoDFW1wr82aVvp7eg=;
	b=cw0hQG0mCa38BxioSxkP2FH4RYXMSwzN8YkfPYw3PG7rTWFWijCh/I/W+kIAfWa6OszkUI
	BiXsIPqe2uLmUSAA==
From: "tip-bot2 for Thorsten Blum" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/cleanups] x86/cpu: Use str_yes_no() helper in show_cpuinfo_misc()
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241026110808.78074-1-thorsten.blum@linux.dev>
References: <20241026110808.78074-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172995274114.1442.11782241347849393320.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     7565caab47e89e9681a2c4439100e78f520833fa
Gitweb:        https://git.kernel.org/tip/7565caab47e89e9681a2c4439100e78f520833fa
Author:        Thorsten Blum <thorsten.blum@linux.dev>
AuthorDate:    Sat, 26 Oct 2024 13:08:06 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Sat, 26 Oct 2024 15:37:15 +02:00

x86/cpu: Use str_yes_no() helper in show_cpuinfo_misc()

Remove hard-coded strings by using the str_yes_no() helper function.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20241026110808.78074-1-thorsten.blum@linux.dev
---
 arch/x86/kernel/cpu/proc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/proc.c b/arch/x86/kernel/cpu/proc.c
index e65fae6..41ed01f 100644
--- a/arch/x86/kernel/cpu/proc.c
+++ b/arch/x86/kernel/cpu/proc.c
@@ -41,11 +41,11 @@ static void show_cpuinfo_misc(struct seq_file *m, struct cpuinfo_x86 *c)
 		   "fpu_exception\t: %s\n"
 		   "cpuid level\t: %d\n"
 		   "wp\t\t: yes\n",
-		   boot_cpu_has_bug(X86_BUG_FDIV) ? "yes" : "no",
-		   boot_cpu_has_bug(X86_BUG_F00F) ? "yes" : "no",
-		   boot_cpu_has_bug(X86_BUG_COMA) ? "yes" : "no",
-		   boot_cpu_has(X86_FEATURE_FPU) ? "yes" : "no",
-		   boot_cpu_has(X86_FEATURE_FPU) ? "yes" : "no",
+		   str_yes_no(boot_cpu_has_bug(X86_BUG_FDIV)),
+		   str_yes_no(boot_cpu_has_bug(X86_BUG_F00F)),
+		   str_yes_no(boot_cpu_has_bug(X86_BUG_COMA)),
+		   str_yes_no(boot_cpu_has(X86_FEATURE_FPU)),
+		   str_yes_no(boot_cpu_has(X86_FEATURE_FPU)),
 		   c->cpuid_level);
 }
 #else

