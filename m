Return-Path: <linux-tip-commits+bounces-6023-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7650AFC7C8
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Jul 2025 12:05:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 783111BC41CF
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Jul 2025 10:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F3426B74E;
	Tue,  8 Jul 2025 10:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="txa2hLm4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uV/QZtoS"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8342A26A0C6;
	Tue,  8 Jul 2025 10:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751969042; cv=none; b=YjD0b3D1/P0xTZVH1jebA1OIjVlJ1OV5dhott60+E5kyTY03Q15fpfrAvPtFF7Te3ClUY6p7mMtF5KjxWAanolF0U/kHBb/ZXPW/Pf7BdrbXhwpPSYcOJ84svqPis3SrRHwY3ZBX2eEZCq6md275KKIXCPzkMTXKNWP71DhDO3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751969042; c=relaxed/simple;
	bh=7gilbzcnFKneFvFVd6RlLrHBh4v3snk/zXznilkP1qg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=OhLesxFC5vPSG9lx+x+DJUlzF0e5rNFzmHfXxqxBuaWNS+6GmzNVFoBPq0IBAbhcXICulfMl/47Wnj3n5FiadW/ln0UWyeAjQyiBoBxS3fdM06NAlnenbEq0uh4UmcgyDmvbKjDXNWDqShG9Gsyk7VHHzLNIX/6LkgAUiHuFkVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=txa2hLm4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uV/QZtoS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 08 Jul 2025 10:03:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751969036;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WgnvtZS+BOMZGsikvw9xgyyY2Eeu0HsBgwvUdS6Dp1g=;
	b=txa2hLm4yfE6GQt9sguE4iy3HraPKU8hxzcXoCjgecb6GFtjc/nKGchFW2RkJw7VwN78EI
	dsdW/nznXpa6fM0mMz1q2OeN7PbiDh2S6gXzFSjbDf0yHgFZBQw4GFhxI0R0rmmngJnRVF
	sfapiP3g6gdPWn6I7FGrsCeAj9g65jknWigCa2LRtkVqY+Acduqm8wim8ayWgtTnmIJwiy
	DLV8dHsXtmORhqThb1N9pHFdJnCGwT3eEcknrKYo9hX0LCCAZTc6kFAhRE8+XEgOqqmQLz
	h5kipwpXWfxSq6ev32/Bm8+SKQZyLGNXQbsQlOjUMkTSe0PrSibHptgMKJRyWQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751969036;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WgnvtZS+BOMZGsikvw9xgyyY2Eeu0HsBgwvUdS6Dp1g=;
	b=uV/QZtoSTQdCojYSxtYxsPf7yEhWmfy+PeuOJz2sm6JzaCfE3HvJA8Zsw5lncWiqLT+34Y
	FjXtqW/rZCbk8IDQ==
From: "tip-bot2 for Perry Yuan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/platform] x86/process: Clear hardware feedback history for
 AMD processors
Cc: Perry Yuan <perry.yuan@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, ilpo.jarvinen@linux.intel.com,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250609200518.3616080-10-superm1@kernel.org>
References: <20250609200518.3616080-10-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175196903576.406.13041437070983440590.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/platform branch of tip:

Commit-ID:     9e8f6bf782a96d45a25ef9bc17db06bafb6b3e21
Gitweb:        https://git.kernel.org/tip/9e8f6bf782a96d45a25ef9bc17db06bafb6=
b3e21
Author:        Perry Yuan <perry.yuan@amd.com>
AuthorDate:    Mon, 09 Jun 2025 15:05:14 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 07 Jul 2025 22:30:36 +02:00

x86/process: Clear hardware feedback history for AMD processors

Incorporate a mechanism within the context switching code to reset the
hardware history for AMD processors. Specifically, when a task is switched in,
the class ID is read and the hardware workload classification history of the
CPU firmware is reset. Then, the workload classification for the next running
thread is begun.

  [ bp: Massage commit message. ]

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Co-developed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
Link: https://lore.kernel.org/20250609200518.3616080-10-superm1@kernel.org
---
 arch/x86/kernel/process_64.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index b972bf7..52a5c03 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -707,6 +707,10 @@ __switch_to(struct task_struct *prev_p, struct task_stru=
ct *next_p)
 	/* Load the Intel cache allocation PQR MSR. */
 	resctrl_arch_sched_in(next_p);
=20
+	/* Reset hw history on AMD CPUs */
+	if (cpu_feature_enabled(X86_FEATURE_AMD_WORKLOAD_CLASS))
+		wrmsrl(MSR_AMD_WORKLOAD_HRST, 0x1);
+
 	return prev_p;
 }
=20

