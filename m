Return-Path: <linux-tip-commits+bounces-7151-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D00F4C2874F
	for <lists+linux-tip-commits@lfdr.de>; Sat, 01 Nov 2025 20:54:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A10D425BBD
	for <lists+linux-tip-commits@lfdr.de>; Sat,  1 Nov 2025 19:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3361530DEB2;
	Sat,  1 Nov 2025 19:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pvhMqDPz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EKSigvXQ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4C730DD12;
	Sat,  1 Nov 2025 19:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762026482; cv=none; b=D2b07BouJviBuzYbOjr4hA9RwaH9Dm4OgJYNcyCrBmVb+CARkLsDH1+FD+yY+aM+Exqd/Pv3D/STE5e9PxerVSREFIElfJjuV6rkXOqY0OhgmqoHPAZt9hq2X3AK3K1Tho9H0gS2PGNvSfT8BtBIf43wBKOOJx/Uk5feIiU5zIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762026482; c=relaxed/simple;
	bh=rtQ3ePeGBS229OUfo/6ige/+z1hhpH7Tk2W0WcH6FYM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=dYi2jrklvsc7sHizuvg0ggvFTRTza50BOW6q/1T0Nm3Q/AC/2TOpX1OnhnHoqVi2t6mCK7Do5aoq3llL+6MGI+ohxwrWuqfaMDiee8zORo0spKtPYMk1Jec57eKaK3dzlHDOJon7OLVeWiGYZzYDt0Z38gs/4tIlAC7rmwQeb9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pvhMqDPz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EKSigvXQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 01 Nov 2025 19:47:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762026479;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a6G7BIrQImMyEAlcXk4SNPMxNWEPSwhZEda1yIkBAHI=;
	b=pvhMqDPz8hLkR+dKXSfy76aql5K8YMjIpWiyTR5EOmZkUC40lNzO0OhebzxasAktOEaJI/
	XGlU+AUxjI6Y+uMUgcOuo+72kVShAS1lPYpKBZ7fXKmjRv4IPk9G6aPAbCOLeCbNWKUe25
	6zORI3KXhM4x+NgFT8YiYqGDRnbIdQ+FBw4vojm/K+LU5AUg/cKt0W3iRK0/2NPK0l4JZc
	KwDxiMSBeoSPe5tBU0jcgp8TFBVcVHH5/WSTFf9M8t9+QBvYkLUUEIK1RBku7pE/ha/NBT
	/WingIUoKmXEecgElFuVChy1owTp3FtrU/xiTf9hSmp5lf/UEon5L02ardAVXg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762026479;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a6G7BIrQImMyEAlcXk4SNPMxNWEPSwhZEda1yIkBAHI=;
	b=EKSigvXQ2N6H796GCR8AfRJkM3LsPaQrIX/V0QvStFC+mU7OFJtTQJlTLSeccp9bVkOKTe
	9+Ln1ks3CHuhCfCA==
From: tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] vdso/datapage: Trim down unnecessary includes
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 Andreas Larsson <andreas@gaisler.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <20251014-vdso-sparc64-generic-2-v4-15-e0607bf49dea@linutronix.de>
References: <20251014-vdso-sparc64-generic-2-v4-15-e0607bf49dea@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176202647798.2601451.10563587829124072682.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     bda77a6748ca3068702d8e94697c9f65f23c00a8
Gitweb:        https://git.kernel.org/tip/bda77a6748ca3068702d8e94697c9f65f23=
c00a8
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Tue, 14 Oct 2025 08:49:01 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 01 Nov 2025 20:44:04 +01:00

vdso/datapage: Trim down unnecessary includes

vdso/datapage.h includes a lot of headers which are not strictly necessary.
Some of those headers include architecture-specific vDSO headers which
prevent the usage of vdso/datapage.h in kernel code on architectures
without an vDSO. This would be useful however to write generic code using
IS_ENABLED(), for example in drivers/char/random.c.

Remove the unnecessary includes.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Andreas Larsson <andreas@gaisler.com>
Reviewed-by: Andreas Larsson <andreas@gaisler.com>
Link: https://patch.msgid.link/20251014-vdso-sparc64-generic-2-v4-15-e0607bf4=
9dea@linutronix.de
---
 include/vdso/datapage.h | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/include/vdso/datapage.h b/include/vdso/datapage.h
index 752856b..9021b95 100644
--- a/include/vdso/datapage.h
+++ b/include/vdso/datapage.h
@@ -4,24 +4,16 @@
=20
 #ifndef __ASSEMBLY__
=20
-#include <linux/compiler.h>
+#include <linux/types.h>
+
 #include <uapi/linux/bits.h>
 #include <uapi/linux/time.h>
-#include <uapi/linux/types.h>
-#include <uapi/asm-generic/errno-base.h>
=20
 #include <vdso/align.h>
 #include <vdso/bits.h>
 #include <vdso/cache.h>
-#include <vdso/clocksource.h>
-#include <vdso/ktime.h>
-#include <vdso/limits.h>
-#include <vdso/math64.h>
 #include <vdso/page.h>
-#include <vdso/processor.h>
 #include <vdso/time.h>
-#include <vdso/time32.h>
-#include <vdso/time64.h>
=20
 #ifdef CONFIG_ARCH_HAS_VDSO_TIME_DATA
 #include <asm/vdso/time_data.h>

