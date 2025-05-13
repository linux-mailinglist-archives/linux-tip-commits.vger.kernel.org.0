Return-Path: <linux-tip-commits+bounces-5529-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F461AB5E3C
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 May 2025 23:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2DF019E7044
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 May 2025 21:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B502E1F76C2;
	Tue, 13 May 2025 21:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ErujLYNA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2Il958TQ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C6C53365;
	Tue, 13 May 2025 21:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747170364; cv=none; b=m/FG0lX0r6tmNRiQLY9RO/umKoA40rqkifW+uQ8dST/Cu5TAr4a0mu/XOYIFvfh+0X5DMfeYMzgaOpN5UerXV/Amt1nD0PGaWC5hhSDwazgBkeM95/ci2kDBFo7/4us155GUyzS5pqSWjwL1ZRqR7v1GVeHPJHTelgYyYZkES0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747170364; c=relaxed/simple;
	bh=ed9/47FWrNsalFiLyCe8DUotofjuDTZjnyhZJw8VoEY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=HPVyrpk3xBwdBHTGblI0Tynh0xL9ynpKDBGpZ4zuya0k/OujanVunzQzUS92yL0Q1Fi/noagbsOSeYuct5kFeHXQOExEosESTgzovH7wejemz0tgfCWQm2NjQ/tLbURyxqi0o6Uw6v4lkNH2c9YXBmDsS07mJMiWULSMgeO+cso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ErujLYNA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2Il958TQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 13 May 2025 21:05:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747170358;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kYbvQXSqsrpWKgI0ARIijGnYFej3O36gLn3mVBYtK+s=;
	b=ErujLYNAagd4tTRAkYDrsDfTLOKvGkX0fk3+8jdMThPvuPRPAQs/HL8F3/yJoSjwlL1rXp
	mcVWhA3Z/81EsMRlkF95eBqJqZ/iCoEFmdXRB4w5MmAVbevtH7Tdj5YjI9T7fU0h5Bu5e6
	383MbSa9Vdxw+JgJDzWsr/FyHZrkY+HeLhlp4PxEvhFMnxQZPQQIZCg4H3WCd8zXcjgaXy
	wBt/gssYPI6P+sqeaoxKkZUwHXqxi8odc5P0rqn6JYmnB17Mzi6jBVwq6ivRcgFiBvVlzh
	CdyTJDRQyKC2/wMQHt4U7ttoXCVy3ODRwrq/fGQJIqMyS5DzGe4eADKdvMHnzw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747170358;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kYbvQXSqsrpWKgI0ARIijGnYFej3O36gLn3mVBYtK+s=;
	b=2Il958TQ/tEwovudOhyceNna9wdl1RalmI4K03ZAgveJQ/DhhjNkvIlN7IixodmXQcqDCr
	n4etwjPuNXi6ioCQ==
From: "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/core] x86/bugs: Fix SRSO reporting on Zen1/2 with SMT disabled
Cc: "Borislav Petkov (AMD)" <bp@alien8.de>,
 David Kaplan <david.kaplan@amd.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250513110405.15872-1-bp@kernel.org>
References: <20250513110405.15872-1-bp@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174717035700.406.11853328229238715261.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     891d3b8be32a69ae94d32e3f1e1ee01359020d49
Gitweb:        https://git.kernel.org/tip/891d3b8be32a69ae94d32e3f1e1ee01359020d49
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Tue, 13 May 2025 13:04:05 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 13 May 2025 22:31:08 +02:00

x86/bugs: Fix SRSO reporting on Zen1/2 with SMT disabled

1f4bb068b498 ("x86/bugs: Restructure SRSO mitigation") does this:

  if (boot_cpu_data.x86 < 0x19 && !cpu_smt_possible()) {
          setup_force_cpu_cap(X86_FEATURE_SRSO_NO);
          srso_mitigation = SRSO_MITIGATION_NONE;
          return;
  }

and, in particular, sets srso_mitigation to NONE. This leads to
reporting

  Speculative Return Stack Overflow: Vulnerable

on Zen2 machines.

There's a far bigger confusion with what SRSO_NO means and how it is
used in the code but this will be a matter of future fixes and
restructuring to how the SRSO mitigation gets determined.

Fix the reporting issue for now.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: David Kaplan <david.kaplan@amd.com>
Link: https://lore.kernel.org/20250513110405.15872-1-bp@kernel.org
---
 arch/x86/kernel/cpu/bugs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 47c74c4..dd8b50b 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -2942,7 +2942,9 @@ static void __init srso_update_mitigation(void)
 	    boot_cpu_has(X86_FEATURE_IBPB_BRTYPE))
 		srso_mitigation = SRSO_MITIGATION_IBPB;
 
-	if (boot_cpu_has_bug(X86_BUG_SRSO) && !cpu_mitigations_off())
+	if (boot_cpu_has_bug(X86_BUG_SRSO) &&
+	    !cpu_mitigations_off() &&
+	    !boot_cpu_has(X86_FEATURE_SRSO_NO))
 		pr_info("%s\n", srso_strings[srso_mitigation]);
 }
 

