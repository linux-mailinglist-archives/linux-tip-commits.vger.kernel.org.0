Return-Path: <linux-tip-commits+bounces-7141-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F566C286EC
	for <lists+linux-tip-commits@lfdr.de>; Sat, 01 Nov 2025 20:49:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5EFCE4EF0BC
	for <lists+linux-tip-commits@lfdr.de>; Sat,  1 Nov 2025 19:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0480303C81;
	Sat,  1 Nov 2025 19:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0oQWV1b/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jgJiRH1Q"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B0F305063;
	Sat,  1 Nov 2025 19:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762026470; cv=none; b=H3oRkNSCaJhjCWXqFWijUOkgcxyFUUsUsm/OZj3PDJwERniOcjYnmqhBbZMuiNTPAYcEDK7YeTy6IK9FwlfSAxVXDhN/91w64WCLrslWymjPsn0c/9jXS5Va+jPBB07AK6oBiK6fgcOAtVzSu/TGgJZkW/nTnbRx3rZQ444FQZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762026470; c=relaxed/simple;
	bh=tseP+Gcoh4YRMg9BO58eQGxKActL3sZEJqa/f1doAHU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=i1rWT0WeiIlSmKNcks1cRoTYppgIGWe8NKF3woGU/8JMmnYzPdHCzTb7bCbqSpe8mMXDakDDjX80Vo001fuOH8fd9lSDYkQd4UpxkG7IlwxV4ObypfKZlgMf3FS8xwyThYSDedvaphCMtBy/P+vxFmdCuJC4rKr534nJ/desJOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0oQWV1b/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jgJiRH1Q; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 01 Nov 2025 19:47:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762026466;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+un/zSMPImWK/I4voSXjufVjQC4iEle5L/X6FengRLw=;
	b=0oQWV1b/03cyEaqcPAoKCV4pyENGuycVc/fMHOE01g6oonNtkkvNCuyjQLEYg/PMgVwq+Z
	zHh3Jp3845UVMWF9Zf8BuzUBMwy0C9aOtmX4o7IFUVFvnen70kZxiE9RXxvylc0JPH6tHg
	VxBSaIP9sqV/JL4vXV3UXvbmJ9BEmJMaLgnMs9KIMlFc/8MLt6PE5JD/cEbvDcKz0PoErn
	OgYcmgbjeq/xKSiFtriuXW+7BOaiJSamBYqcaHy0m77pIo2VvHjnt/wUOTJ+I/0BTeW+rm
	NRxowo36jc3Ev8aZaxc7npzBro5pSNLY0rhLfBtCm8O5lGn/geSgGKYqdMEflg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762026466;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+un/zSMPImWK/I4voSXjufVjQC4iEle5L/X6FengRLw=;
	b=jgJiRH1Qse7XSYbuI0hhxokomznTNTW5rPxQhZL1ngzzaQJMIcmxPAhkCwR7LiNS5PlyS0
	gI5UJdyUbR6dpMAQ==
From: tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] sparc64: vdso: Link with -z noexecstack
Cc: Arnd Bergmann <arnd@kernel.org>, thomas.weissschuh@linutronix.de,
 Thomas Gleixner <tglx@linutronix.de>, Andreas Larsson <andreas@gaisler.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To:
 <20251014-vdso-sparc64-generic-2-v4-25-e0607bf49dea@linutronix.de>
References: <20251014-vdso-sparc64-generic-2-v4-25-e0607bf49dea@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176202646549.2601451.1026228364322959624.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     1280e8b97d703a686eb2270c5723f2d44e99252e
Gitweb:        https://git.kernel.org/tip/1280e8b97d703a686eb2270c5723f2d44e9=
9252e
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Tue, 14 Oct 2025 08:49:11 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 01 Nov 2025 20:44:06 +01:00

sparc64: vdso: Link with -z noexecstack

The vDSO stack does not need to be executable. Prevent the linker from
creating executable. For more background see commit ffcf9c5700e4 ("x86:
link vdso and boot with -z noexecstack --no-warn-rwx-segments").

Also prevent the following warning from the linker:

  sparc64-linux-ld: warning: arch/sparc/vdso/vdso-note.o: missing .note.GNU-s=
tack section implies executable stack
  sparc64-linux-ld: NOTE: This behaviour is deprecated and will be removed in=
 a future version of the linker

Fixes: 9a08862a5d2e ("vDSO for sparc")
Suggested-by: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Andreas Larsson <andreas@gaisler.com>
Reviewed-by: Andreas Larsson <andreas@gaisler.com>
Acked-by: Andreas Larsson <andreas@gaisler.com>
Link: https://lore.kernel.org/lkml/20250707144726.4008707-1-arnd@kernel.org/
Link: https://patch.msgid.link/20251014-vdso-sparc64-generic-2-v4-25-e0607bf4=
9dea@linutronix.de
---
 arch/sparc/vdso/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/vdso/Makefile b/arch/sparc/vdso/Makefile
index 683b2d4..400529a 100644
--- a/arch/sparc/vdso/Makefile
+++ b/arch/sparc/vdso/Makefile
@@ -104,4 +104,4 @@ quiet_cmd_vdso =3D VDSO    $@
 		       $(VDSO_LDFLAGS) $(VDSO_LDFLAGS_$(filter %.lds,$(^F))) \
 		       -T $(filter %.lds,$^) $(filter %.o,$^)
=20
-VDSO_LDFLAGS =3D -shared --hash-style=3Dboth --build-id=3Dsha1 -Bsymbolic --=
no-undefined
+VDSO_LDFLAGS =3D -shared --hash-style=3Dboth --build-id=3Dsha1 -Bsymbolic --=
no-undefined -z noexecstack

