Return-Path: <linux-tip-commits+bounces-7664-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F13D0CBB7C2
	for <lists+linux-tip-commits@lfdr.de>; Sun, 14 Dec 2025 08:59:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A083C3003BF0
	for <lists+linux-tip-commits@lfdr.de>; Sun, 14 Dec 2025 07:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF006243969;
	Sun, 14 Dec 2025 07:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YJJw0aEU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JtvGbKCb"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FBB1448D5;
	Sun, 14 Dec 2025 07:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765699179; cv=none; b=LlyIi+djT9YJyE7YiM/Wo/1KBnI+udLyG/NKoGD4yJLoJJuA6OT29/nQ13e0H8pbwMQn+1NICBu5S+s1vKDet54efsl/jVNLEsomJAfABW7XqoxIgc7MjePUcFEsMZE4viibry7IxQ/a139LrFVsxIfGRiPbfElZj0dOs7Ts9vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765699179; c=relaxed/simple;
	bh=NPfS2xx66D6+uo7sYmR5ZVnIpGZMCn53LlavH61dvgs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=jhvSk16f1btjdjxruAhyXBAP4NrbXkBPeth48lWT+laaAiGS+OhIG7fMWH/h49yJUrP/61UiQB7zzS+vhxgrmFe6gmTWJ2iBHGnBfPci+FKVg6jpwTc0Gb/o+jr1CAkKGtrTOGI63hMZG7ZH1GLDRsiIMKg7dH3yaqBnh851BHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YJJw0aEU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JtvGbKCb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 14 Dec 2025 07:59:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765699176;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yZccdFQKuAPs5xeG/R2LBvvPguEytVehTyEB+Eh2RCU=;
	b=YJJw0aEU8lBaLqpDIEkg6l/PH9BxJQRSBNqnnNqbIZJdrvDX+Emxb0MJNcr6oDq/v8+KFw
	lWwPbRZgaPxHHoCNGIz3LQGlYB85FnLfGNzmSGey4uWeZU5eNokJwQZehMijmrUdX0cnCp
	zQVUVNdk6hH/jPoPw5+JL2nk/KtMG5YPjLQlzBrxwwPl5mu+mnnp5n9UqeQuwgCwvbEvKu
	IdZ/yhqFEKyshaAI1ebzRDcB8X6/xfbYXKOmlJSLbtdOPxEUCOKb26kN97NW8h0iYX951i
	6/5iXCn8withQd0ZfmcKFenIeG+Pn6MZTHqaz9/QmoE4yuJ30tK+WPWmPQ56/w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765699176;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yZccdFQKuAPs5xeG/R2LBvvPguEytVehTyEB+Eh2RCU=;
	b=JtvGbKCbpny2TG7/3/th0W60N4WdVlvNWhi0E4k9B78D+W8gjsN5xu7Kh90piEs7SMGiOy
	Dt85oCQVYsyDIxBg==
From: "tip-bot2 for Kyle Meyer" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/urgent] x86/platform/uv: Fix UBSAN array-index-out-of-bounds
Cc: Kyle Meyer <kyle.meyer@hpe.com>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <aTxksN-3otY41WvQ@hpe.com>
References: <aTxksN-3otY41WvQ@hpe.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176569917501.498.242341801054532826.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     21433d3e3ca14d20f9b0c2237b3d3a1355af7907
Gitweb:        https://git.kernel.org/tip/21433d3e3ca14d20f9b0c2237b3d3a1355a=
f7907
Author:        Kyle Meyer <kyle.meyer@hpe.com>
AuthorDate:    Fri, 12 Dec 2025 12:53:36 -06:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 14 Dec 2025 08:46:53 +01:00

x86/platform/uv: Fix UBSAN array-index-out-of-bounds

When UBSAN is enabled, multiple array-index-out-of-bounds messages are
printed:

  [    0.000000] [     T0] UBSAN: array-index-out-of-bounds in arch/x86/kerne=
l/apic/x2apic_uv_x.c:276:23
  [    0.000000] [     T0] index 1 is out of range for type '<unknown> [1]'
  ...
  [    0.000000] [     T0] UBSAN: array-index-out-of-bounds in arch/x86/kerne=
l/apic/x2apic_uv_x.c:277:32
  [    0.000000] [     T0] index 1 is out of range for type '<unknown> [1]'
  ...
  [    0.000000] [     T0] UBSAN: array-index-out-of-bounds in arch/x86/kerne=
l/apic/x2apic_uv_x.c:282:16
  [    0.000000] [     T0] index 1 is out of range for type '<unknown> [1]'
  ...
  [    0.515850] [     T1] UBSAN: array-index-out-of-bounds in arch/x86/kerne=
l/apic/x2apic_uv_x.c:1344:23
  [    0.519851] [     T1] index 1 is out of range for type '<unknown> [1]'
  ...
  [    0.603850] [     T1] UBSAN: array-index-out-of-bounds in arch/x86/kerne=
l/apic/x2apic_uv_x.c:1345:32
  [    0.607850] [     T1] index 1 is out of range for type '<unknown> [1]'
  ...
  [    0.691850] [     T1] UBSAN: array-index-out-of-bounds in arch/x86/kerne=
l/apic/x2apic_uv_x.c:1353:20
  [    0.695850] [     T1] index 1 is out of range for type '<unknown> [1]'

One-element arrays have been deprecated:

  https://docs.kernel.org/process/deprecated.html#zero-length-and-one-element=
-arrays

Switch entry in struct uv_systab to a flexible array member to fix UBSAN
array-index-out-of-bounds messages.

sizeof(struct uv_systab) is passed to early_memremap() and ioremap(). The
flexible array member is not accessed until the UV system table size is used =
to
remap the entire UV system table, so changes to sizeof(struct uv_systab) have=
 no
impact.

Signed-off-by: Kyle Meyer <kyle.meyer@hpe.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://patch.msgid.link/aTxksN-3otY41WvQ@hpe.com
---
 arch/x86/include/asm/uv/bios.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/uv/bios.h b/arch/x86/include/asm/uv/bios.h
index 6989b82..d0b62e2 100644
--- a/arch/x86/include/asm/uv/bios.h
+++ b/arch/x86/include/asm/uv/bios.h
@@ -122,7 +122,7 @@ struct uv_systab {
 	struct {
 		u32 type:8;	/* type of entry */
 		u32 offset:24;	/* byte offset from struct start to entry */
-	} entry[1];		/* additional entries follow */
+	} entry[];		/* additional entries follow */
 };
 extern struct uv_systab *uv_systab;
=20

