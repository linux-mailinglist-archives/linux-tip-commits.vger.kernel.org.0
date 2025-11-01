Return-Path: <linux-tip-commits+bounces-7158-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E6407C2876D
	for <lists+linux-tip-commits@lfdr.de>; Sat, 01 Nov 2025 20:55:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 262EA4F3DE1
	for <lists+linux-tip-commits@lfdr.de>; Sat,  1 Nov 2025 19:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DDB3311C09;
	Sat,  1 Nov 2025 19:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="f3By8jxJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hYTUVIei"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9AB6305048;
	Sat,  1 Nov 2025 19:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762026491; cv=none; b=d6Vr9Onl63IROm05PjdqbkKdd/HwsyfdxRRSFYL17nJ14Wwna6DrlG/YohFXzYPUAAIL/3Cu4Wy9LrI/kolQ8qdh3KPwTsQx5bGP4CtnTKerl+RJIWXMuClyr5VuzaRr7h5zz9UHSM5FUL6/G2WpGhIBgUNRjxHrwN1fpcGWtAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762026491; c=relaxed/simple;
	bh=zjw0c32m2IE+m+DZsbdZh2NDrXd+2dZfWRiYbpBMnFo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=CmLxasXBwcsng7pJhsEPut3JHrylVBUXtVxL435Gf7Fzn65kLTwyVm5snDlEOxUUyvrSkXSsIqiETUaFfh9hiA/8NiWktcvmrMBRu1Ky3aIvIRPD+UT5Zkoi6tLMjx8yWbwoFvL/cUvk3k4MYPRFceC1KIHAQC4JRCvbcjmAqbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=f3By8jxJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hYTUVIei; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 01 Nov 2025 19:48:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762026488;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NTdFyqcOEmS1osBRLGX6zOcEHloQd2EVsJxhEKu3kZU=;
	b=f3By8jxJzZUtzz329wVo7oos6KUYcKhXKYxcEuurjReFv84qTvbJfLZ2o5q5JB/W9cW7NJ
	gHT1ylZ9Er7CvPfycog2Uu4IQkEBCbmSV5882CamA+7zwqxW0sFV+fRmQhucnOdDifgeut
	Lg/6Y8kMOJ68+7WKKAwBJcRMjxEX1c8VFn2oXGemgKIk1ln9yQS8BytzorS2U9r1DOGDGx
	R6quifG4QfPdiHBt72+8uO//eTZ/pS3GMG65v2J9AXZltBKaGs4piFwnf9QLjEK5XTsbFI
	D1AINqWDlYpCaJHkRuxI1V2l1NjFUl1Ol6fux51FcpYsfzIGksVbQYbz+IKq4g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762026488;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NTdFyqcOEmS1osBRLGX6zOcEHloQd2EVsJxhEKu3kZU=;
	b=hYTUVIeivhxfKnJNRjmcudU0DqhwgZpjVCvu8EBqKj+JMLtEtyft0kdXHKd1De4PJKNtb8
	jk6T84NGC7WM8xAg==
From: tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/vdso] LoongArch: vDSO: Explicitly include asm/vdso/vdso.h
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 Andreas Larsson <andreas@gaisler.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251014-vdso-sparc64-generic-2-v4-8-e0607bf49dea@linutronix.de>
References: <20251014-vdso-sparc64-generic-2-v4-8-e0607bf49dea@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176202648677.2601451.10690062833892731010.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     e4490be00f4002eeff3cae7c8351342a85bdc098
Gitweb:        https://git.kernel.org/tip/e4490be00f4002eeff3cae7c8351342a85b=
dc098
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Tue, 14 Oct 2025 08:48:54 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 01 Nov 2025 20:44:03 +01:00

LoongArch: vDSO: Explicitly include asm/vdso/vdso.h

The usage of 'struct old_timespec32' requires asm/vdso/vdso.h. Currently
this header is included transitively, but that transitive inclusion is
about to go away.

Explicitly include the header.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Andreas Larsson <andreas@gaisler.com>
Reviewed-by: Andreas Larsson <andreas@gaisler.com>
Link: https://patch.msgid.link/20251014-vdso-sparc64-generic-2-v4-8-e0607bf49=
dea@linutronix.de
---
 arch/loongarch/kernel/process.c | 1 +
 arch/loongarch/kernel/vdso.c    | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/loongarch/kernel/process.c b/arch/loongarch/kernel/process.c
index efd9edf..84a1d3c 100644
--- a/arch/loongarch/kernel/process.c
+++ b/arch/loongarch/kernel/process.c
@@ -52,6 +52,7 @@
 #include <asm/switch_to.h>
 #include <asm/unwind.h>
 #include <asm/vdso.h>
+#include <asm/vdso/vdso.h>
=20
 #ifdef CONFIG_STACKPROTECTOR
 #include <linux/stackprotector.h>
diff --git a/arch/loongarch/kernel/vdso.c b/arch/loongarch/kernel/vdso.c
index dee1a15..663660f 100644
--- a/arch/loongarch/kernel/vdso.c
+++ b/arch/loongarch/kernel/vdso.c
@@ -18,6 +18,7 @@
=20
 #include <asm/page.h>
 #include <asm/vdso.h>
+#include <asm/vdso/vdso.h>
 #include <vdso/helpers.h>
 #include <vdso/vsyscall.h>
 #include <vdso/datapage.h>

