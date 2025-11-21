Return-Path: <linux-tip-commits+bounces-7448-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B9BBC78564
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Nov 2025 11:07:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EECBA4EAC74
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Nov 2025 10:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE3F346778;
	Fri, 21 Nov 2025 09:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mJHY4g+T";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kOL7eoBH"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CFBE345756;
	Fri, 21 Nov 2025 09:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763719081; cv=none; b=YcrFRgm//d6jvH/cxpBGBpWEfpeXfS2mEGOHSa7IhU4q0awBPNSb0yL/Z009KoQ4WDw24sWp5oo3gSIVLmszs/wTtMxXkLlpr74WMDXLoN0eqlNt6D2xQ1xjnNqWTEmsXSectqf6gYfA0MV/mitDlbTPNJ99PiQJXcyrSvEUqWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763719081; c=relaxed/simple;
	bh=BARThad0V8jfuYL11rPcKsYE9DIDqeiGywXDrfDCPAI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=cZ3uYx7i1Gikg3h2ROMsVpAEyQF6fYFunaflAi9L6ZidZmyPInu2jhyE8QYglrr4eFDzJmd+oQ3wSN8waqAHgB0rQWDTq2jVcTjiFQjmKR1gAvRWq46vCmnVmxfEoR2+w/sODfCdl0Qr1RwDtejJa2Rofl6RqNEQj0UdcjIOre0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mJHY4g+T; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kOL7eoBH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 21 Nov 2025 09:57:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763719077;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hdLF41O7c2JzEw7dL8kgpHdYJbPEYMiYYFuJ/CDPF5Q=;
	b=mJHY4g+TjUvbVGAz9xA+XBS7EaY3/5uGqUip21xp+7n7b/mkyp/nmecqy42cD99j2CeVJp
	56PjvdnZYy8glPX/TiQcg3s1ez+8erLj/IMLjWcDpli4pAKQqlfLMg5jiqvNg73ciRjW1A
	/uyHmarHfgoBpxjlWPKufD7c04P2wtAHM35ztVLgy42vj1S7mCU9lcjKHaS5WGqOaWrDlP
	OcK1Q6EivUD+uxtIWtUyydtvL+m4SsJq5HRKKvhxK/z/jL8aGJ0aYvxPlTRzGqLUyuWbZ9
	6cFAlLdvhSdUK36/hl2AhRpCLY6GDDHOFGtVpIeqOzxAmE084UWZHNPpuPkYJg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763719077;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hdLF41O7c2JzEw7dL8kgpHdYJbPEYMiYYFuJ/CDPF5Q=;
	b=kOL7eoBHOs0KE+CSTGugA5wKoOUgKa2wrVMSS/LD/I0hALR5GRKPpHliR+22UFRFLpZMUa
	yF8vVsu3oNynIcAQ==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: objtool/core] objtool: Remove second pass of .cold function correlation
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <bdab245a38000a5407f663a031f39e14c67a43d4.1763671318.git.jpoimboe@kernel.org>
References:
 <bdab245a38000a5407f663a031f39e14c67a43d4.1763671318.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176371907577.498.9350060041272542842.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     106f11d43be53156187270d00c83ddf5ef3f6ac6
Gitweb:        https://git.kernel.org/tip/106f11d43be53156187270d00c83ddf5ef3=
f6ac6
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Thu, 20 Nov 2025 12:52:20 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 21 Nov 2025 10:04:08 +01:00

objtool: Remove second pass of .cold function correlation

The .cold function parent/child correlation logic has two passes: one in
read_symbols() and one in add_jump_destinations().

The second pass was added with commit cd77849a69cf ("objtool: Fix GCC 8
cold subfunction detection for aliased functions") to ensure that if the
parent symbol had aliases then the canonical symbol was chosen as the
parent.

That solution was rather clunky, not to mention incomplete due to the
existence of alternatives and switch tables.  Now that we have
sym->alias, the canonical alias fix can be done much simpler in the
first pass, making the second pass obsolete.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/bdab245a38000a5407f663a031f39e14c67a43d4.17636=
71318.git.jpoimboe@kernel.org
---
 tools/objtool/check.c | 23 +----------------------
 tools/objtool/elf.c   |  3 ++-
 2 files changed, 3 insertions(+), 23 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 6a4a29f..1a20ff8 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1623,34 +1623,13 @@ static int add_jump_destinations(struct objtool_file =
*file)
 			continue;
 		}
=20
-		if (!insn->sym || insn->sym =3D=3D dest_insn->sym)
+		if (!insn->sym || insn->sym->pfunc =3D=3D dest_sym->pfunc)
 			goto set_jump_dest;
=20
 		/*
 		 * Internal cross-function jump.
 		 */
=20
-		/*
-		 * For GCC 8+, create parent/child links for any cold
-		 * subfunctions.  This is _mostly_ redundant with a
-		 * similar initialization in read_symbols().
-		 *
-		 * If a function has aliases, we want the *first* such
-		 * function in the symbol table to be the subfunction's
-		 * parent.  In that case we overwrite the
-		 * initialization done in read_symbols().
-		 *
-		 * However this code can't completely replace the
-		 * read_symbols() code because this doesn't detect the
-		 * case where the parent function's only reference to a
-		 * subfunction is through a jump table.
-		 */
-		if (func && dest_sym->cold) {
-			func->cfunc =3D dest_sym;
-			dest_sym->pfunc =3D func;
-			goto set_jump_dest;
-		}
-
 		if (is_first_func_insn(file, dest_insn)) {
 			/* Internal sibling call */
 			if (add_call_dest(file, insn, dest_sym, true))
diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 7e2c0ae..6a8ed9c 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -658,8 +658,9 @@ static int read_symbols(struct elf *elf)
 				return -1;
 			}
=20
-			sym->pfunc =3D pfunc;
+			sym->pfunc =3D pfunc->alias;
 			pfunc->cfunc =3D sym;
+			pfunc->alias->cfunc =3D sym;
=20
 			/*
 			 * Unfortunately, -fnoreorder-functions puts the child

