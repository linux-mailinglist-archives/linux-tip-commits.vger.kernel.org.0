Return-Path: <linux-tip-commits+bounces-6537-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 174D5B4AC6D
	for <lists+linux-tip-commits@lfdr.de>; Tue,  9 Sep 2025 13:42:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F189345C20
	for <lists+linux-tip-commits@lfdr.de>; Tue,  9 Sep 2025 11:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 366B3280A3B;
	Tue,  9 Sep 2025 11:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OX7IE4Ka";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8WhjFqzK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B19032254F;
	Tue,  9 Sep 2025 11:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757418150; cv=none; b=YRtDKsdnXiVrw9Rt3i+zz827zSEfyEFY+ZimREMrDVH9ZzHSh+Aixpiwqc6AB38tRxp3AtUNbrtNht0DFfO6B0ayuw7Z+jipVHJ1NwyH6VKvPhosEo2vK/Q1rLlmR6+fONv+ZgaAb7wkjgPlQuYWB2tV5dWCcHVsk6a1UTsSbvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757418150; c=relaxed/simple;
	bh=1eEzPC+DfvsU6pcaHtMU5GAo/DPHdwY8NaEQnHaNLwc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=OYKnzVH3bKimUM88kEslVL8NtnsIMutwVCNAvMGXrHCrUjSaaKvvDMDuJsNaUTiHbQ581lMDgQ6llS+OBL1M1EVYzRL3svnVNeEPf3L+P6+FG3h3//h68Qh67i64YqtPc5XQNefdXyvYEWdXOAZEbox0RZO7pIODcwbRKXSLrL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OX7IE4Ka; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8WhjFqzK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 09 Sep 2025 11:42:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757418144;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=87geou+ZF0IpOlevC25Qdeivuo3bmVjmb1Wml/SA5A4=;
	b=OX7IE4KapMDrSOvIM+X3fAHe90ZjrCn26N3E/PZJXIBa28p+JX5EQv9wDyXsgQQbWEf1N9
	/W94QXWG+bgnAGfBkW1vvS9NN9wRKj1lvjt2iTVZDfSJERkp+D02f61sEP3fokgy3kQ0Aq
	brw+f0bq1g9Euwq59QnigwjzqM2PgMDHtei4onHx2m0Ca2zf6EmOeA49ArCPs9zhxUdTYR
	Q74AjCYnuXZxQ7ntlsW3dw+rWGgQ2GiEUDE04oLKCH1+9+Gbasj0RJeTrvu7rlc3f80JU4
	yY+ejxxPRQPYe62xVxtoNzYjpJMOvI7LM4JmYwdHt8AKqSUqql4Y6JuDGloXlg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757418144;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=87geou+ZF0IpOlevC25Qdeivuo3bmVjmb1Wml/SA5A4=;
	b=8WhjFqzKMkiE0XDDQ06maGpVDKGLpFuxd7DE+aOXjPGTMb7k19Bmu/vFml+bcSNsGDrAMw
	waRz5tpW79SBSOCg==
From: "tip-bot2 for Bibo Mao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/core] LoongArch: Remove clockevents shutdown call on offlining
Cc: Bibo Mao <maobibo@loongson.cn>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250906064952.3749122-3-maobibo@loongson.cn>
References: <20250906064952.3749122-3-maobibo@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175741814281.1920.17655426665881164876.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     d55dd6f5e47dd85ab2086b62f7a747d3f8be0fa0
Gitweb:        https://git.kernel.org/tip/d55dd6f5e47dd85ab2086b62f7a747d3f8b=
e0fa0
Author:        Bibo Mao <maobibo@loongson.cn>
AuthorDate:    Sat, 06 Sep 2025 14:49:52 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 09 Sep 2025 13:39:00 +02:00

LoongArch: Remove clockevents shutdown call on offlining

The clockevents core already detached and unregistered it at this stage.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250906064952.3749122-3-maobibo@loongson.cn

---
 arch/loongarch/kernel/time.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/loongarch/kernel/time.c b/arch/loongarch/kernel/time.c
index f3092f2..6fb92cc 100644
--- a/arch/loongarch/kernel/time.c
+++ b/arch/loongarch/kernel/time.c
@@ -112,8 +112,6 @@ static int arch_timer_starting(unsigned int cpu)
=20
 static int arch_timer_dying(unsigned int cpu)
 {
-	constant_set_state_shutdown(this_cpu_ptr(&constant_clockevent_device));
-
 	/* Clear Timer Interrupt */
 	write_csr_tintclear(CSR_TINTCLR_TI);
=20

