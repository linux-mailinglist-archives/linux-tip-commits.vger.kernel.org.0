Return-Path: <linux-tip-commits+bounces-7320-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E151C54FFF
	for <lists+linux-tip-commits@lfdr.de>; Thu, 13 Nov 2025 01:47:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F372C34DC11
	for <lists+linux-tip-commits@lfdr.de>; Thu, 13 Nov 2025 00:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7012A2248A5;
	Thu, 13 Nov 2025 00:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="grLSn8al";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dx2GuB2E"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22B9221F1F;
	Thu, 13 Nov 2025 00:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762994496; cv=none; b=L/BJlXbPFAXN58FXPWPdMrdUI85D1bxSIwq1GjRD3j8a6rVZ0G2ke245q9Pj4hYziwpvIW5fHxOaWdQf+9nPXXTPdil0tho56LcBgugC5qr1S46K9LnlKY2NPG58cP2Sh/rfP6V3bG35kG+ZXfy0W/8zE5d4Hyzj0qBnfcy0u5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762994496; c=relaxed/simple;
	bh=QyE9IGqHSz0xyWkUzINCkT2NjSmkItpOqCgxbCpOajY=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=uLMr34pMPEln1l0ayIsD4Id4pKdNbhuxQRq5J+3ycWfn0khWfnRk3A6P0eQYcoWsMBvbtdiZjq3Yti4AzY7psKwB2MfVGH/BKGfoK1emTo/R/oBGhR28HL00PydOGKlyPikfpfx0sIISawqBRrtDmr/wCs/VhYsVFPqf/Jxv1Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=grLSn8al; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dx2GuB2E; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 13 Nov 2025 00:41:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762994493;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=ggtGmOVMMNEq7rHMk70d8hju6XDWLJf8S74Gt5N1smI=;
	b=grLSn8al1OTJaMOLbMHFTvnTky5xoN3iS+T3HcQIctXCMXNvKSe5JtdSIm65KbFXE9Bd/6
	Aofb+K3NaTUpEhGx9DhfUSeSNMVFjUBqXbDgyNZNsaFcGGQM94ryjvFNR1HKLfHKjNSLKy
	uVM055KHOCQu06WtIt9smocEMThyXXZtClUmfiVEz60g4qKPq27hO9xzSmttwZPTAlId2O
	RBpimPzg9XFLNB6qlkRoD8qzaBoYUroxZIbzzPs9eZS3PY7AlSt55GPf4lMjFZ7jfbMQVp
	3TwxZcUdQApMXa/9KUgY+2AfXwg4+UyQNw0RPBkdIlf1nTIqtWCIifTEQinDQA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762994493;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=ggtGmOVMMNEq7rHMk70d8hju6XDWLJf8S74Gt5N1smI=;
	b=dx2GuB2EyTpe9zLPzDt0CKI9akpIasNphE6jXz8UTqLfoPIRaqkqM6w3g4dI4AFKmuBryf
	q6sg8eR17tJ19/Ag==
From: "tip-bot2 for Sean Christopherson" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/misc] x86/mtrr: Drop unnecessary export of "mtrr_state"
Cc: Sean Christopherson <seanjc@google.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176299449192.498.1287055698872115726.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/misc branch of tip:

Commit-ID:     9c26c91e103b58ba4f75f77d3d7338620b132ac4
Gitweb:        https://git.kernel.org/tip/9c26c91e103b58ba4f75f77d3d7338620b1=
32ac4
Author:        Sean Christopherson <seanjc@google.com>
AuthorDate:    Wed, 12 Nov 2025 09:39:42 -08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 12 Nov 2025 15:24:42 -08:00

x86/mtrr: Drop unnecessary export of "mtrr_state"

Don't export "mtrr_state" as usage is limited to arch/x86/kernel/cpu/mtrr
(and nothing outside of that directory even includes the local mtrr.h).

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://patch.msgid.link/20251112173944.1380633-3-seanjc%40google.com
---
 arch/x86/kernel/cpu/mtrr/generic.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mtrr/generic.c b/arch/x86/kernel/cpu/mtrr/ge=
neric.c
index 8c18327..0863733 100644
--- a/arch/x86/kernel/cpu/mtrr/generic.c
+++ b/arch/x86/kernel/cpu/mtrr/generic.c
@@ -89,7 +89,6 @@ static int mtrr_state_set;
 u64 mtrr_tom2;
=20
 struct mtrr_state_type mtrr_state;
-EXPORT_SYMBOL_GPL(mtrr_state);
=20
 /* Reserved bits in the high portion of the MTRRphysBaseN MSR. */
 u32 phys_hi_rsvd;

