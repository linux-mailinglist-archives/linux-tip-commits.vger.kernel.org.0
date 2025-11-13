Return-Path: <linux-tip-commits+bounces-7322-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9BF2C54FE1
	for <lists+linux-tip-commits@lfdr.de>; Thu, 13 Nov 2025 01:46:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C73B03AF5CD
	for <lists+linux-tip-commits@lfdr.de>; Thu, 13 Nov 2025 00:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01F1A230BDF;
	Thu, 13 Nov 2025 00:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WJCGSuXb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dpPVSNtV"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5369E223DDA;
	Thu, 13 Nov 2025 00:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762994497; cv=none; b=REqCSk/+H09ldQOIWOFTPNHfEY/S3SN0kR96JRRdBQifta/fcyynV0hGiuTVrbmJxKntSf+MByiKS96+lE82wGlrcA9Wet90zSJioJc1xT64C93uvGCJ5L7AAnrDraf7IxSfXSL9d7x3m+j/rh2WVlJaB6r6aTCX3H2ratltTLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762994497; c=relaxed/simple;
	bh=HAazsy3am724sD3DlMJ19+SRy8yIoXu08cF16TuvBkY=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=mRAHHn02YKNgeQ8EQnNoyMw3kvIxdxj+YVmhSAAOKgbB2tulxa6fTMS8OmwZ9NlMk9LgtmyjfZcpu6Jb8BK2WcN2SWOaeFGt5pewXKX9KomcxVaD9wZ3TO0uP/DseE+OrhF0b62m7l3jw9np6kvqZCpHtof7zaIHvarQ4b/fIlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WJCGSuXb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dpPVSNtV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 13 Nov 2025 00:41:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762994494;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=A4HVNUq+r6RUvyGlnR7VFw89IJFekqAQdBzttQ3RZMQ=;
	b=WJCGSuXbIPpD7NoynvyL175a4tOEBlSvCqpgLvziYrzOTwaxzKlSW5eng6OJdgEjFm4byX
	xOm7eDjGRzHwkZtAuFPuHIbFm9SNtb4PoD+D4RNcm+LIpz5UNYO7W4klQtzCG1u7BRRjxb
	feVSgs1JZUIOy7/Zf3ApKEFlEZZvyoDJEb3LCDA8F6xJmykCG/Qw32PqdIfhyFfaRthJFd
	6cJg/s8gDx+iqHkVaAkeL6NjYpSyd5IifDH4lNGF4LSq0E6JKsW2Ek8TSDTkWxzSeiJnxo
	DEcqpCiFrfQ38YGJp+biFLc/v9U4gs79K2qVOk69EGxW/3pihKUdTFTr2DC/1w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762994494;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=A4HVNUq+r6RUvyGlnR7VFw89IJFekqAQdBzttQ3RZMQ=;
	b=dpPVSNtVraP+3gPnnlntq1+ftH6JQNOJK5wtJl6jb5UGhpkORkbtkPGkKsRe0xmyyjbsve
	7w8rjISLUfIyuqAQ==
From: "tip-bot2 for Sean Christopherson" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/misc] x86/bugs: Drop unnecessary export of "x86_spec_ctrl_base"
Cc: Sean Christopherson <seanjc@google.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176299449292.498.16952159173478864398.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/misc branch of tip:

Commit-ID:     ed028824605a6ddf8707b9313f7e76419d453ca6
Gitweb:        https://git.kernel.org/tip/ed028824605a6ddf8707b9313f7e76419d4=
53ca6
Author:        Sean Christopherson <seanjc@google.com>
AuthorDate:    Wed, 12 Nov 2025 09:39:41 -08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 12 Nov 2025 15:24:42 -08:00

x86/bugs: Drop unnecessary export of "x86_spec_ctrl_base"

Don't export x86_spec_ctrl_base as it's used only in bugs.c and process.c,
neither of which can be built into a module.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://patch.msgid.link/20251112173944.1380633-2-seanjc%40google.com
---
 arch/x86/kernel/cpu/bugs.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index d7fa03b..57c1d0e 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -102,7 +102,6 @@ static void __init vmscape_apply_mitigation(void);
=20
 /* The base value of the SPEC_CTRL MSR without task-specific bits set */
 u64 x86_spec_ctrl_base;
-EXPORT_SYMBOL_GPL(x86_spec_ctrl_base);
=20
 /* The current value of the SPEC_CTRL MSR with task-specific bits set */
 DEFINE_PER_CPU(u64, x86_spec_ctrl_current);

