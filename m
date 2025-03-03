Return-Path: <linux-tip-commits+bounces-3772-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D2DA4BC9B
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Mar 2025 11:43:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02BBD188FAAF
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Mar 2025 10:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D151F2C5F;
	Mon,  3 Mar 2025 10:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ag46zwPO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="54exjLt7"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7929F1E7C0B;
	Mon,  3 Mar 2025 10:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740998582; cv=none; b=X/I3sDS/412tRw+Xnnr0aRgXj0jHFiBm2I6sRIqZbvDaw6d9uYmBAwGeYuWaL7L4J/9nKmQdXtQcpFUhDw9D9WbMCe+IgHS4yzk7evPfHeCAj8bQaCc7v0A0IhxJ1eBcmTGlGDxSE4HtcYqGY2UpG9NPH3zs+CcjcWgYReBwa/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740998582; c=relaxed/simple;
	bh=I7zbNA/MrVVqgpPsuTX29OfvV+dxNyrdjxDLMh4Yc5E=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=dt34Z/NSUd17sMUGQpvjJAfCGVla/6njlm1LyF5VACkVt3NfQ/+bK0aQRttk1zPXGgRzKTdrwiC144gxBR5FN8Pe8eNJGR9zsKf3R48Xh85zgCPwqlLnATL7ZKW42EMvFC353Ls8nrDslX404rfdWlDYLVC3yOr24GIWT8F1uxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ag46zwPO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=54exjLt7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 03 Mar 2025 10:42:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740998579;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=JfT5nkPrimpGaTi97Wx0hFjlBuNqW/q6ZpFStqy2jFs=;
	b=Ag46zwPObHbnXziZlgzpeNDWT2szfTL18vsHnrH4A9gXACZrz+eZuoKPO1zrmkMZ38ezOX
	+WHNuCpN9omNWwIrLdYN7SRJWT1NJrxpY5jgMXITi97mNDob1mftYo9Z4KTiQXVqcKD+pj
	U93L91G1NM5SaagcgF1P9uwWUTlw9vSftn5aN4huoHMdRux4ylrJsE0RYnXNmGBGuTq/fA
	Vi57m2rcFKhViUM7h0lI4liLb2t4Ho3ZnWl9bpvO3YrNqKnUNm8pgAkjKilJ96ryzOoAlW
	e3vA2msOk6Sv6IsanrUL/kZHTetdVVn5Pvh1Y81PIQxbOrAV/maFCHhUBeVj9Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740998579;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=JfT5nkPrimpGaTi97Wx0hFjlBuNqW/q6ZpFStqy2jFs=;
	b=54exjLt7sfpX+90njG10JRdiCrgC1ppIGDbQyIX9TKfuVqO6CeZzVrjE64TTDKOrdgsOLV
	84+qxyCS+5CeDEBA==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/vdso] powerpc/vdso: Prepare introduction of struct vdso_clock
Cc: Nam Cao <namcao@linutronix.de>, thomas.weissschuh@linutronix.de,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174099857888.10177.16294622252819580843.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     e2e2f7990d87cae85b648be0c3ff6f6ff025a788
Gitweb:        https://git.kernel.org/tip/e2e2f7990d87cae85b648be0c3ff6f6ff02=
5a788
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Tue, 25 Feb 2025 13:36:49 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 03 Mar 2025 10:24:35 +01:00

powerpc/vdso: Prepare introduction of struct vdso_clock

To support multiple PTP clocks, the VDSO data structure needs to be
reworked. All clock specific data will end up in struct vdso_clock and in
struct vdso_time_data there will be array of it. By now, vdso_clock is
simply a define which maps vdso_clock to vdso_time_data.

To prepare for the rework of the data structures, replace the struct
vdso_time_data pointer with struct vdso_clock pointer whenever applicable.

No functional change.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 arch/powerpc/include/asm/vdso/gettimeofday.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/vdso/gettimeofday.h b/arch/powerpc/incl=
ude/asm/vdso/gettimeofday.h
index dc955f2..99c9d6f 100644
--- a/arch/powerpc/include/asm/vdso/gettimeofday.h
+++ b/arch/powerpc/include/asm/vdso/gettimeofday.h
@@ -99,7 +99,7 @@ static __always_inline u64 __arch_get_hw_counter(s32 clock_=
mode,
 	return get_tb();
 }
=20
-static inline bool vdso_clocksource_ok(const struct vdso_time_data *vd)
+static inline bool vdso_clocksource_ok(const struct vdso_clock *vc)
 {
 	return true;
 }

