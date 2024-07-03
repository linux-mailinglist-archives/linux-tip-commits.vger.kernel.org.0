Return-Path: <linux-tip-commits+bounces-1588-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90445926906
	for <lists+linux-tip-commits@lfdr.de>; Wed,  3 Jul 2024 21:36:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1C0D1C220B4
	for <lists+linux-tip-commits@lfdr.de>; Wed,  3 Jul 2024 19:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B5218FDD6;
	Wed,  3 Jul 2024 19:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="s9N9G7N6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mPxhRtHV"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D6518E776;
	Wed,  3 Jul 2024 19:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720035382; cv=none; b=JH7fF2L4HcC3XfF7zJb2t7qO7sBsFjQ3PfUxkqajkZ3NEuEbs8Cci/WhDUboyYfAhmFjd54Y7bIPZFlu3mhpwMdEIZ3dwZ706Ww+7rzS+U2fwYApFdfs/GxbGACVtONcnNc8nfMNj5piFoPldvSgyCQiCS6ARMDXGtN/fOuhwnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720035382; c=relaxed/simple;
	bh=+THFKu/wtsS7H0I1Z6HQNQBCVuHEMgV4LgVnycWPFvY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=WZMr6qBoH1EJ0ie8AadIRqqnFeBv2GU7KGI+T7wSshkx9MX/n644gE8yv4143FnvQfU5S8jIJHX+Z5NNVQ8x3CJ5f3kOej8xcDw6L67Bs5RsJ2WRNAssRxGWdZqZ9CnWXoOybMkNfd+bn7etC4lJvht0LGBOeLWBuV4gmcs9smY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=s9N9G7N6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mPxhRtHV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 03 Jul 2024 19:36:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720035379;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H/WWyGYXyC9aHcmprycqtRc/x0KyQECRC8Vo4q1b6LU=;
	b=s9N9G7N68hbeKBwPSDU1Ikbx5GIJ6yu86NOCdWCaGp0CnYZxJ/hXn+rCMeZwrt42kHir1s
	sL+778i18/gffqTu7gQC0DXkcWASlzNQbi2W+LTXxJNo8OksQ2rBnjNSYJKVdL2sCqgevt
	vdbn2m9OCBsGhQdUkl7XdAjOcOKdhUCpajhYsMYJ3W3N+A7Ae5TofQrStn61JILFukPQzD
	QWBP6R6vjkuUmp2Shrc3f7Y+nXY+cYNtghXpd/2lkq0QQEt7G9jCq87eTAYyFfPmSleU72
	lmymmsGUJYc59//bjT4I7WPN35sueaRszYC1zfi6To+fEFYZyvrQvZgONiP//A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720035379;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H/WWyGYXyC9aHcmprycqtRc/x0KyQECRC8Vo4q1b6LU=;
	b=mPxhRtHVeFVgdgxIFaLLeTHaNPdIpT3DlamiUvlg1Grb/t0G2sQsSe1sjtBaA5JmWbNz7w
	aMI921yqoF7Zp5Ag==
From: "tip-bot2 for Anna-Maria Behnsen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] x86/vgtod: Remove unused typedef gtod_long_t
Cc: "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240701-vdso-cleanup-v1-4-36eb64e7ece2@linutronix.de>
References: <20240701-vdso-cleanup-v1-4-36eb64e7ece2@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172003537912.2215.6850257917875877429.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     ee6664d7326bb42c86692b3fdac4edcfb2beab2f
Gitweb:        https://git.kernel.org/tip/ee6664d7326bb42c86692b3fdac4edcfb2beab2f
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Mon, 01 Jul 2024 16:47:57 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 03 Jul 2024 21:27:04 +02:00

x86/vgtod: Remove unused typedef gtod_long_t

The typedef gtod_long_t is not used anymore so remove it.

The header file contains then only includes dependent on
CONFIG_GENERIC_GETTIMEOFDAY to not break ARCH=um. Nevertheless, keep the
header file only with those includes to prevent spreading ifdeffery all
over the place.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Link: https://lore.kernel.org/r/20240701-vdso-cleanup-v1-4-36eb64e7ece2@linutronix.de

---
 arch/x86/include/asm/vgtod.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/x86/include/asm/vgtod.h b/arch/x86/include/asm/vgtod.h
index 7aa38b2..a0ce291 100644
--- a/arch/x86/include/asm/vgtod.h
+++ b/arch/x86/include/asm/vgtod.h
@@ -14,11 +14,6 @@
 
 #include <uapi/linux/time.h>
 
-#ifdef BUILD_VDSO32_64
-typedef u64 gtod_long_t;
-#else
-typedef unsigned long gtod_long_t;
-#endif
 #endif /* CONFIG_GENERIC_GETTIMEOFDAY */
 
 #endif /* _ASM_X86_VGTOD_H */

