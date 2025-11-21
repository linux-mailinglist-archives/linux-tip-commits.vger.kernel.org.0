Return-Path: <linux-tip-commits+bounces-7453-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 274C8C784B6
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Nov 2025 11:03:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id DABD42D4E1
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Nov 2025 10:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF77F347BD2;
	Fri, 21 Nov 2025 09:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NTEi+gGa";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ct6k70md"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E3C3451CC;
	Fri, 21 Nov 2025 09:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763719085; cv=none; b=Ic4x2pIKi0ckipUoRz/Zcc71pxfQ6D7lZakwvUCFBeRv6LzBckfUtRfwe3HDcM5ZxzkrpcmbhJI4JBeIogZW/peCF69K6iJwEaja587KEbosc8qIBU8NhyBWTSSKatSCpY60XbR0DNQZkI/HnC6nUkAEVfAJaVi09SyvYs1ENTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763719085; c=relaxed/simple;
	bh=i2ZUUnjaRckBXLrRhlqwnKzxj9nTBl4z5UkR0wx9oAc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=egkhNeacIBHqvYUMROGdw/IAZAJe9Crc3ZShqESobnHYM1em5McLTtv4VjZrxwLgLq1beXKRLsd9e4v2yaiMSCmvvwMAXa5/5fEFosiUDYFGwvGD1iu/nzkl31TJZNjR2du0hawFpuHU27tLgSlIfBn/ogXpNdNa79nFnFRVerQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NTEi+gGa; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ct6k70md; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 21 Nov 2025 09:58:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763719081;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sI+Mgx4OKAvVVYa/C9/fHU4D96+HvXYFpjb8DjB8WYI=;
	b=NTEi+gGa/MsAswZA8wExdEI/WzHL6w1E0IaqayMRI0ko8WWo814BOYWAMeeb31bSpx0Bok
	oOnr+GjXCZEUEC+AnV52Q+AyYppifvzbKPYLF6nGwNHPJOQ7IRbBeuK7xgjowKCkDMwYo3
	jC+omR4rP8CwTtzSblSBd1WliIUS2utz8ki94u49ohDHu/O9LUcuC4VQJTl/gz4jo8KZQf
	lZhjHfZ+FkGtBnWtUOdRn417BE7BBQ+91UBMxsRxFaB2mxOArhcaBdr6oGeSundKCwTQ1h
	B/Hw/gCpnRHoyqIfjxeG64Ud47RORr3XLMaEjhS8v9SnW8zluYitEacgOnv2IA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763719081;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sI+Mgx4OKAvVVYa/C9/fHU4D96+HvXYFpjb8DjB8WYI=;
	b=Ct6k70mdeQ5oc04z3zD72V69lyQ7OfoSIUn8Qu8R88NdEc2S7B1KZBwxNi6C/2ngX9A8sQ
	2AWx7OWxbJZlBdAQ==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Support Clang AUTOFDO .cold functions
Cc: Rong Xu <xur@google.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <20a67326f04b2a361c031b56d58e8a803b3c5893.1763671318.git.jpoimboe@kernel.org>
References:
 <20a67326f04b2a361c031b56d58e8a803b3c5893.1763671318.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176371908079.498.4706819198639272769.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     024020e2b6adb4e568fb80f624b5e20d8943f107
Gitweb:        https://git.kernel.org/tip/024020e2b6adb4e568fb80f624b5e20d894=
3f107
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Thu, 20 Nov 2025 12:52:15 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 21 Nov 2025 10:04:07 +01:00

objtool: Support Clang AUTOFDO .cold functions

AutoFDO enables -fsplit-machine-functions which can move the cold parts
of a function to a <func>.cold symbol in a .text.split.<func> section.

Unlike GCC, the Clang <func>.cold symbols are not marked STT_FUNC.  This
confuses objtool in several ways, resulting in warnings like the
following:

  vmlinux.o: warning: objtool: apply_retpolines.cold+0xfc: unsupported instru=
ction in callable function
  vmlinux.o: warning: objtool: machine_check_poll.cold+0x2e: unsupported inst=
ruction in callable function
  vmlinux.o: warning: objtool: free_deferred_objects.cold+0x1f: relocation to=
 !ENDBR: free_deferred_objects.cold+0x26
  vmlinux.o: warning: objtool: rpm_idle.cold+0xe0: relocation to !ENDBR: rpm_=
idle.cold+0xe7
  vmlinux.o: warning: objtool: tcp_rcv_state_process.cold+0x1c: relocation to=
 !ENDBR: tcp_rcv_state_process.cold+0x23

Fix it by marking the .cold symbols as STT_FUNC.

Fixes: 2fd65f7afd5a ("AutoFDO: Enable machine function split optimization for=
 AutoFDO")
Closes: https://lore.kernel.org/20251103215244.2080638-2-xur@google.com
Reported-by: Rong Xu <xur@google.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: xur@google.com
Tested-by: xur@google.com
Link: https://patch.msgid.link/20a67326f04b2a361c031b56d58e8a803b3c5893.17636=
71318.git.jpoimboe@kernel.org
---
 tools/objtool/elf.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 3f20b25..7895f65 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -502,8 +502,16 @@ static int elf_add_symbol(struct elf *elf, struct symbol=
 *sym)
 	if (strstarts(sym->name, ".klp.sym"))
 		sym->klp =3D 1;
=20
-	if (!sym->klp && is_func_sym(sym) && strstr(sym->name, ".cold"))
+	if (!sym->klp && !is_sec_sym(sym) && strstr(sym->name, ".cold")) {
 		sym->cold =3D 1;
+
+		/*
+		 * Clang doesn't mark cold subfunctions as STT_FUNC, which
+		 * breaks several objtool assumptions.  Fake it.
+		 */
+		sym->type =3D STT_FUNC;
+	}
+
 	sym->pfunc =3D sym->cfunc =3D sym;
=20
 	sym->demangled_name =3D demangle_name(sym);

