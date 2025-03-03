Return-Path: <linux-tip-commits+bounces-3931-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C8A3A4E177
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 15:44:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB80917AD6D
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 14:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E69827C146;
	Tue,  4 Mar 2025 14:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZFFiCPCg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="p5zYz4L1"
Received: from beeline1.cc.itu.edu.tr (beeline1.cc.itu.edu.tr [160.75.25.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5AA27935A
	for <linux-tip-commits@vger.kernel.org>; Tue,  4 Mar 2025 14:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=160.75.25.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741098943; cv=pass; b=dovo52CrEsH1r+3OLE82q+ljfSJyDzdDE7fwD/XDxoJYSftxr7aWpb+AE8qmMkVlT1P8QCCxTrIuNQe8G5pjW9dctMXRUL+qxsCALeqY3bZ1Fh/r6rwygpwn555d8ZDnmzVqkuJz1dpJVpEPGq2o0ZXlUr4SvJeI1ZV1UZyM9cU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741098943; c=relaxed/simple;
	bh=wYOBcnI3XVtlHLC1GGMPUeDv5qroZJftBhJv4x7ysSY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=WhDqe2cG4l/1q1PmbR4wjw6HxkqUsbL/m/oeqa3cErfSOLb+uSvtj7QOU07NPA0342R2YaS10hSjsF9gprMtJ47JnzIVjqlVJ1BFI5Zwnh7UTQc/DlyVt0LNoPNGe90GAXTjvFrNwUZEccTtiUVIVk1SfU+VYqAYK1tubonSWF8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZFFiCPCg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=p5zYz4L1; arc=none smtp.client-ip=193.142.43.55; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; arc=pass smtp.client-ip=160.75.25.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (unknown [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline1.cc.itu.edu.tr (Postfix) with ESMTPS id BF12340D0479
	for <linux-tip-commits@vger.kernel.org>; Tue,  4 Mar 2025 17:35:39 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Authentication-Results: lesvatest1.cc.itu.edu.tr;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=ZFFiCPCg;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=p5zYz4L1
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6dTf2fmxzFwwr
	for <linux-tip-commits@vger.kernel.org>; Tue,  4 Mar 2025 17:33:42 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 7509842728; Tue,  4 Mar 2025 17:33:33 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZFFiCPCg;
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=p5zYz4L1
X-Envelope-From: <linux-kernel+bounces-541359-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZFFiCPCg;
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=p5zYz4L1
Received: from fgw1.itu.edu.tr (fgw1.itu.edu.tr [160.75.25.103])
	by le2 (Postfix) with ESMTP id 1D880433DB
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 13:23:48 +0300 (+03)
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by fgw1.itu.edu.tr (Postfix) with SMTP id C7C43305F789
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 13:23:47 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FC8C16501F
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 10:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C7911F30DE;
	Mon,  3 Mar 2025 10:23:12 +0000 (UTC)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCAFC1F0E3D;
	Mon,  3 Mar 2025 10:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740997389; cv=none; b=Eqqet5xPSyj3sMVcGhEkB/jPefFkrVR2cuLF5bES9k7xgWHqRLNg5a803jNM9P+rKvuUuLRYeDAI4azWfxlRc5y/NLBWV+IE4JsDRX6gUAGKD/TRks6TyirTFJYJM2MW+VZo/3vhqd0AIt70Kd645qJ3c3VigES+XIeDBGIoABg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740997389; c=relaxed/simple;
	bh=wYOBcnI3XVtlHLC1GGMPUeDv5qroZJftBhJv4x7ysSY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=OFFCOkLRfG9O+bj3EEqT1spG3g2MXmOSwhtHRuYTSITOI+zryZgRZjDHKMAV8QBF/VzWMRxG8E239wucooG6ylsqCNpRvRhG1MUkTkkDY+j/XZdnRxDkIHiVanlS/MRPcrRIVLG5lsFunkZgSlJrjdG2wDzjjZvB8/WLJ9duefI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZFFiCPCg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=p5zYz4L1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 03 Mar 2025 10:23:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740997385;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ForH1bO4z81FxmkT/jXljNK17Iu9LFYhxm7JTnTzFFQ=;
	b=ZFFiCPCgDonw1ELW9ODtIoYot9dJpxZ0M4MTfqqNfeR88k0IlpCuVkqAHEW0g7IGGHyHI8
	EZc9JQ0RCX3VXmm3LPqBYZdv4qaAljp0G23kSTjuOXBf1ds1aQHtNMIApP3/FhSBEn6vQ7
	mPy2YtnfchSe0g4sfphviGc8ZpPTn5jHvqhhfy7k4/ZYTPnYBLX0HF9y+w17JdeCs6rTqS
	CdhmJj5Pj/20EKUyXzqRgws4YLvX2SXZOzJ6MGbB7c6RsTEnNYKaF6fTUKIlT652ohiK2w
	Hq0QDGuN5R17p76x3ClxrPUN9lDu4ofhOcTRSdJXyvzigtPFWT5TcE7dg+adtw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740997385;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ForH1bO4z81FxmkT/jXljNK17Iu9LFYhxm7JTnTzFFQ=;
	b=p5zYz4L1jQ870pXiNwac2RymCnIH/KmcNYOi4SHeVvAYSRv2EfsPH1uIC5llk/lg+58x7x
	NmsOWlthgL0Ji7AA==
From: "tip-bot2 for Lukas Bulwahn" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] xen: Kconfig: Drop reference to obsolete configs
 MCORE2 and MK8
Cc: Lukas Bulwahn <lukas.bulwahn@redhat.com>, Ingo Molnar <mingo@kernel.org>,
 Juergen Gross <jgross@suse.com>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250303093759.371445-1-lukas.bulwahn@redhat.com>
References: <20250303093759.371445-1-lukas.bulwahn@redhat.com>
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174099738443.10177.5303212192707444006.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6dTf2fmxzFwwr
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741703635.2169@NBW/mjAhy+3ycKRneKgWyA
X-ITU-MailScanner-SpamCheck: not spam

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     5c98a674dcb85be3f42854a80e630f08b436131e
Gitweb:        https://git.kernel.org/tip/5c98a674dcb85be3f42854a80e630f08b436131e
Author:        Lukas Bulwahn <lukas.bulwahn@redhat.com>
AuthorDate:    Mon, 03 Mar 2025 10:37:59 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 03 Mar 2025 11:15:07 +01:00

xen: Kconfig: Drop reference to obsolete configs MCORE2 and MK8

Commit f388f60ca904 ("x86/cpu: Drop configuration options for early 64-bit CPUs")
removes the config symbols MCORE2 and MK8.

With that, the references to those two config symbols in xen's x86 Kconfig
are obsolete. Drop them.

Fixes: f388f60ca904 ("x86/cpu: Drop configuration options for early 64-bit CPUs")
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Juergen Gross <jgross@suse.com>
Link: https://lore.kernel.org/r/20250303093759.371445-1-lukas.bulwahn@redhat.com
---
 arch/x86/xen/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/xen/Kconfig b/arch/x86/xen/Kconfig
index 77e788e..98d8a50 100644
--- a/arch/x86/xen/Kconfig
+++ b/arch/x86/xen/Kconfig
@@ -9,7 +9,7 @@ config XEN
 	select PARAVIRT_CLOCK
 	select X86_HV_CALLBACK_VECTOR
 	depends on X86_64 || (X86_32 && X86_PAE)
-	depends on X86_64 || (X86_GENERIC || MPENTIUM4 || MCORE2 || MATOM || MK8)
+	depends on X86_64 || (X86_GENERIC || MPENTIUM4 || MATOM)
 	depends on X86_LOCAL_APIC && X86_TSC
 	help
 	  This is the Linux Xen port.  Enabling this will allow the


