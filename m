Return-Path: <linux-tip-commits+bounces-1258-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F6E18C74D5
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 May 2024 12:51:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCE2E28580A
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 May 2024 10:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23CE5145339;
	Thu, 16 May 2024 10:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="knM0xaSy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ks2B2d6y"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2D0143866;
	Thu, 16 May 2024 10:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715856709; cv=none; b=LFUvIhfYX9R6EFH59ggkPdQiUAPNz4DjBuLgigTQP5eZvJgj9fzGZ8tEamyQHU6Kb/E0oEx1qb9NgOKSHSRG/MqXeDuvoArskIXO0h1yF7187G59GMb55dW5YorWC+WYEVy247DqPZFhkekhDOh2eZ8xCLT2Ba9+jFGNvmFkXBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715856709; c=relaxed/simple;
	bh=ddwSZ0rfxaLzTSLiACUTmn4XATY/arbreMqI2FnP5IA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=EIogGqYt7mV5it5uLG8jgp3fVvWNx7vgEmwcrYx2V+qV8EuPKItSq7GMBLzpOwfFHTu+FBQykD30Uyh2mQBMFx0mMuqHcT0DvbtqZoVq8vH565xxSdixdGD+uTPf4b3oSa08qKjNdCr8a7Hs2J89BsP5aGbEa9wlDxfP5BfwIw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=knM0xaSy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ks2B2d6y; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 16 May 2024 10:51:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1715856699;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EYwh9LNFmp9S2lIWZ26ZRPJGUQ8EBuLmGBdMkkajOXo=;
	b=knM0xaSyoxFmMpyZ6i8rDG/mv/oe70gcmvqY37vc5bJADDtNcur7wR55O6Q9LQbfTf0jAE
	W3xSUrQMMUf+JxJT0bDpdnRz4Vh7C5T+JSQuNND8I/ZldfDunIlib65WI7mn+1+ZpfLDJh
	EQ45QNKEhFjgE9gcidM8vZHaJXki3ZCI1U0cFn6zMsldIDW5QTRkFS5HOpQTVsI8a7UIrd
	QipIkW7E3rEMFNV71WjBvSup6JaQplAZ0LZ6uiRS12XXiQ0uvlkNHOixrFXE5ovO7urxv/
	Atnlm2a8FN3+vcDvMiwTdrtSyn31A36sY1lK7KErZvtcMH/zkwmJD0USIPT7og==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715856699;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EYwh9LNFmp9S2lIWZ26ZRPJGUQ8EBuLmGBdMkkajOXo=;
	b=ks2B2d6yKXzp4k3hLXpECK0WufAQZsqEmwo7C5j2+c5938dfKoIfV5b95r9wUEmw9GGAPX
	LJAIt/ExcpHTO4Ag==
From: "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/boot: Add a fallthrough annotation
Cc: Borislav Petkov <bp@suse.de>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Ingo Molnar <mingo@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240516102240.16270-1-bp@kernel.org>
References: <20240516102240.16270-1-bp@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171585669878.10875.8116182217321169904.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     dd0716c2b87792ebea30864e7ad1df461d4c1525
Gitweb:        https://git.kernel.org/tip/dd0716c2b87792ebea30864e7ad1df461d4=
c1525
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Thu, 16 May 2024 12:22:40 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 16 May 2024 12:46:36 +02:00

x86/boot: Add a fallthrough annotation

Add implicit fallthrough checking to the decompressor code and fix this
warning:

  arch/x86/boot/printf.c: In function =E2=80=98vsprintf=E2=80=99:
  arch/x86/boot/printf.c:248:10: warning: this statement may fall through [-W=
implicit-fallthrough=3D]
    248 |    flags |=3D SMALL;
        |          ^
  arch/x86/boot/printf.c:249:3: note: here
    249 |   case 'X':
        |   ^~~~

This is a patch from three years ago which I found in my trees, thus the
SUSE authorship still.

Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20240516102240.16270-1-bp@kernel.org
---
 arch/x86/boot/Makefile | 1 +
 arch/x86/boot/printf.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/x86/boot/Makefile b/arch/x86/boot/Makefile
index 3cece19..343aef6 100644
--- a/arch/x86/boot/Makefile
+++ b/arch/x86/boot/Makefile
@@ -69,6 +69,7 @@ KBUILD_CFLAGS	:=3D $(REALMODE_CFLAGS) -D_SETUP
 KBUILD_AFLAGS	:=3D $(KBUILD_CFLAGS) -D__ASSEMBLY__
 KBUILD_CFLAGS	+=3D $(call cc-option,-fmacro-prefix-map=3D$(srctree)/=3D)
 KBUILD_CFLAGS	+=3D -fno-asynchronous-unwind-tables
+KBUILD_CFLAGS	+=3D $(CONFIG_CC_IMPLICIT_FALLTHROUGH)
 GCOV_PROFILE :=3D n
 UBSAN_SANITIZE :=3D n
=20
diff --git a/arch/x86/boot/printf.c b/arch/x86/boot/printf.c
index 1237bee..c0ec1dc 100644
--- a/arch/x86/boot/printf.c
+++ b/arch/x86/boot/printf.c
@@ -246,6 +246,7 @@ int vsprintf(char *buf, const char *fmt, va_list args)
=20
 		case 'x':
 			flags |=3D SMALL;
+			fallthrough;
 		case 'X':
 			base =3D 16;
 			break;

