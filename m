Return-Path: <linux-tip-commits+bounces-7345-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A38C5D4BB
	for <lists+linux-tip-commits@lfdr.de>; Fri, 14 Nov 2025 14:18:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 778864F3A4A
	for <lists+linux-tip-commits@lfdr.de>; Fri, 14 Nov 2025 13:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D64D619E7D1;
	Fri, 14 Nov 2025 13:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NaJkikZR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+5ZloH4W"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB4A75809;
	Fri, 14 Nov 2025 13:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763125849; cv=none; b=W/40UEO9Y6ZEo5RuNKl6gPmMGHjWa9xCZMz0ryZLxQKgOHgDNpBH9UCSRvOjhGmUmBew6XQMG029qGn7yOgkJbaBKFDs/bXBBjYLoQuw9rugjp1jvLOMpevD4HUA1A3v6HAtu8PnNi9QPHZWKSOvBtTwKBHTieEI8plMNaXHf6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763125849; c=relaxed/simple;
	bh=w11l2hMb45tUpYvPmFv/22v6xRLHSK91+altOu7hgwk=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=Sh59rBDottHl+sGvKZKEwJxBVxztho4pn582PB73fjfhCND5IPZlur7sF+q7w3NPV/ilbj3GjObAofRQ+01O8r++xulKJUOxbA+Lu/TY9a6MUVNAeJunWK10KopkWVxbrRCLuwKmYhKEC/igOMu67wDEbDZrxDS0tjobPG6OiDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NaJkikZR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+5ZloH4W; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 14 Nov 2025 13:10:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763125846;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=8kfEaZ2DoUORi5A2qPV2Pt8gjbVeGEfifpWfk54HxfQ=;
	b=NaJkikZRBqGPm1tCcKrXok2pztTgKOX0yj+lQymhgz6Ax2uhSJ9gzOllxqDllVaX4GTQ2m
	NgD6caB32pQn4Y8fQYEE63jlhq3GdLiHD6btobIun4o+ej/Vo+tFCg0DBCRLOVMbsaFLeR
	PuwvcQug5PRNnCMxB3IYdspcqEuBWhMwgpS4Nnh/7ut97AHOejolBesem6LP6fpcHF530J
	wZaZQZ+TK3ozZ7PELxTs7YZo2eL5gbnaI4aJZY7KNcBjVXOGf1A8XskEvU9lZMNJB6oL0H
	yhSidzxxAVyaKWdOBMCzL3UzvSaTcTD6v2Z00y3968kKLDA0S9ose+6DUcFUsA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763125846;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=8kfEaZ2DoUORi5A2qPV2Pt8gjbVeGEfifpWfk54HxfQ=;
	b=+5ZloH4W1a/03m7yGjIAoBfX+D9rMCPt9gZKJ5h96ASHaL/v1KizecEQ/NhBpyKGMU4ak/
	DUQENjlpzn1xtLAA==
From: "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/urgent] x86/microcode/AMD: Add Zen5 model 0x44, stepping 0x1 minrev
Cc: Andrew Cooper <andrew.cooper3@citrix.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>,  <stable@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176312584528.498.488356338499799994.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     dd14022a7ce96963aa923e35cf4bcc8c32f95840
Gitweb:        https://git.kernel.org/tip/dd14022a7ce96963aa923e35cf4bcc8c32f=
95840
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Fri, 14 Nov 2025 14:01:14 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 14 Nov 2025 14:04:49 +01:00

x86/microcode/AMD: Add Zen5 model 0x44, stepping 0x1 minrev

Add the minimum Entrysign revision for that model+stepping to the list
of minimum revisions.

Fixes: 50cef76d5cb0 ("x86/microcode/AMD: Load only SHA256-checksummed patches=
")
Reported-by: Andrew Cooper <andrew.cooper3@citrix.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Cc: <stable@kernel.org>
Link: https://lore.kernel.org/r/e94dd76b-4911-482f-8500-5c848a3df026@citrix.c=
om
---
 arch/x86/kernel/cpu/microcode/amd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microc=
ode/amd.c
index dc82153..a881bf4 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -224,6 +224,7 @@ static bool need_sha_check(u32 cur_rev)
 	case 0xb1010: return cur_rev <=3D 0xb101046; break;
 	case 0xb2040: return cur_rev <=3D 0xb204031; break;
 	case 0xb4040: return cur_rev <=3D 0xb404031; break;
+	case 0xb4041: return cur_rev <=3D 0xb404101; break;
 	case 0xb6000: return cur_rev <=3D 0xb600031; break;
 	case 0xb6080: return cur_rev <=3D 0xb608031; break;
 	case 0xb7000: return cur_rev <=3D 0xb700031; break;

