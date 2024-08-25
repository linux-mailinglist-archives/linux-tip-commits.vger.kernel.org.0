Return-Path: <linux-tip-commits+bounces-2108-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FA4A95E359
	for <lists+linux-tip-commits@lfdr.de>; Sun, 25 Aug 2024 14:37:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 131BD1C20BDB
	for <lists+linux-tip-commits@lfdr.de>; Sun, 25 Aug 2024 12:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 189C0154C11;
	Sun, 25 Aug 2024 12:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KkZrmgQ8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0VERNtkR"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580246F2E0;
	Sun, 25 Aug 2024 12:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724589435; cv=none; b=kcsjkU8BD/XFHDcEruhwbExQkBLsK1jXcQcsourlDOQ1dYxrlKpOlv6Q8trdM559kjue0YIx0L8PDhwDMkb647ekmaA1Ex85hIVMerVFSFqWkVOYMb7eAA1syxQ7ddWyeLJNvZbgMPigiKn1Z4DJf+3WGKV1jvyyzMX26JkRl08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724589435; c=relaxed/simple;
	bh=rfDck3qf9DcKnTy20mKF6PFk4nJ/1el696iBWWGGaVM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=qhgJWSJ/0KgYBlUOY8OYpMpv9FusSkqkgdZUjnKdp8w78Ukkz4UwXH8dq+b+D2w+8YG1aB/bhK/gkesm2vuDHKhgfj79bdlTZjkdv0NmzlLY6x3HPguL7bEE5uH93wxg8K1DpCNe4i9M0HOUxzqddZ4Kh0oeZXiMs1HbON9D3WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KkZrmgQ8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0VERNtkR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 25 Aug 2024 12:37:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724589432;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7Yd27D7GWAdfF4eCLpg7GNiyr0+N6E7YUAwnKvYx8SM=;
	b=KkZrmgQ8EUc6f0HoytCkW2kxQOhBpTuKN9JZElJWlD7P957d8VLbvJNTB5qcemNVPwe+/Q
	G06Bmtp3vTtzGqMBpYZ48OmoHRe0K4naPJC2kdtjMalVPgeg5i9Fg4UvJ8nC3f+fJaX/Tj
	U1JhQuaaijD/P0H9vyPNitFln4xoBP8OphSaMqVDKJSz3m6ynSfzr7EP9dfOPxtZ/UYivJ
	KkWQJk0yX5Qcm5GFIOcJM8v1NA8qH0F1rqt3P5dm6SmY8Lg4Hl5TyNTIS+1V4BYkDBPpXB
	Kl3oecm8aHJwdW50aLdq4QLXrdjChA9rsRr/XozwVERUAT0GTXeLCLlMcr/yMw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724589432;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7Yd27D7GWAdfF4eCLpg7GNiyr0+N6E7YUAwnKvYx8SM=;
	b=0VERNtkRSDXKFOHt7phDJ3JDpHWy0nVz3iijxY4HFOOSe6fxqta6+760Z1NOhxBuv9qMpq
	nawloSCD8/1wG4Cg==
From: "tip-bot2 for Gaosheng Cui" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/mtrr: Remove obsolete declaration for
 mtrr_bp_restore()
Cc: Gaosheng Cui <cuigaosheng1@huawei.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240824120234.2516830-1-cuigaosheng1@huawei.com>
References: <20240824120234.2516830-1-cuigaosheng1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172458943231.2215.5248898838647596696.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     741fc1d788c0aff3022249e561fd489c7adaded3
Gitweb:        https://git.kernel.org/tip/741fc1d788c0aff3022249e561fd489c7adaded3
Author:        Gaosheng Cui <cuigaosheng1@huawei.com>
AuthorDate:    Sat, 24 Aug 2024 20:02:34 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 25 Aug 2024 14:29:38 +02:00

x86/mtrr: Remove obsolete declaration for mtrr_bp_restore()

mtrr_bp_restore() has been removed in commit 0b9a6a8bedbf ("x86/mtrr: Add a
stop_machine() handler calling only cache_cpu_init()"), but the declaration
was left behind. Remove it.

Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20240824120234.2516830-1-cuigaosheng1@huawei.com

---
 arch/x86/include/asm/mtrr.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/include/asm/mtrr.h b/arch/x86/include/asm/mtrr.h
index 090d658..4218248 100644
--- a/arch/x86/include/asm/mtrr.h
+++ b/arch/x86/include/asm/mtrr.h
@@ -69,7 +69,6 @@ extern int mtrr_add_page(unsigned long base, unsigned long size,
 			 unsigned int type, bool increment);
 extern int mtrr_del(int reg, unsigned long base, unsigned long size);
 extern int mtrr_del_page(int reg, unsigned long base, unsigned long size);
-extern void mtrr_bp_restore(void);
 extern int mtrr_trim_uncached_memory(unsigned long end_pfn);
 extern int amd_special_default_mtrr(void);
 void mtrr_disable(void);
@@ -117,7 +116,6 @@ static inline int mtrr_trim_uncached_memory(unsigned long end_pfn)
 	return 0;
 }
 #define mtrr_bp_init() do {} while (0)
-#define mtrr_bp_restore() do {} while (0)
 #define mtrr_disable() do {} while (0)
 #define mtrr_enable() do {} while (0)
 #define mtrr_generic_set_state() do {} while (0)

