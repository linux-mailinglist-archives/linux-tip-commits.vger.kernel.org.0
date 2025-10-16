Return-Path: <linux-tip-commits+bounces-6907-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 23636BE2939
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 11:58:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 93A2D348844
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 09:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EFCE338F5B;
	Thu, 16 Oct 2025 09:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pq9gR8cY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JdAPrI2f"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67AB8335BD7;
	Thu, 16 Oct 2025 09:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760608404; cv=none; b=Zu/XwkW4QKTAUKbwJBgxFLG81r186a65Es1EshJnmZEUVhV8yuijBtLNIaFRnG1Wt8nl95mN6JRqE/KfA3uaiAeXl0f7+MQXz2UnHri4I1fkMloW9kQgwj/HMC+hLmPPkQ5Q1U1K6qod5l+bHK/OmMud+X7qLlZtzE/a33+WsSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760608404; c=relaxed/simple;
	bh=CKC1sY1MWJmSwXmOkrVfkB2ylHA70aGcZd33LrrQRYQ=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=rYUvoH0e3NEf5z8jnrbxoX+bEM/jW1U7HlJTSLiXGGU+PFnOX/AY7iHWe0eA0RQP2sCExiw2miKjls/EBpyPEZlgZcQeebkqecGX2+3nhVWd/xnODg26YGyKjAAATn/uXzrNeT+sYtlXycb+KDmnSME0/708YV5SEhIi7wPMvFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pq9gR8cY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JdAPrI2f; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 16 Oct 2025 09:53:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760608392;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=EAUIC14diCyo3jvNgxJUEzDPFzkjGkHNB/E4PmK4+Vg=;
	b=pq9gR8cYPjGtMWt5pw1sRa+0wKefd3iaENReeZMBpl4Kh+2Wrf6Cgsrd2ZCZAS2hOUlV5I
	z9Z3TUjh9WZakVQW0qe59aDnlIrjBI42hR6z1+rYPj9HEvi+A+xhbj30s83d8JsTCGIY5u
	zfaywJrydbuLyvqjDPEVndjYiysIR89C6v9wMY9E4/tBDy22/7e0GxGzX9KRyYkVwRPe8+
	mOABPpVyDhJLbi7ZtrtAq3+SsTkF6sjiiyvlyuq9aZzjfkiQaLMxqtr5raDRRzY7Ig3JTT
	w6EcuFyiXaR+zsbKqOLjVpX72OHzVbldXhkr2Lt7OU+w3+DLqrjlggi8uTrFGQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760608392;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=EAUIC14diCyo3jvNgxJUEzDPFzkjGkHNB/E4PmK4+Vg=;
	b=JdAPrI2fWyegSeaaqVZZGxPVnubCoUgW8oVgkX93Rb1A6FdH/s5fT+SLfV7zhD1PE8AaPV
	cMQ/sCxa6QEwOvCw==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: objtool/core] kbuild: Remove 'kmod_' prefix from __KBUILD_MODNAME
Cc: Masahiro Yamada <masahiroy@kernel.org>, Petr Mladek <pmladek@suse.com>,
 Joe Lawrence <joe.lawrence@redhat.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176060839079.709179.15078148436703060232.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     6717e8f91db71641cb52855ed14c7900972ed0bc
Gitweb:        https://git.kernel.org/tip/6717e8f91db71641cb52855ed14c7900972=
ed0bc
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Wed, 17 Sep 2025 09:03:16 -07:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Tue, 14 Oct 2025 14:45:22 -07:00

kbuild: Remove 'kmod_' prefix from __KBUILD_MODNAME

In preparation for the objtool klp diff subcommand, remove the arbitrary
'kmod_' prefix from __KBUILD_MODNAME and instead add it explicitly in
the __initcall_id() macro.

This change supports the standardization of "unique" symbol naming by
ensuring the non-unique portion of the name comes before the unique
part.  That will enable objtool to properly correlate symbols across
builds.

Cc: Masahiro Yamada <masahiroy@kernel.org>
Acked-by: Petr Mladek <pmladek@suse.com>
Tested-by: Joe Lawrence <joe.lawrence@redhat.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 include/linux/init.h | 3 ++-
 scripts/Makefile.lib | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/init.h b/include/linux/init.h
index 17c1bc7..4033192 100644
--- a/include/linux/init.h
+++ b/include/linux/init.h
@@ -200,12 +200,13 @@ extern struct module __this_module;
=20
 /* Format: <modname>__<counter>_<line>_<fn> */
 #define __initcall_id(fn)					\
+	__PASTE(kmod_,						\
 	__PASTE(__KBUILD_MODNAME,				\
 	__PASTE(__,						\
 	__PASTE(__COUNTER__,					\
 	__PASTE(_,						\
 	__PASTE(__LINE__,					\
-	__PASTE(_, fn))))))
+	__PASTE(_, fn)))))))
=20
 /* Format: __<prefix>__<iid><id> */
 #define __initcall_name(prefix, __iid, id)			\
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 1d581ba..b955602 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -20,7 +20,7 @@ name-fix-token =3D $(subst $(comma),_,$(subst -,_,$1))
 name-fix =3D $(call stringify,$(call name-fix-token,$1))
 basename_flags =3D -DKBUILD_BASENAME=3D$(call name-fix,$(basetarget))
 modname_flags  =3D -DKBUILD_MODNAME=3D$(call name-fix,$(modname)) \
-		 -D__KBUILD_MODNAME=3Dkmod_$(call name-fix-token,$(modname))
+		 -D__KBUILD_MODNAME=3D$(call name-fix-token,$(modname))
 modfile_flags  =3D -DKBUILD_MODFILE=3D$(call stringify,$(modfile))
=20
 _c_flags       =3D $(filter-out $(CFLAGS_REMOVE_$(target-stem).o), \

