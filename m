Return-Path: <linux-tip-commits+bounces-6983-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F17EFBFC33C
	for <lists+linux-tip-commits@lfdr.de>; Wed, 22 Oct 2025 15:37:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3FF262342B
	for <lists+linux-tip-commits@lfdr.de>; Wed, 22 Oct 2025 13:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 778B5346E45;
	Wed, 22 Oct 2025 13:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bO7usbTc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zD3u2out"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFD4346E40;
	Wed, 22 Oct 2025 13:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761139741; cv=none; b=GHnFEqNxtzeHnlqzT+2LnF0vTBjJ4h5Dpbe54FviTEjhdDPcP3bSMy1o/6fb4Eackd/lC6OUE43UZWO4PYUrs3uqw7kvIfC+VbxMJMPKRCJ4K61mJhb3/NlfLTODToPwr8YTv8ZwqT9DR7tbAhrvHy4zAexL5eOdAcMzmY+Ohok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761139741; c=relaxed/simple;
	bh=9s6GppBZJ9Lqv+qFpBX/EN15DVQCtnFtjFGeL4KRi6o=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=PKx6/SxI+L1XE0dev+8w8/JfZCh2o81vvtnt0OJEGescx14BQdmWNe9AHKNMETgjZKQqkgneQ4yOwgkt5r5l0NmGkKCfd3ToToAXVcztXqp2zbtEHELTEZFVanegmg8uXTFubce21b/n6F3EhFCp3C6ayq5uagPU++IhETNFHGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bO7usbTc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zD3u2out; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 22 Oct 2025 13:28:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761139738;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bcobHMeCH83PQx+kmH3PajT/fhLxG+2BrCH7Odp6uXE=;
	b=bO7usbTcgvhnX9hsQsOlXtuGrim9j6W15laiG4LoaH/1EWNOGNLeOzRK46Hx/HOf21GUpC
	ef1yKqTUO3sWwDZy9piUqnRZzEYv+ycO6gZI6TY+i8AF0g9spZCYoYgTzvYDtEG3/nIN5n
	4WCIJCkptJDouGouP3oyw3GSsa8D3XUYw58A6064UMUhG+3xN82FgzTJpTh7P/OGAK79e5
	8ltWNYzaDFf5VTMviiBufEOTsL1JuvUY/uCAewszPXd8y2QzexZhTAVBMiB9Gh3XaBumAV
	27GKWJwk+XQu59yXeDXrrnNOVNA40OTAwJqAw+2N9JtwZrljg9m6dxJ63d0dfw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761139738;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bcobHMeCH83PQx+kmH3PajT/fhLxG+2BrCH7Odp6uXE=;
	b=zD3u2out5IhGNd5aD+urJDqI1ItspwaaDWJEd7r5jmTWo/EO7Qoo1NN8CgY3ECnUmwd6yD
	OyywKpl5O4xs3SBg==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] module: Fix device table module aliases
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>, Mark Brown <broonie@kernel.org>,
 Cosmin Tanislav <demonsingur@gmail.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 "Chen-Yu Tsai" <wenst@chromium.org>, Anders Roxell <anders.roxell@linaro.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To:
 <e52ee3edf32874da645a9e037a7d77c69893a22a.1760982784.git.jpoimboe@kernel.org>
References:
 <e52ee3edf32874da645a9e037a7d77c69893a22a.1760982784.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176113973663.2601451.416165192460763876.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     9025688bf6d427e553aca911308cd92e92634f51
Gitweb:        https://git.kernel.org/tip/9025688bf6d427e553aca911308cd92e926=
34f51
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Mon, 20 Oct 2025 10:53:40 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 22 Oct 2025 15:21:55 +02:00

module: Fix device table module aliases

Commit 6717e8f91db7 ("kbuild: Remove 'kmod_' prefix from
__KBUILD_MODNAME") inadvertently broke module alias generation for
modules which rely on MODULE_DEVICE_TABLE().

It removed the "kmod_" prefix from __KBUILD_MODNAME, which caused
MODULE_DEVICE_TABLE() to generate a symbol name which no longer matched
the format expected by handle_moddevtable() in scripts/mod/file2alias.c.

As a result, modpost failed to find the device tables, leading to
missing module aliases.

Fix this by explicitly adding the "kmod_" string within the
MODULE_DEVICE_TABLE() macro itself, restoring the symbol name to the
format expected by file2alias.c.

Fixes: 6717e8f91db7 ("kbuild: Remove 'kmod_' prefix from __KBUILD_MODNAME")
Reported-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reported-by: Mark Brown <broonie@kernel.org>
Reported-by: Cosmin Tanislav <demonsingur@gmail.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Cosmin Tanislav <demonsingur@gmail.com>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Tested-by: Mark Brown <broonie@kernel.org>
Tested-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Tested-by: Chen-Yu Tsai <wenst@chromium.org>
Tested-by: Anders Roxell <anders.roxell@linaro.org>
Link: https://patch.msgid.link/e52ee3edf32874da645a9e037a7d77c69893a22a.17609=
82784.git.jpoimboe@kernel.org
---
 include/linux/module.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index e135cc7..d80c3ea 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -251,10 +251,11 @@ struct module_kobject *lookup_or_create_module_kobject(=
const char *name);
  */
 #define __mod_device_table(type, name)	\
 	__PASTE(__mod_device_table__,	\
+	__PASTE(kmod_,			\
 	__PASTE(__KBUILD_MODNAME,	\
 	__PASTE(__,			\
 	__PASTE(type,			\
-	__PASTE(__, name)))))
+	__PASTE(__, name))))))
=20
 /* Creates an alias so file2alias.c can find device table. */
 #define MODULE_DEVICE_TABLE(type, name)					\

