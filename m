Return-Path: <linux-tip-commits+bounces-6553-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B49B52A2D
	for <lists+linux-tip-commits@lfdr.de>; Thu, 11 Sep 2025 09:36:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C1751B23D42
	for <lists+linux-tip-commits@lfdr.de>; Thu, 11 Sep 2025 07:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D0A2277CAE;
	Thu, 11 Sep 2025 07:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RbptERbn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YyHXqrr5"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A1E2765CA;
	Thu, 11 Sep 2025 07:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757576103; cv=none; b=IZdVg+Mm+0wB10ZGXKfAccgPLZ6jIckazGxggG7EdnG09nKjm7AEgBGqkTXOZ7vm/aA5B+YcD4l+4MYzoegJ8tpl0rKbBR2p8VtBg+jkw9DxNG6+QZlLoVqbs4lhLeFw4qG6TGpsURcyUK2BRD2xmN21LfoghOmpA3mhXJ2CLaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757576103; c=relaxed/simple;
	bh=W9qInGBIWLDCqO0rpQUtfynuESg7qZ0n7wwIqe3JITU=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=aN/oX7oSJPpGsEtEZSBPBsiNG1xV2dgPPicnfZqvaans/kX9jzwtGwMN8qda2fUo8ScTedwMvJAfSgSIsqJWXccjD7iffNDIe/1j7AAqOLyFlX96hTM1/4cPujVmTWu5hN/F2efTKUmSiGe9Ovv7B8l/81XXjepAuUZVnUI7ytA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RbptERbn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YyHXqrr5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 11 Sep 2025 07:34:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757576100;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=e9m9P1agWTgwchgYelEYX0eRygs45yZo0BjMfpHbseY=;
	b=RbptERbngw4adVJkI1AydWnwBKjsJ9ah1EYSlR5ACobT59vafltCZVWGezvOYlI04pgZVO
	Nb/pQ9HHzQ0pUCpiyi8BNcrPMPouJiUVing4O1SOSqZutQ5GpC44JRuM0wXupw+xYOWBYP
	KQJUyLwnwR4Nxnkhagr5f0a0t4c/k2jrZvEznVAlSqQ7YC81fcS7mVgfzSg47Te1XEBsII
	1kyvp4RtrcxUjhiEwSVCq3Nw9eL39PTeD/bdQQItbmcUi08Syn6k3SRCcnGY8DUSqTni23
	/R3UOwMBp8vKsF7n+jL28XozowsGhJdCtb+MxfmjVa4DLLBiePwd5u6ighwokA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757576100;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=e9m9P1agWTgwchgYelEYX0eRygs45yZo0BjMfpHbseY=;
	b=YyHXqrr54KDAYSk6+j5ev8gm7KMzRXZFA7MYmwBWyfa9V0FCzP03l6Al5zEnEoVOKeiUJl
	zIouq39yu46mqxCA==
From: "tip-bot2 for Kees Cook" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/traps: Clarify KCFI instruction layout
Cc: Kees Cook <kees@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175757609898.709179.986913656279563683.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     628a15e0536abb7658cd243553312d3f65c0aff2
Gitweb:        https://git.kernel.org/tip/628a15e0536abb7658cd243553312d3f65c=
0aff2
Author:        Kees Cook <kees@kernel.org>
AuthorDate:    Wed, 03 Sep 2025 20:46:41 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 04 Sep 2025 21:59:07 +02:00

x86/traps: Clarify KCFI instruction layout

Just a nit-picky change to the KCFI indirect call check instruction
documentation. The addl offset isn't always -4 (it depends on patchable
function entry configuration).

Signed-off-by: Kees Cook <kees@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250904034656.3670313-2-kees@kernel.org
---
 arch/x86/kernel/cfi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cfi.c b/arch/x86/kernel/cfi.c
index 77086cf..638eb5c 100644
--- a/arch/x86/kernel/cfi.c
+++ b/arch/x86/kernel/cfi.c
@@ -27,7 +27,7 @@ static bool decode_cfi_insn(struct pt_regs *regs, unsigned =
long *target,
 	 * for indirect call checks:
 	 *
 	 * =C2=A0 movl    -<id>, %r10d       ; 6 bytes
-	 *   addl    -4(%reg), %r10d    ; 4 bytes
+	 *   addl    -<pos>(%reg), %r10d; 4 bytes
 	 *   je      .Ltmp1             ; 2 bytes
 	 *   ud2                        ; <- regs->ip
 	 *   .Ltmp1:

