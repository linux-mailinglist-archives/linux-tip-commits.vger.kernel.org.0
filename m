Return-Path: <linux-tip-commits+bounces-7150-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1FE6C28739
	for <lists+linux-tip-commits@lfdr.de>; Sat, 01 Nov 2025 20:53:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9839F1A222F2
	for <lists+linux-tip-commits@lfdr.de>; Sat,  1 Nov 2025 19:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA2230DD1F;
	Sat,  1 Nov 2025 19:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XutWG4Ko";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4aKEzLMd"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9431830CDB6;
	Sat,  1 Nov 2025 19:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762026481; cv=none; b=uiMx4VFl+RxnwTx9rr8fulTBg3r9+cCZSoHL1CNBFpbFlGvE/0jXffRD+SHjvfG/237NmUyjM6uIAFgt45c0xr6L7Jp8Gq9vLnNLgn30q015XSSrwI6XmtqIaLr/g2yZz+kDY3Kh+a5GFB/qNtOjztTjM9760ZUS6DTocwtfp5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762026481; c=relaxed/simple;
	bh=AgNtMFQNqIZWlEvJ1ebKZWQUye5w9lcSVq//DG0RAH0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=WsFG90xzA6++R7hmfc7MqnoadEZuuO7H4zm6xLb/PFTZjHIkWW2G6YQ4tIkVHlazUi+YwEDC4RYiOMjxUfR4Hca5ySiRHpbb4XTwpx/eW4xDdBBjmy8ojvcytpDvPMpcGZIcPcdYNfgWUeI9lC7hfOQPOnxl1X5oZ0L/k4p0ApQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XutWG4Ko; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4aKEzLMd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 01 Nov 2025 19:47:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762026478;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XhpEpnVS29DPLJYf754Q+McJdR263LR94I1Fs3NBqtw=;
	b=XutWG4Ko4ejOMM2Oh2tIo4VjLIa3LyFOlmgZRnUmrHHkzauRypI5tq7HpeZvha4BaMF+xa
	NvwwIsQ3T1dYvG7vZQR3BIGFBXUMiB+zj7reqK7URzBabuH26w/zmcJHaH6v/0+w8IFD9+
	1XTjhcxxdkoDrerFwvl1yxkum9Ut0I/SBXPRGyDP3ZN9PhQq+7GPfvnKFSffODyxLhQImF
	lFlONtMWO8yy9T23Hc0+w8o9plsD4oS8PmKedUXoMHUZwhcN7WV8odK1FNRQufIULzBhGD
	kzKByIlbF5vV8z29cCi56rO5rfDfRijAfG9t0ir4XLHSUvGvrY+6DGgHzXAnSQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762026478;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XhpEpnVS29DPLJYf754Q+McJdR263LR94I1Fs3NBqtw=;
	b=4aKEzLMde3sFxiNsN8v07JpWOw9RXOhA+nVj0cjf64qPOFMqQ0+k1IDqEexgEyPgw5i79W
	LR0LY35FsQPB4hDw==
From: tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] random: vDSO: Trim vDSO includes
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 Andreas Larsson <andreas@gaisler.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <20251014-vdso-sparc64-generic-2-v4-16-e0607bf49dea@linutronix.de>
References: <20251014-vdso-sparc64-generic-2-v4-16-e0607bf49dea@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176202647673.2601451.13282110398420090800.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     92ae2633c03453614723cfd1e9ba6d4b84a496cf
Gitweb:        https://git.kernel.org/tip/92ae2633c03453614723cfd1e9ba6d4b84a=
496cf
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Tue, 14 Oct 2025 08:49:02 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 01 Nov 2025 20:44:05 +01:00

random: vDSO: Trim vDSO includes

These includes are not used, remove them.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Andreas Larsson <andreas@gaisler.com>
Reviewed-by: Andreas Larsson <andreas@gaisler.com>
Link: https://patch.msgid.link/20251014-vdso-sparc64-generic-2-v4-16-e0607bf4=
9dea@linutronix.de
---
 drivers/char/random.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index b8b24b6..3860ddd 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -57,9 +57,7 @@
 #include <crypto/chacha.h>
 #include <crypto/blake2s.h>
 #ifdef CONFIG_VDSO_GETRANDOM
-#include <vdso/getrandom.h>
 #include <vdso/datapage.h>
-#include <vdso/vsyscall.h>
 #endif
 #include <asm/archrandom.h>
 #include <asm/processor.h>

