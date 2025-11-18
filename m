Return-Path: <linux-tip-commits+bounces-7384-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C549EC6876F
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Nov 2025 10:16:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 02DC62A8F6
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Nov 2025 09:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4B2130505E;
	Tue, 18 Nov 2025 09:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xv5poFwI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ScYRjNrd"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF38A30ACE8;
	Tue, 18 Nov 2025 09:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763457254; cv=none; b=kX4qoWjYEyx9h042fEXRaj4RWjZIN254YdBpS772g8ym0JtuhmK2vlU08cPJ7BBYDzDBVOfvMia4BgbNfwVkZQghIzEd6u8TDt6+Wd4CwOrukb5UPVOpqs9qR00hWgudeU/qfh2Bl20rdWXD66xgxbxhBFNSM0pl4RmoJJ9lYsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763457254; c=relaxed/simple;
	bh=pJBVv9bCu5ShoA8MduryN1grYS2oF/iI3PtNunm4odE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=SJ+Q+Xz6ybjI+DlyowtB5svPCQ5weiYRTNvG2BIWgWqbdwwvJ47s1sOKxucn1o8EUwky2GGroylBrv46wOXjzdfcvt8ZM+UKQj/hECKSzjyhzEmlJyzUL+wq9TlEOnnv0J1m5LMrCD0ye5VlOmZMlcwQP+qKgEvcHhZWy26j2kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xv5poFwI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ScYRjNrd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Nov 2025 09:14:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763457250;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2ezP0pdvrDmOrxCGqW0Wp8zqMYp4sOtkyFJMnTQ7t6s=;
	b=xv5poFwIFE3y8JrKzvIByU0DMrHDlPHxHJSCTtaw+dUVPNr50XaYYQbsZKTTy6UUCh19QE
	/QKIZ/Cloq7UisJqfGvzOQlWJ5N1qzewY1IfJYYHhUJYzkYESdVU8k0TTOQNMS/G/bNe/Q
	zK4Zte76ThFt8DlJapR5YgRi2nDARq83+xzKEeoWu3y0rSepmvfZ8ix2G7bmQOlkwx3MCX
	kA5qA7/pR5jaOqS7CXpxXvnXeTezWy2ywLUnNtkfbkqYnemeiTOTQVMVjpStv4WOR/xcki
	GTgPmUIaszQ14kXqZ9KSGa8Lbct+ir0yx60XkNdrRD0EyrxIYiSDUJcXtVMY3w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763457250;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2ezP0pdvrDmOrxCGqW0Wp8zqMYp4sOtkyFJMnTQ7t6s=;
	b=ScYRjNrd841SJrAUqHPN57ljCbWTcSpa9+NmuSYW3VO56Xh+wTFWY1hDTFBijDHbgb3zxg
	wXFiQ/dhqLoTS9BQ==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Set minimum xxhash version to 0.8
Cc: Michael Kelley <mhklinux@outlook.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <7227c94692a3a51840278744c7af31b4797c6b96.1762990139.git.jpoimboe@kernel.org>
References:
 <7227c94692a3a51840278744c7af31b4797c6b96.1762990139.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176345724939.498.14683474063482790069.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     ee0b48fabadf9b073b24f761ac09da7293eee7b7
Gitweb:        https://git.kernel.org/tip/ee0b48fabadf9b073b24f761ac09da7293e=
ee7b7
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Wed, 12 Nov 2025 15:32:33 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 18 Nov 2025 09:59:25 +01:00

objtool: Set minimum xxhash version to 0.8

XXH3 is only supported starting with xxhash 0.8.  Enforce that.

Fixes: 0d83da43b1e1 ("objtool/klp: Add --checksum option to generate per-func=
tion checksums")
Closes: https://lore.kernel.org/SN6PR02MB41579B83CD295C9FEE40EED6D4FCA@SN6PR0=
2MB4157.namprd02.prod.outlook.com
Reported-by: Michael Kelley <mhklinux@outlook.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Michael Kelley <mhklinux@outlook.com>
Link: https://patch.msgid.link/7227c94692a3a51840278744c7af31b4797c6b96.17629=
90139.git.jpoimboe@kernel.org
---
 tools/objtool/Makefile        | 2 +-
 tools/objtool/builtin-check.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
index 48928c9..021f55b 100644
--- a/tools/objtool/Makefile
+++ b/tools/objtool/Makefile
@@ -12,7 +12,7 @@ ifeq ($(SRCARCH),loongarch)
 endif
=20
 ifeq ($(ARCH_HAS_KLP),y)
-	HAVE_XXHASH =3D $(shell echo "int main() {}" | \
+	HAVE_XXHASH =3D $(shell printf "$(pound)include <xxhash.h>\nXXH3_state_t *s=
tate;int main() {}" | \
 		      $(HOSTCC) -xc - -o /dev/null -lxxhash 2> /dev/null && echo y || echo=
 n)
 	ifeq ($(HAVE_XXHASH),y)
 		BUILD_KLP	 :=3D y
diff --git a/tools/objtool/builtin-check.c b/tools/objtool/builtin-check.c
index 1e1ea83..aab7fa9 100644
--- a/tools/objtool/builtin-check.c
+++ b/tools/objtool/builtin-check.c
@@ -164,7 +164,7 @@ static bool opts_valid(void)
=20
 #ifndef BUILD_KLP
 	if (opts.checksum) {
-		ERROR("--checksum not supported; install xxhash-devel/libxxhash-dev and re=
compile");
+		ERROR("--checksum not supported; install xxhash-devel/libxxhash-dev (versi=
on >=3D 0.8) and recompile");
 		return false;
 	}
 #endif

