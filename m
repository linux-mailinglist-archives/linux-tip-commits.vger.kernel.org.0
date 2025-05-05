Return-Path: <linux-tip-commits+bounces-5236-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F4A0AA8D01
	for <lists+linux-tip-commits@lfdr.de>; Mon,  5 May 2025 09:28:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 041D8172414
	for <lists+linux-tip-commits@lfdr.de>; Mon,  5 May 2025 07:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0A8B1C84B8;
	Mon,  5 May 2025 07:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WWPOc8gi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nqunFJhM"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D8A14B965;
	Mon,  5 May 2025 07:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746430082; cv=none; b=Df3PF0+LKNmTMf0oX5ZKXt7AbW1gObVoPeyfpGBN0W+36HsM/anHtXjAZ44QcGj2o71TkQS2WoOB9fNfOIwyXqFyTvTTGk0cMWnaq4lYrLmHlfwIF1QW815VKr9cjXgIu+pmCTQ+LvshETl5V7+0s/2/th+20x9fcBO4gVEx+Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746430082; c=relaxed/simple;
	bh=EMpjTrVP7Muy8LDZ7un1XOQfONbyT7mImHRw3TVgdeE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=rDar6OuavX3U+0IQPRAvtCL+QbfNro3cYN/+7TetPyOiE6Zn4oNIV2Gbk6oeQKDB02Ew9J73scXd/qOD3RLlB+eHZ4yMXUW0797NcsiWEhtVKmLZRUhM3YM7LIR7E/SDj/kbt09ETl7RT9na07N5zCmP5Unx7XYBkPdwvBQB4MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WWPOc8gi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nqunFJhM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 05 May 2025 07:27:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746430079;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UyutDNDRPfzV8iJMQOIf6v8opsRf58XJyVO/1wouH1I=;
	b=WWPOc8giQB1jwLlmELb2QXkEYavO1JONrUuHZq8PcZVuTR+C0f2mDi7eF1LailsOPxxN3C
	X9vg+UD6IaWa8ecHDTByzhVTXNU1eSQZXW65fpD9frM6Z+AMnxNvP0CYeB0qBbphnQQBAq
	X0MQF9r4ltLS7obixBaNnrYOrydAb6BsAqaoJgAdPmmPO76G5P8smjjZ8c/Q+m2Am6dix0
	xCsB7KO/a0al5DAtvRT6oPXRzFliZarY3k0KE1zEYqK9PCi7+YZy2nQ6CG+r562QpniQpG
	SKDHiHxsfd8qh1ptmDnCQetwv9PvzN41/9s0p2D8LCZDHr6GmBAWWT3S8Zj/7g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746430079;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UyutDNDRPfzV8iJMQOIf6v8opsRf58XJyVO/1wouH1I=;
	b=nqunFJhMIQkd8tUkiPTV9ymMIc2z31z11IrtcT1fjQD8t3ZTmPEOuYgSQzlZQI17hko4fZ
	BMlcu/T6IxltqfBA==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] x86/microcode: Add microcode_loader_disabled()
 storage class for the !CONFIG_MICROCODE case
Cc: Ingo Molnar <mingo@kernel.org>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <aBhJVJDTlw2Y8owu@gmail.com>
References: <aBhJVJDTlw2Y8owu@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174643007386.22196.2314623556293613130.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/microcode branch of tip:

Commit-ID:     59e820c6de60e81757211fbb846129485e337ee0
Gitweb:        https://git.kernel.org/tip/59e820c6de60e81757211fbb846129485e3=
37ee0
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Mon, 05 May 2025 07:15:04 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 05 May 2025 09:17:02 +02:00

x86/microcode: Add microcode_loader_disabled() storage class for the !CONFIG_=
MICROCODE case

Fix this build bug:

  ./arch/x86/include/asm/microcode.h:27:13: warning: no previous prototype fo=
r =E2=80=98microcode_loader_disabled=E2=80=99 [-Wmissing-prototypes]

by adding the 'static' storage class to the !CONFIG_MICROCODE
prototype.

Also, while at it, add all the other storage classes as well for this
block of prototypes, 'extern' and 'static', respectively.

( Omitting 'extern' just because it's technically not needed
  is a bad habit for header prototypes and leads to bugs like
  this one. )

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: "Borislav Petkov (AMD)" <bp@alien8.de>
Link: https://lore.kernel.org/r/aBhJVJDTlw2Y8owu@gmail.com
---
 arch/x86/include/asm/microcode.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/microcode.h b/arch/x86/include/asm/microcod=
e.h
index d53148f..b68fc9d 100644
--- a/arch/x86/include/asm/microcode.h
+++ b/arch/x86/include/asm/microcode.h
@@ -14,15 +14,15 @@ struct ucode_cpu_info {
 };
=20
 #ifdef CONFIG_MICROCODE
-void load_ucode_bsp(void);
-void load_ucode_ap(void);
-void microcode_bsp_resume(void);
-bool __init microcode_loader_disabled(void);
+extern void load_ucode_bsp(void);
+extern void load_ucode_ap(void);
+extern void microcode_bsp_resume(void);
+extern bool __init microcode_loader_disabled(void);
 #else
 static inline void load_ucode_bsp(void)	{ }
 static inline void load_ucode_ap(void) { }
 static inline void microcode_bsp_resume(void) { }
-bool __init microcode_loader_disabled(void) { return false; }
+static inline bool microcode_loader_disabled(void) { return false; }
 #endif
=20
 extern unsigned long initrd_start_early;

