Return-Path: <linux-tip-commits+bounces-2506-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D36E09A2E41
	for <lists+linux-tip-commits@lfdr.de>; Thu, 17 Oct 2024 22:11:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 108871C2188B
	for <lists+linux-tip-commits@lfdr.de>; Thu, 17 Oct 2024 20:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D41227397;
	Thu, 17 Oct 2024 20:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PuXhn6Ir";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="L6bOSBXm"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F51227BAF;
	Thu, 17 Oct 2024 20:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729195859; cv=none; b=j84XGPkHod8NN/NSbjBLDLhT83BJ8v4CxigIRIn8AU3EPD4TiAHwFNDfkghk7m+uUSISdTUZvz70nR2q3JEmZbCqfg3xuThbWpbrLTir26+50oDTJwLOOS5RL3nngbVuqMPb66u5k7eDfdtIIekUgW+dIJc6z1KDR3GEnpQN9oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729195859; c=relaxed/simple;
	bh=GVU/+HK9BfoKcjfNivf+ADxXBLa2jK7MzFI62m3MBdA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=og0PAJPcsrIMAdyqAEiyMvUGT8F0wWM2OHwQZ+qX9ijJmQHOQajH3a+/LEfTHvKPB8XCCUvbqz/MDbP1O3o9THWnsv4E+UgA50FFc0WiUVlz1wyiR/miwCy/RnXDyngKn/mw2PVwq9PXnGFE+8y4Iem9blMtS3oJO4F5MGw8u6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PuXhn6Ir; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=L6bOSBXm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 17 Oct 2024 20:10:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729195852;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/HC7Brpj90paTkeg5zJK08IdBU7wxcSyUrABFfyhjjU=;
	b=PuXhn6IrPhV0p9IClANJUw/wasAL+i7CO6I2tkuxyLw+/qR8fOkoYhYyXh16wEw6Tlx6AQ
	az0V2tm7KzxpG6XZwRU7U4eXuQMsXbGhZulXpDKqCs4jpy1KEtT2pThHpfB9E6AjFjjb9M
	4OWhGzqFohFI+lbHQfkRWtg6X4tgosdPAr8GLjpUY6tDwxmES9z1EwDrJU8ifyK5B8ULxp
	F5PKgO2abSV3/PHrqjjXUzyZp7r+Uvkl+XyxO5Rbt06sJmD0hEVkpksC+5P++fAxJWt3iz
	f4WSFamyawkwzBjeCkAq+wJg6khHWTcCB16hgXptBYBkVqNfuYHPo3pEykWeTA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729195852;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/HC7Brpj90paTkeg5zJK08IdBU7wxcSyUrABFfyhjjU=;
	b=L6bOSBXmK6gs03oTOUtdE7dU4wBw+YJpDV3YIzJapcgKmJF2XvabMH+70uc6ALvOcN9ec0
	CsUADnoVLEdftVCw==
From: "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] futex: Use atomic64_inc_return() in
 get_inode_sequence_number()
Cc: Uros Bizjak <ubizjak@gmail.com>, Thomas Gleixner <tglx@linutronix.de>,
 andrealmeid@igalia.com, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241010071023.21913-1-ubizjak@gmail.com>
References: <20241010071023.21913-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172919585166.1442.17461368757454570969.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     19298f48694987fac843261c84e24834c255b451
Gitweb:        https://git.kernel.org/tip/19298f48694987fac843261c84e24834c25=
5b451
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Thu, 10 Oct 2024 09:10:04 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 17 Oct 2024 22:02:27 +02:00

futex: Use atomic64_inc_return() in get_inode_sequence_number()

Use atomic64_inc_return(&ref) instead of atomic64_add_return(1, &ref)
to use optimized implementation and ease register pressure around
the primitive for targets that implement optimized variant.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
Link: https://lore.kernel.org/all/20241010071023.21913-1-ubizjak@gmail.com

---
 kernel/futex/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index 136768a..3146730 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -181,7 +181,7 @@ static u64 get_inode_sequence_number(struct inode *inode)
 		return old;
=20
 	for (;;) {
-		u64 new =3D atomic64_add_return(1, &i_seq);
+		u64 new =3D atomic64_inc_return(&i_seq);
 		if (WARN_ON_ONCE(!new))
 			continue;
=20

