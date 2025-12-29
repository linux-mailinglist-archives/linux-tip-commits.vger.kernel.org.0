Return-Path: <linux-tip-commits+bounces-7775-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A29DCE7371
	for <lists+linux-tip-commits@lfdr.de>; Mon, 29 Dec 2025 16:32:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5420C3008885
	for <lists+linux-tip-commits@lfdr.de>; Mon, 29 Dec 2025 15:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFF4A241CA2;
	Mon, 29 Dec 2025 15:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="W9qQXyeS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TUC/Btr0"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7754EEB3;
	Mon, 29 Dec 2025 15:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767022329; cv=none; b=kZS+yzs5Zw6ZAiU88l5wTVjEO7BtERMT9HJqwEDRCA53njXnP2lefQqOJV8THZYhQQHwZFVhD2jdxoGPzeQR6qJagtNYpspfJWkKWag0h0kXAvAT+q0EWjOl0KfP5BtfzIkS2jikZoT3/RqbWgtt1skkQqTaV4+IeAJ9MGzbH8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767022329; c=relaxed/simple;
	bh=fSRIhCdX5gNixcCzq0Yekxp9N9Eh0OlhVCmkxhWe4sc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=rsIgSFq05gsmsIWB81knShu4Cm66KtB3M6tF85IB/BJ1qsZVAJrCShT/v3C92D+XuHaFbbJD+j6YLxv8vl2St9bMRIapbnrVjn8vMjLuwLeHkF2DluN9lDe7+sOQ/nWcmLI/66Lo2uyYvyLcfQl/wlMDYtnosqUrw+GYjbsL2KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=W9qQXyeS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TUC/Btr0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 29 Dec 2025 15:31:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1767022324;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LavvjmoSoChlo1z471ENH9JZJ4WL6lualYR5qbVJkFw=;
	b=W9qQXyeSYJoXF5K5saq9dWQfufy21twDpNKQeMBnTuZS6eeV4/9BHtaUZybZlubH4feKjB
	yduxY1+MaCgiWsjPAF4HY2F9r2KVRTBfQ8FfHQ+Qfr102bJaP/oDLPvDb9OjlwObGIpTBM
	MZ1/jM2F4htIzNDyCg0kXfiHGgikyf0ipcOwDO8WmcxwcrkTBg35qH09AXDllSoR66cD2Q
	n8bs0LQiu4FUFTkaTdWd0kcMmwHWsvvUMfkM/lpq025Mdd1TXKUBEch7sX3trhiH/OERWu
	ltSTU1bYSGcA5lLXbH+OGLeypzqXZqVNnk4zC8RwExqcHlKq5gmBx6CCIOLP8A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1767022324;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LavvjmoSoChlo1z471ENH9JZJ4WL6lualYR5qbVJkFw=;
	b=TUC/Btr0VZTCekEp+owOr8oHRmAxHFJWffosyT7T3nNYmr+ZD0sIfuOIJG3G9Jn4ERqOl9
	J4nT/tMyFj7kIlBQ==
From: "tip-bot2 for Brendan Jackman" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/bugs] Documentation/x86: Fix PR_SET_SPECULATION_CTRL error codes
Cc: Brendan Jackman <jackmanb@google.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251111-b4-prctl-docs-2-v2-1-bc9d14ec9662@google.com>
References: <20251111-b4-prctl-docs-2-v2-1-bc9d14ec9662@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176702231989.510.14589594757275090350.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/bugs branch of tip:

Commit-ID:     4992ed7813c54f0a676b7707d1f8f16552fdb240
Gitweb:        https://git.kernel.org/tip/4992ed7813c54f0a676b7707d1f8f16552f=
db240
Author:        Brendan Jackman <jackmanb@google.com>
AuthorDate:    Tue, 11 Nov 2025 17:41:08=20
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 29 Dec 2025 16:27:45 +01:00

Documentation/x86: Fix PR_SET_SPECULATION_CTRL error codes

If you force-disable mitigations on the kernel cmdline, for SPEC_STORE_BYPASS
this ends up with the prctl returning -ENXIO, but contrary to the current docs
for the other controls it returns -EPERM. Fix that.

Note that this return value should probably be considered a bug. But, making
the behaviour consistent with the current docs seems more likely to break
existing users than help anyone out in practice, so just "fix" it by
specifying it as correct.

Since this is getting more wordy and confusing, also be more explicit about
"control is not possible" be mentioning the boot configuration, to better
distinguish this case conceptually from the FORCE_DISABLE failure mode.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://patch.msgid.link/20251111-b4-prctl-docs-2-v2-1-bc9d14ec9662@goo=
gle.com
---
 Documentation/userspace-api/spec_ctrl.rst | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/Documentation/userspace-api/spec_ctrl.rst b/Documentation/usersp=
ace-api/spec_ctrl.rst
index ca89151..61fe020 100644
--- a/Documentation/userspace-api/spec_ctrl.rst
+++ b/Documentation/userspace-api/spec_ctrl.rst
@@ -81,11 +81,15 @@ Value   Meaning
 ERANGE  arg3 is incorrect, i.e. it's neither PR_SPEC_ENABLE nor
         PR_SPEC_DISABLE nor PR_SPEC_FORCE_DISABLE.
=20
-ENXIO   Control of the selected speculation misfeature is not possible.
-        See PR_GET_SPECULATION_CTRL.
+ENXIO   For PR_SPEC_STORE_BYPASS: control of the selected speculation misfea=
ture
+        is not possible via prctl, because of the system's boot configuratio=
n.
+
+EPERM   Speculation was disabled with PR_SPEC_FORCE_DISABLE and caller tried=
 to
+        enable it again.
+
+EPERM   For PR_SPEC_L1D_FLUSH and PR_SPEC_INDIRECT_BRANCH: control of the
+        mitigation is not possible because of the system's boot configuratio=
n.
=20
-EPERM   Speculation was disabled with PR_SPEC_FORCE_DISABLE and caller
-        tried to enable it again.
 =3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
 Speculation misfeature controls

