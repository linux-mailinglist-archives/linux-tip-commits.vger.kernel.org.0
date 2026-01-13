Return-Path: <linux-tip-commits+bounces-7905-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 05764D1828C
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Jan 2026 11:48:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E51CC300A869
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Jan 2026 10:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C150534AAF0;
	Tue, 13 Jan 2026 10:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YAczxMym";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JHc6O1IC"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B756B363C64;
	Tue, 13 Jan 2026 10:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768301025; cv=none; b=A6WSkYheivW3kpaDGUiYwdksYZSH+G9bG88wFV8/bCPO4qKfdHXhlmzFgI5EP4KmSybTrPxhp0YiDUT0M66UhRpd3wVBazvbTSFoNqlAQuLzK8xjDS0cIYQR/6oJOFUSFpP5+TuMUl0uLZW3NuBmJALbL+epkVUgHnvnyh7QxQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768301025; c=relaxed/simple;
	bh=p8DToW/j40qHqCYSCJZGUX0UDyzUr/mtfHI9h26oIDc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=FXggDd5uUmFtoCambEkkyzesG/LbeQYy7ID/z2ZHanEUkVZmzVDzCjzWbcKWYIl36aBHJAS41E/JoXbLgA0oMZ+1T95FDmvNfr6M0PTqE41BX9X1b9TFLIgSHGV7xl7VM1YhZeF2v09/xGJD8QRxagEO8jiCiVN/VRGODZ2Rps4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YAczxMym; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JHc6O1IC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 13 Jan 2026 10:43:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768301016;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c1waDbXoXZpqIs6R5QLH8pkfKCrt3HIvF496NIta+vA=;
	b=YAczxMymfSsC5kwPXne0Xz6jb7Kq80QH0Hh5bhU2MbfzLnzq2Pt8XKLKycegp9g/JghnQL
	rRnTsu0Q8EmPZnGxkwIt2+JcyzOAI4NCcBuVY1R8WvVM9wQRrNwBqmS/SRqbv6U5sepYbB
	mMgL0tkPoFLcBYkQvuN4ofhgWcO6/4gWvcNbHb7jypB4zeInhLGRX4pJPMVo9ICGfNV7x8
	Wj5KUU1krso3imExBK9d/OveBjoyxVGFzX1qnKiZuY24RRWbwE3Jdzv4Daz4mK6jhyTAtJ
	kEFixqEv+Swh2a8P8eAJpmZomCET1zjlgRFWpydasCthAF5jzEYH536lyOWK4w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768301016;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c1waDbXoXZpqIs6R5QLH8pkfKCrt3HIvF496NIta+vA=;
	b=JHc6O1ICw3tK9JY5uNL9e+8urIJy4jCssk7Vphcceiy5FYAIkHWm33iVVdmRKTWeZ+7bVZ
	h9IYNQ5zwWM4XVAQ==
From: "tip-bot2 for Mikulas Patocka" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: objtool/urgent] objtool: fix compilation failure with the x32 toolchain
Cc: Mikulas Patocka <mpatocka@redhat.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <a1158c99-fe0e-a218-4b5b-ffac212489f6@redhat.com>
References: <a1158c99-fe0e-a218-4b5b-ffac212489f6@redhat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176830101489.510.5737350223393412723.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/urgent branch of tip:

Commit-ID:     26bea10450afe5ad4dd0e0bbb797c44e1df110fe
Gitweb:        https://git.kernel.org/tip/26bea10450afe5ad4dd0e0bbb797c44e1df=
110fe
Author:        Mikulas Patocka <mpatocka@redhat.com>
AuthorDate:    Tue, 06 Jan 2026 12:13:15 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 13 Jan 2026 11:37:50 +01:00

objtool: fix compilation failure with the x32 toolchain

When using the x32 toolchain, compilation fails because the printf
specifier "%lx" (long), doesn't match the type of the "checksum" variable
(long long). Fix this by changing the printf specifier to "%llx" and
casting "checksum" to unsigned long long.

Fixes: a3493b33384a ("objtool/klp: Add --debug-checksum=3D<funcs> to show per=
-instruction checksums")

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/a1158c99-fe0e-a218-4b5b-ffac212489f6@redhat.com
---
 tools/objtool/include/objtool/warn.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/objtool/include/objtool/warn.h b/tools/objtool/include/obj=
tool/warn.h
index 25ff794..2b27b54 100644
--- a/tools/objtool/include/objtool/warn.h
+++ b/tools/objtool/include/objtool/warn.h
@@ -152,8 +152,8 @@ static inline void unindent(int *unused) { indent--; }
 	if (unlikely(insn->sym && insn->sym->pfunc &&			\
 		     insn->sym->pfunc->debug_checksum)) {		\
 		char *insn_off =3D offstr(insn->sec, insn->offset);	\
-		__dbg("checksum: %s %s %016lx",				\
-		      func->name, insn_off, checksum);			\
+		__dbg("checksum: %s %s %016llx",			\
+		      func->name, insn_off, (unsigned long long)checksum);\
 		free(insn_off);						\
 	}								\
 })

