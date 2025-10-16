Return-Path: <linux-tip-commits+bounces-6892-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 162E3BE29A0
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 12:01:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB26C3B9451
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 09:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D7E1330D44;
	Thu, 16 Oct 2025 09:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IuxhauwK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FtaRmE3I"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DB132E738;
	Thu, 16 Oct 2025 09:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760608384; cv=none; b=IxQ85XQLKoFssZpRHOrvAH99r0MD4uxKmtVE4csErt0dXyVvbUMl3HKq6MdIoznTqv94UtRsIxbLVpNIV7a4mTB/C1qQycjMknF2aSr+V8u6bN9GDOE0THIKyrP0HBHADC+EwvcZDKq8GSCB5XQdjOz7Rix+tvuaYx9fNN6llOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760608384; c=relaxed/simple;
	bh=PSOLE3EdqavoJ+nAf1EFf0kNryRb4EDVkoYfQ/JU73Y=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=R5VwkbMywQcFbaooAsr72afMaXyipSMfmwe4TQm/TZMkcT5vwCJ5CyqbsFxV68WoSJCn1aBoG7Z0BPA9JCE4nI9Ho9+EP7FvlNYm1pqLM5ZctWaZWVitfMmcwNBkKgscawNNT3xhRNlzW+XBl4BsRuqOJQIP9OLIMGH4GaA3UBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IuxhauwK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FtaRmE3I; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 16 Oct 2025 09:52:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760608359;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=9gzhmsILEvFACr3uWaSyWasTEnBdcZaRwuYnMYgmGtA=;
	b=IuxhauwKeH132spiaM0Z78OJGZmadRIuM+FLMukHkh1ZP8CRNG3GdUYyai8YxsuaDF8TfG
	ZEQxZsyRwdCqk/w8QJQyAXzDujv5OfIFjdlnP8pMGe44ZjVaTO+0ib5pbmPSR4BSqAGu69
	n9ZTtkuoHoefN2l8UEjJzE44i7Yq9JjFnsFFCtu37YBxueKQXeOqB7g7USGyO8Ui+CQXiB
	G7IpBNLQVEwPNOairQcyZpP2UTsO7wu6A3FtyzQzNsMi7j1pMDf6Rg3HABE7Zpt3RLXMPF
	bFJ6VoGX9Phv7CsgttXbwYiIVhqQSc/ZSLfNmMowWEu5fBkQcUTSD4vjD1Nkxg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760608359;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=9gzhmsILEvFACr3uWaSyWasTEnBdcZaRwuYnMYgmGtA=;
	b=FtaRmE3IMnFBgOOL6y4Db291WD2cRMQLVwvxDzqGYwhwJDR43wFHJuQk5X7kGepH6lRR53
	ZrlHu0Ly1PAgMABQ==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Rename --Werror to --werror
Cc: Petr Mladek <pmladek@suse.com>, Joe Lawrence <joe.lawrence@redhat.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176060835815.709179.11468876777312896339.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     56754f0f46f6a36ba66e8c1b2878f7a4f1edfe3b
Gitweb:        https://git.kernel.org/tip/56754f0f46f6a36ba66e8c1b2878f7a4f1e=
dfe3b
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Wed, 17 Sep 2025 09:03:42 -07:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Tue, 14 Oct 2025 14:46:48 -07:00

objtool: Rename --Werror to --werror

The objtool --Werror option name is stylistically inconsistent: halfway
between GCC's single-dash capitalized -Werror and objtool's double-dash
--lowercase convention, making it unnecessarily hard to remember.

Make the 'W' lower case (--werror) for consistency with objtool's other
options.

Acked-by: Petr Mladek <pmladek@suse.com>
Tested-by: Joe Lawrence <joe.lawrence@redhat.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 scripts/Makefile.lib          | 2 +-
 scripts/Makefile.vmlinux_o    | 2 +-
 tools/objtool/builtin-check.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index b955602..15fee73 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -191,7 +191,7 @@ objtool-args-$(CONFIG_HAVE_STATIC_CALL_INLINE)		+=3D --st=
atic-call
 objtool-args-$(CONFIG_HAVE_UACCESS_VALIDATION)		+=3D --uaccess
 objtool-args-$(or $(CONFIG_GCOV_KERNEL),$(CONFIG_KCOV))	+=3D --no-unreachable
 objtool-args-$(CONFIG_PREFIX_SYMBOLS)			+=3D --prefix=3D$(CONFIG_FUNCTION_PA=
DDING_BYTES)
-objtool-args-$(CONFIG_OBJTOOL_WERROR)			+=3D --Werror
+objtool-args-$(CONFIG_OBJTOOL_WERROR)			+=3D --werror
=20
 objtool-args =3D $(objtool-args-y)					\
 	$(if $(delay-objtool), --link)					\
diff --git a/scripts/Makefile.vmlinux_o b/scripts/Makefile.vmlinux_o
index 23c8751..20533cc 100644
--- a/scripts/Makefile.vmlinux_o
+++ b/scripts/Makefile.vmlinux_o
@@ -41,7 +41,7 @@ objtool-enabled :=3D $(or $(delay-objtool),$(CONFIG_NOINSTR=
_VALIDATION))
 ifeq ($(delay-objtool),y)
 vmlinux-objtool-args-y					+=3D $(objtool-args-y)
 else
-vmlinux-objtool-args-$(CONFIG_OBJTOOL_WERROR)		+=3D --Werror
+vmlinux-objtool-args-$(CONFIG_OBJTOOL_WERROR)		+=3D --werror
 endif
=20
 vmlinux-objtool-args-$(CONFIG_NOINSTR_VALIDATION)	+=3D --noinstr \
diff --git a/tools/objtool/builtin-check.c b/tools/objtool/builtin-check.c
index fcd4a65..2aa28af 100644
--- a/tools/objtool/builtin-check.c
+++ b/tools/objtool/builtin-check.c
@@ -101,7 +101,7 @@ static const struct option check_options[] =3D {
 	OPT_BOOLEAN(0,   "sec-address", &opts.sec_address, "print section addresses=
 in warnings"),
 	OPT_BOOLEAN(0,   "stats", &opts.stats, "print statistics"),
 	OPT_BOOLEAN('v', "verbose", &opts.verbose, "verbose warnings"),
-	OPT_BOOLEAN(0,   "Werror", &opts.werror, "return error on warnings"),
+	OPT_BOOLEAN(0,   "werror", &opts.werror, "return error on warnings"),
=20
 	OPT_END(),
 };

