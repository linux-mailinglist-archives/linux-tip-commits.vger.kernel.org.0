Return-Path: <linux-tip-commits+bounces-6414-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EC71CB3FCC4
	for <lists+linux-tip-commits@lfdr.de>; Tue,  2 Sep 2025 12:38:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B98FA4E3C1A
	for <lists+linux-tip-commits@lfdr.de>; Tue,  2 Sep 2025 10:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AED22FABF2;
	Tue,  2 Sep 2025 10:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GmzcJ8Bv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8VOWudJ1"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09882F99A4;
	Tue,  2 Sep 2025 10:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756809412; cv=none; b=BTNSRg3b+MUE3ld5K83eIyAv11Z1YRPCdNmeJc/vMoRmN6OUuCGQz3xTjuT4jKeILswyJuOpWshW8Cm/N2DMn8LrnLl5G/W5hd3jhuBdRKHW3JU5FYtzCeSuD4ECELmUVtIu+ynvYOyzAYzSxPP5yxxbuCgsOou0wo6634HKqSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756809412; c=relaxed/simple;
	bh=zHewxLTETJ3pAsmhfx0j2JEAKgCy5q0SbC5G2FgoMnU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=NeRzi4zQo4w15snIttw+WqtocAiJGjlGgJX9OlcMPNaQZGp4tYC1bzCAz2g5fISBgb07ldGKBdjB+Uf0PmvVHkJxcKok/tW1BJJKvOjVAN3xLAuSgOuAeKBANC9R86QZps2iVsrpPxG4ZtkTAOx+dQd5NHyC78WXWYO3rxhaiIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GmzcJ8Bv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8VOWudJ1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 02 Sep 2025 10:36:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756809408;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s3/pTcKkVDdFau9jtXI4u9mgmLvsJOZiDKlCAa6xnWU=;
	b=GmzcJ8BvGBYmO1t9/b/kptGIjh063N/Xr6SGgCZAoIm0hWPAJCzhUOGA39RqJKm0B/JE4t
	Hd4it3Si4N1D9uTwq0FLpuAQjXxUzk/UpivU26gazm6SUqfNMQmH0EOhh9wTimneqY3YIU
	scmq3Iv8KUp/rsNLPKwB7NIBFi+T04DpS6k7n5iDJ0H8Gfsm1hevVAI9cig0pffhXMycpd
	vPk7lvSwba9SoMdMxntBpzg0pQMnJeAu6Z7hjKjNQGRh47X68Pbh/+xZrQj9nsuxXxNGii
	uXtvHItrZAN07FJstE1lHABdtagaC1FfZ2E1zjVtGkBI8wqtPU1tuS0UHn/xuw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756809408;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s3/pTcKkVDdFau9jtXI4u9mgmLvsJOZiDKlCAa6xnWU=;
	b=8VOWudJ1GfO6EPwOgWnrYrJtzJ7cxJLS3PP0g4hby+uD0WQ2rVKyyYe5dlzz24IJ/7N2fj
	cJGszRsKQZ23+pBQ==
From: "tip-bot2 for Neeraj Upadhyay" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/apic: Initialize APIC ID for Secure AVIC
Cc: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Tianyu Lan <tiala@microsoft.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250828110255.208779-2-Neeraj.Upadhyay@amd.com>
References: <20250828110255.208779-2-Neeraj.Upadhyay@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175680940770.1920.14902722425798051621.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     45e2cef568cdf87cb06c9783b45c8f08d1ab1cec
Gitweb:        https://git.kernel.org/tip/45e2cef568cdf87cb06c9783b45c8f08d1a=
b1cec
Author:        Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
AuthorDate:    Thu, 28 Aug 2025 16:32:41 +05:30
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 01 Sep 2025 12:21:55 +02:00

x86/apic: Initialize APIC ID for Secure AVIC

Initialize the APIC ID in the Secure AVIC APIC backing page with the APIC_ID
MSR value read from the hypervisor. CPU topology evaluation later during boot
would catch and report any duplicate APIC ID for two CPUs.

Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Tianyu Lan <tiala@microsoft.com>
Link: https://lore.kernel.org/20250828110255.208779-2-Neeraj.Upadhyay@amd.com
---
 arch/x86/kernel/apic/x2apic_savic.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/kernel/apic/x2apic_savic.c b/arch/x86/kernel/apic/x2api=
c_savic.c
index 5479605..56c51ea 100644
--- a/arch/x86/kernel/apic/x2apic_savic.c
+++ b/arch/x86/kernel/apic/x2apic_savic.c
@@ -150,6 +150,12 @@ static void savic_setup(void)
 	enum es_result res;
 	unsigned long gpa;
=20
+	/*
+	 * Before Secure AVIC is enabled, APIC MSR reads are intercepted.
+	 * APIC_ID MSR read returns the value from the hypervisor.
+	 */
+	apic_set_reg(ap, APIC_ID, native_apic_msr_read(APIC_ID));
+
 	gpa =3D __pa(ap);
=20
 	/*

