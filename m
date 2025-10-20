Return-Path: <linux-tip-commits+bounces-6964-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 05894BF2D9E
	for <lists+linux-tip-commits@lfdr.de>; Mon, 20 Oct 2025 20:02:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EF0874E1D0E
	for <lists+linux-tip-commits@lfdr.de>; Mon, 20 Oct 2025 18:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E0D28DB46;
	Mon, 20 Oct 2025 18:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GEhBZT5n";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eNEonLuj"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9961C3C11;
	Mon, 20 Oct 2025 18:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760983372; cv=none; b=rYdq16vpZRtt4KuGWhkpzJx9eBG+EhOeZAwAKtpxP0QbcDGUMLeaKRmme3J4puS78GT+opSkTQHXB8tdQ8JqF46Aixj1zkb1HY5gKIVDrZhLL0iyF+f/bcGAhozudOj3ktoxjsvH42nDujdu+vNo+2yCQLjC/4LPjHYvvzcAK/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760983372; c=relaxed/simple;
	bh=CzgOqyhzPAnGh8ZSWSiwGzhKdZ4eDSjpsnweYg1pACI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=TMqvONCuVCDkjqCDYp/6ZEm/8Xc/EmFs9S9Xg5bRBucDmoc4Km8JU5rGRay9kwItjkn9xuyLV7UhdKWQ6il5Ie6Q3FDjLeFhXiCAlCebglUwcyuJIpaZHFyiGPLiAt804mYe45/92T0e4qgT0rV0tzfdQtn7Db/8GQdgHWZUCXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GEhBZT5n; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eNEonLuj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 20 Oct 2025 18:02:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760983369;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T8AXfi0e9iMe/OyUyCZogSorpIm3vaf5QD21ZO8cKrU=;
	b=GEhBZT5nM9zEsvT+MFvrZOwwKqUDjC3AztWu0pMrGyHfkNMyoKX12AaTtNOfds9O2AVD/6
	26pvpRWffc7GXBBZqWmr0Ktc9727sXInE0TAgwwDsXI1/vBdnGvK3IjW5PRKXvq+E+NN+y
	g01ojzpQ73jdUjZLP6OfVbARx7Zs2uGZHeOiHTZre3lvJEqOTApsKCvLOeliE+Jaiw5kNI
	agzkMF/hRzMeygTZVPhL/Z+X8+CC3CDv3nVEjC10G+HDm8CENLASvUooOBbRMhubFFchme
	oDh8OR2leRK4beeDZafygPTN4bOOFqGtLtFONSBLc8pmo3zoxMhO8sCZ+kkn+Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760983369;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T8AXfi0e9iMe/OyUyCZogSorpIm3vaf5QD21ZO8cKrU=;
	b=eNEonLuj++XSjuq4Dp4keNs2CwhhhEuqSlEbcXSVk3IZ60kqADxWVGH7U1vdfHBpbzeahI
	olUK/w6N6waEctDQ==
From: "tip-bot2 for Haofeng Li" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] timekeeping: Fix aux clocks sysfs initialization
 loop bound
Cc: Haofeng Li <lihaofeng@kylinos.cn>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <tencent_2376993D9FC06A3616A4F981B3DE1C599607@qq.com>
References: <tencent_2376993D9FC06A3616A4F981B3DE1C599607@qq.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176098336810.2601451.4468612490697834424.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     39a9ed0fb6dac58547afdf9b6cb032d326a3698f
Gitweb:        https://git.kernel.org/tip/39a9ed0fb6dac58547afdf9b6cb032d326a=
3698f
Author:        Haofeng Li <lihaofeng@kylinos.cn>
AuthorDate:    Wed, 15 Oct 2025 14:17:53 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 20 Oct 2025 19:56:12 +02:00

timekeeping: Fix aux clocks sysfs initialization loop bound

The loop in tk_aux_sysfs_init() uses `i <=3D MAX_AUX_CLOCKS` as the
termination condition, which results in 9 iterations (i=3D0 to 8) when
MAX_AUX_CLOCKS is defined as 8. However, the kernel is designed to support
only up to 8 auxiliary clocks.

This off-by-one error causes the creation of a 9th sysfs entry that exceeds
the intended auxiliary clock range.

Fix the loop bound to use `i < MAX_AUX_CLOCKS` to ensure exactly 8
auxiliary clock entries are created, matching the design specification.

Fixes: 7b95663a3d96 ("timekeeping: Provide interface to control auxiliary clo=
cks")
Signed-off-by: Haofeng Li <lihaofeng@kylinos.cn>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://patch.msgid.link/tencent_2376993D9FC06A3616A4F981B3DE1C599607@q=
q.com
---
 kernel/time/timekeeping.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index b6974fc..3a4d3b2 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -3070,7 +3070,7 @@ static int __init tk_aux_sysfs_init(void)
 		return -ENOMEM;
 	}
=20
-	for (int i =3D 0; i <=3D MAX_AUX_CLOCKS; i++) {
+	for (int i =3D 0; i < MAX_AUX_CLOCKS; i++) {
 		char id[2] =3D { [0] =3D '0' + i, };
 		struct kobject *clk =3D kobject_create_and_add(id, auxo);
=20

