Return-Path: <linux-tip-commits+bounces-7098-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EE1AC1A83A
	for <lists+linux-tip-commits@lfdr.de>; Wed, 29 Oct 2025 14:07:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C6F345688A1
	for <lists+linux-tip-commits@lfdr.de>; Wed, 29 Oct 2025 12:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B95C93596F8;
	Wed, 29 Oct 2025 12:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CHDIzTnr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="otwHCUiJ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5773596E6;
	Wed, 29 Oct 2025 12:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761741596; cv=none; b=BRnkBf6cQzzqA0kFxTOeOWQB2sqX1+kgdh+BIP7KZhsEvIvUDU3WS5rTeRyQaiAqIZqqqnyD2G4LKx9N8v0RCAbi2qn1KIAGVKKbHRbC0t71C9pnAAcyNDh6cubO/qnNydPZQu6At6+pLReveZvECT/8XpI5PUCQMGUGyNYnKWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761741596; c=relaxed/simple;
	bh=J4/4fiNX5+it+nt8aJqkW32pNkN+oppAQYbJWH38Ig0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ovcKQml/VjyBhI1qhY6OXZSWf3Tx+ck5jkmEdWZM/bino/gjeVOSHiCY0iSPp2ppgxNdR98ZBmUjnzBt72GLvUJfAYARzMbTZc6mnDAgjyFqrEYX8cK7aa6zYl7zqWl6a8Dg24Wik01p4npxooNzSosl0kUi0hu3BLrXJhzBbtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CHDIzTnr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=otwHCUiJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 29 Oct 2025 12:39:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761741593;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G8+yYjj7yuRmLDm8RL5fJnPwS6OLROU8x8efpD1X+IE=;
	b=CHDIzTnrWEUPOxvdcxaYUehgiZu+ipsTnwk4Ea9cgkKSV6DWirRurb/PxT0a0t0VSy3uqj
	EA7ilj4Xvr/u2vNyZhqoej9nHLi+Gq6ptikODz6SSDJAIyh5HY5sUNClwk9ARM6fa86Rmz
	II74VRPxzT7NG5nP3nyFOXqXKowqJMUZza5tqB4k5NI7EzySly79OzEsovz/Lngq+TpahP
	ftCUIXurLK2mc1/3X7pZlg7hGmJRoF9og3JO06VhlqwtE2Q0pdQGsiXzXRfTgzk5q5HzmO
	Lb9IzyNCHGJoG/qXbHgaJ+XX8pUB59BQWcOl3PFptg1dsJ32XzVGUKS2Pmk6bw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761741593;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G8+yYjj7yuRmLDm8RL5fJnPwS6OLROU8x8efpD1X+IE=;
	b=otwHCUiJhG6RpmFQtNrHRkCOYEJRB7r0UQlThze/EsrebXQcKHK8s7vYCisyq9NkYO/W0O
	Gf6GTwlaSvLvQKCw==
From: "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/CPU/AMD: Extend Zen6 model range
Cc: "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251029123056.19987-1-bp@kernel.org>
References: <20251029123056.19987-1-bp@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176174159143.2601451.12751489956748385782.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     94831a4857b6ffd387b52bbdc6bc444dd3658ca0
Gitweb:        https://git.kernel.org/tip/94831a4857b6ffd387b52bbdc6bc444dd36=
58ca0
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Wed, 29 Oct 2025 12:34:31 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 29 Oct 2025 13:34:27 +01:00

x86/CPU/AMD: Extend Zen6 model range

Add some more Zen6 models.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://patch.msgid.link/20251029123056.19987-1-bp@kernel.org
---
 arch/x86/kernel/cpu/amd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index bc29be6..8e36964 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -516,7 +516,7 @@ static void bsp_init_amd(struct cpuinfo_x86 *c)
 			setup_force_cpu_cap(X86_FEATURE_ZEN5);
 			break;
 		case 0x50 ... 0x5f:
-		case 0x90 ... 0xaf:
+		case 0x80 ... 0xaf:
 		case 0xc0 ... 0xcf:
 			setup_force_cpu_cap(X86_FEATURE_ZEN6);
 			break;

