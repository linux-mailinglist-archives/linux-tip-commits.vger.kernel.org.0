Return-Path: <linux-tip-commits+bounces-3515-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37DD5A39BE8
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 13:16:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39FDE3B7F1F
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 12:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2529F248178;
	Tue, 18 Feb 2025 12:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Eieo8wSs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="37Rdd34W"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854182475D1;
	Tue, 18 Feb 2025 12:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739880718; cv=none; b=Ynq/zdGNQrJn3VPqy2CnAIgMeKgbpoD4fKr1YpUrcJgYj1Vmo9rF7WUh8jxnWVfsHv0itVFa+Fqb2KFJMK5m7udSa2p/DM3NaOnNKH4NrTPIBoMO2A8dLtCW2oGenAW645s3ax41dzTnNv2ozRd65FKY5qbxIbEROCr17BEtMto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739880718; c=relaxed/simple;
	bh=H1ti9BI1hF1QTtQajZc+ss+E3kGneL2wPoDc++YUjZ4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=AsbgvtuOSaZWIrRx9KzJFLOOpWiHDcJ4OAcaq44m/p7VoOgvv5cxZmJVL5Rja7oqnNq6g0jxGg8QXxU86Q6AR2VAtJKh38fSOGY8xLNQNJWIkEm0b4gsqdfqW4qzGcIiKbipXoeKB6BIvWH9CVy2EUqEcn8dgIkKWLEc9kFqw1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Eieo8wSs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=37Rdd34W; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Feb 2025 12:11:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739880714;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gVgN5KA0uitqu6TcIX+iselgyEA/p2zluCADQUw1PH0=;
	b=Eieo8wSsKyTVMQk3PGCB2A3Jwib83kFuGuphfo/068SWcxHxdXXJqmGlfYzTI1chSEXXpb
	UDPXmHQu28gb2csEzDXoE7S0cbvI1FQtiz911XdrQzmx9+wBVeg/KxnxSMtWqX96neFutm
	LDssDn4AYdPyjQqW4jf6Xi92fSg2jmA3kRq1cwrgZz3/ypUe0RA0WMvuHSzVLJPgvL8gBo
	hsNwFLMo45XY4qQKlwEHEs13F1JJWmzgssclGkUw1OOUh3dt+vX8nJkmp0pgy3uafKCLpq
	LQJmtSMNsJ+VRAJAxhGwJARo5/LHb7DH1nDgFepEDHvC8sQJDYfs9u4hAI0n8g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739880714;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gVgN5KA0uitqu6TcIX+iselgyEA/p2zluCADQUw1PH0=;
	b=37Rdd34WUtfTdUMA7CTFimgoaMtn97aszEC3p9PAsGd0VL4FApcUiXjGXkiLC3dEWKfiwB
	p6YdyIZAwhIXLoCA==
From: "tip-bot2 for Brian Gerst" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/asm] x86/build: Raise the minimum GCC version to 8.1
Cc: Brian Gerst <brgerst@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Ard Biesheuvel <ardb@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250123190747.745588-2-brgerst@gmail.com>
References: <20250123190747.745588-2-brgerst@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173988071431.10177.9680149445111094327.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     a3e8fe814ad15c16735cdf394454a8bd96eb4d56
Gitweb:        https://git.kernel.org/tip/a3e8fe814ad15c16735cdf394454a8bd96eb4d56
Author:        Brian Gerst <brgerst@gmail.com>
AuthorDate:    Thu, 23 Jan 2025 14:07:33 -05:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 18 Feb 2025 10:14:40 +01:00

x86/build: Raise the minimum GCC version to 8.1

Stack protector support on 64-bit currently requires that the percpu
section is linked at absolute address 0, because older compilers fixed
the location of the canary value relative to the GS segment base.

GCC 8.1 introduced options to change where the canary value is located,
allowing it to be configured as a standard per-CPU variable.  This has
already been done for 32-bit.  Doing the same for 64-bit will enable
removing the code needed to support zero-based percpu.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20250123190747.745588-2-brgerst@gmail.com
---
 scripts/min-tool-version.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/min-tool-version.sh b/scripts/min-tool-version.sh
index 91c9120..06c4e41 100755
--- a/scripts/min-tool-version.sh
+++ b/scripts/min-tool-version.sh
@@ -19,6 +19,8 @@ binutils)
 gcc)
 	if [ "$ARCH" = parisc64 ]; then
 		echo 12.0.0
+	elif [ "$SRCARCH" = x86 ]; then
+		echo 8.1.0
 	else
 		echo 5.1.0
 	fi

