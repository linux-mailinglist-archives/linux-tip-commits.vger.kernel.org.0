Return-Path: <linux-tip-commits+bounces-8122-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eMJXMUQ9eWkmwAEAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8122-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Tue, 27 Jan 2026 23:33:40 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 437429B19F
	for <lists+linux-tip-commits@lfdr.de>; Tue, 27 Jan 2026 23:33:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2DCDE3012C9E
	for <lists+linux-tip-commits@lfdr.de>; Tue, 27 Jan 2026 22:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142322BEC34;
	Tue, 27 Jan 2026 22:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0eyqrWoi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cp/inBou"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4D828B40E;
	Tue, 27 Jan 2026 22:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769553218; cv=none; b=neB/zV80ium/s7ubvCofkXLbGlYhh4GBHcHLd7CelLFiSu8rJwgMu5ZwxxEbgRZ1h+D0ZbsO+jYRmqTE9x7HcE2r/rfhVRQt87NrnjO4u6NORPgRDgn/YQkp/YZNBAAX0uHpclzLqVzIrCNmmznTCg80u7prbts7Vc4L5l4jdtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769553218; c=relaxed/simple;
	bh=itmi3HwYaU6QmNhZnmeRic1+Qr9k+sEMKv/67QTMiVw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=rpXtwZrjnqykQUCMp5W7kMall5hIrLEYXY7aaB7Zd8G8DnTS3TkujV0Jygcrm4Jf6GvnVrB2aiiylreeuU2otrY9b6tw8A6vh0aG49Z/5bv5xoZDEtaHJ/jvNCBzNn3aHaINQDYTJDRoydsJOtzfyss52bZz85Xs1eq80AOEDXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0eyqrWoi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cp/inBou; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 27 Jan 2026 22:33:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769553214;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nyxWRsIPHDdFmFwu1UBan18PmEJleZvywvFwumL/w3c=;
	b=0eyqrWoigtnClsZAgcO4SsEDQPQneaO2kC6ZM/O6dxwFJXMKgNBZTOvaaOzaer8IqraXY9
	JZG3GwcKNlv/aISgg9wnAH88XhCHwKcJkuPxbzmmcmqm60A5np9pgBD2axoCy1UP+fMZp4
	E7nViBMIQP7OmAwrAjx1iqW2vBWamMQp0j+Pc0kRjlJXrcV10kG4QxRyQJEw2qS0JLvo9W
	E3ia4J/tcrMYdGvgYMC73JjsWFiLjyU9Y7wjDHFxqU6ugrtM8uzeJ0t+Qkqe7J3QV3dNbH
	OKxV1rIlM82IYdWU5rXlPCSM+gJ0nIeEaF/gFNUP9BEdVNtqSQAw91VjpvED6Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769553214;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nyxWRsIPHDdFmFwu1UBan18PmEJleZvywvFwumL/w3c=;
	b=cp/inBou8IvhLnC3ueTyR2NpCBPhH7ez9xKA0/FzIPR990LSJQEFelS5/DJvFxJhUUM1KZ
	vI8ZDfdnVV8EplDw==
From: "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/entry/vdso: Add vdso2c to .gitignore
Cc: "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260127221633.GAaXk5QcG8ILa1VWYR@fat_crate.local>
References: <20260127221633.GAaXk5QcG8ILa1VWYR@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176955321028.510.13974267628361703474.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-8122-lists,linux-tip-commits=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:replyto,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,alien8.de:email,msgid.link:url]
X-Rspamd-Queue-Id: 437429B19F
X-Rspamd-Action: no action

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     ce9b1c10c3f1c723c3cc7b63aa8331fdb6c57a04
Gitweb:        https://git.kernel.org/tip/ce9b1c10c3f1c723c3cc7b63aa8331fdb6c=
57a04
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Tue, 27 Jan 2026 23:09:13 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 27 Jan 2026 23:27:51 +01:00

x86/entry/vdso: Add vdso2c to .gitignore

The commit

  a76108d05ee1 ("x86/entry/vdso: Move vdso2c to arch/x86/tools")

moved vdso2c to arch/x86/tools/ and commit

  93d73005bff4 ("x86/entry/vdso: Rename vdso_image_* to vdso*_image")

renamed .so files but also dropped vdso2c from
arch/x86/entry/vdso/.gitignore.

It should've moved it to arch/x86/tools/.gitignore instead.

Do that.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://patch.msgid.link/20260127221633.GAaXk5QcG8ILa1VWYR@fat_crate.lo=
cal
---
 arch/x86/tools/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/tools/.gitignore b/arch/x86/tools/.gitignore
index d36dc7c..51d5c22 100644
--- a/arch/x86/tools/.gitignore
+++ b/arch/x86/tools/.gitignore
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
 relocs
+vdso2c

