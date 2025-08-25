Return-Path: <linux-tip-commits+bounces-6344-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B417B33C91
	for <lists+linux-tip-commits@lfdr.de>; Mon, 25 Aug 2025 12:25:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E32F5189B343
	for <lists+linux-tip-commits@lfdr.de>; Mon, 25 Aug 2025 10:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 738B22D7DF0;
	Mon, 25 Aug 2025 10:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TIa1KREg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kJmynWLR"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6982DF718;
	Mon, 25 Aug 2025 10:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756117475; cv=none; b=qH082L5DLGAQfR7aU7+KrZE8x6Q4T48mz4uDHPeIS/rwAcZDoEaxnnIUeQ/jJ9axQeYqyQoun/YcaI8XV9PFic0+W6x+xbmKLraZjHyl+MZun//Y/v1p5tP3rVRnSgLEyQ7SHUZ5fIi87VMs8GcxY7DXBIEuYrXae0YYkCATr/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756117475; c=relaxed/simple;
	bh=Fz79Feb1GTCYlErMBQCqFUf2qK3hC2kFvCH6ivKOX7Y=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=l7zr143JqxhhhFQGGu39aFaRgA7Gj6/6XvxHXa5iEVvfvw90eeuXXqhyX44GXxwchreGoldDqZypePSGgEpaT0Bm+kFfhA4NpcBvG/C6rvkBFs5f1pM+nLexvcdtE0grbx9nYcgT3oFXQP8MYW3E2FvWiCyeJUXu5+6Sigl1WZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TIa1KREg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kJmynWLR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 25 Aug 2025 10:24:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756117472;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iSDIGlp2qfqjpCS+lbf03/hx8gpVPWOx11F3AjyG0Oo=;
	b=TIa1KREgSncHdmyiptsMnmKwBb173jHM4+IYWMr3HIwDtDawPBnsTIB2Y2Uc73p6w6EYDG
	DAd9aiKX+4zCM0V7lgw/YPCpeI6SZAH6WnPDGYo56NjN7As1pTRujcd06oOtYuuN6TrHJW
	Xyt4qA8Gie4CfJDUJ+9irFtQvT7MD3hsnNCwo9MnGpEWkheessKk5iFQBYT7/8w+vhYWOF
	P0jIcYgMxSDQGOxxS3dTgToH/5aWnlohz4YiKUHj85DeWym+0DwmPcjVvjPHznHKMWVQM7
	Ue/tQ2ySMMqPIFCr/faOgFryQYohl5j7u/uy/cIF6MzWYj2hnY5AVXfBXHAVRg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756117472;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iSDIGlp2qfqjpCS+lbf03/hx8gpVPWOx11F3AjyG0Oo=;
	b=kJmynWLRV+SP0m0rVlx35Ta0TlskzxQp1O2sTUTV6rcOYppz6Kp6goZVRKaD6RrBkhaYMr
	I5CzD7RSF0E7j/AA==
From: "tip-bot2 for Qianfeng Rong" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] uprobes: Remove redundant __GFP_NOWARN
Cc: Qianfeng Rong <rongqianfeng@vivo.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Oleg Nesterov <oleg@redhat.com>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250805025000.346647-1-rongqianfeng@vivo.com>
References: <20250805025000.346647-1-rongqianfeng@vivo.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175611747090.1420.3132265103580716698.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     e173287b5d2119971fc329473a020171836d14c9
Gitweb:        https://git.kernel.org/tip/e173287b5d2119971fc329473a020171836=
d14c9
Author:        Qianfeng Rong <rongqianfeng@vivo.com>
AuthorDate:    Tue, 05 Aug 2025 10:50:00 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 21 Aug 2025 20:09:26 +02:00

uprobes: Remove redundant __GFP_NOWARN

Commit 16f5dfbc851b ("gfp: include __GFP_NOWARN in GFP_NOWAIT")
made GFP_NOWAIT implicitly include __GFP_NOWARN.

Therefore, explicit __GFP_NOWARN combined with GFP_NOWAIT
(e.g., `GFP_NOWAIT | __GFP_NOWARN`) is now redundant. Let's clean
up these redundant flags across subsystems.

No functional changes.

Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Oleg Nesterov <oleg@redhat.com>
Link: https://lore.kernel.org/r/20250805025000.346647-1-rongqianfeng@vivo.com
---
 kernel/events/uprobes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 4a194d7..996a810 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1220,7 +1220,7 @@ build_map_info(struct address_space *mapping, loff_t of=
fset, bool is_register)
 			 * reclaim. This is optimistic, no harm done if it fails.
 			 */
 			prev =3D kmalloc(sizeof(struct map_info),
-					GFP_NOWAIT | __GFP_NOMEMALLOC | __GFP_NOWARN);
+					GFP_NOWAIT | __GFP_NOMEMALLOC);
 			if (prev)
 				prev->next =3D NULL;
 		}

