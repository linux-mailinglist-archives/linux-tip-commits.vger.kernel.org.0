Return-Path: <linux-tip-commits+bounces-1321-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5EE8D740E
	for <lists+linux-tip-commits@lfdr.de>; Sun,  2 Jun 2024 09:09:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A4981F214F3
	for <lists+linux-tip-commits@lfdr.de>; Sun,  2 Jun 2024 07:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAA2618E1E;
	Sun,  2 Jun 2024 07:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QUNrXx39";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IA99Rak1"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA87917C7C;
	Sun,  2 Jun 2024 07:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717312162; cv=none; b=ETPpz9My9KAOeLAktmIirvWdZYJKknZiCwBzNibvLEbZGP/gzQTkazNZv5XXDKFAkiwAN5P2BJQULijvQnkIgdUzWkql+pJ1R3ao8n4kwnPwYSauvx+bQ0oWQX0IonJ4YWG79VXt/aeGLoP3Yhrx0+9hctF2aUcUOQceBiP8hQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717312162; c=relaxed/simple;
	bh=eWMvK8zEzjBo1UhvWWGDLlrft+zr4sDTEwLYXs5f0xM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=sk1Trgsm+2LYbqIe5V25XWAOZd7TLMvwKzfJIxVFanzQpuK3fiog/0/rGAGE/XIHeljCpWmZmYjWrv8/2EOTHvF1PaZrhjgTTODwkh40pC2DeZO8mekpi4ZnHTGAPZh16CIY1vH4HwL+3DOdjkT6BaX7tb31DIv4kcJXWizvu9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QUNrXx39; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IA99Rak1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 02 Jun 2024 07:09:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717312158;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R4yfv214+lF4riCZiINYcm4aw+f5AMPElgutDgYh7XM=;
	b=QUNrXx39hWv7/jxNiyowsM9oZBqet1lORLzYpM94QM+Y7qAzUkul7pd630+RjeIeI4aKD5
	7oiuqw1CxP+V4IJjKJvLBYE+OxJjzT1LwL2HOmP1ZbGA65IVYDey6VeK3NMEYPkQYlxLwV
	YRByyhwxFxtFGhqIxmyH+2OeOKcNIXtSfm8yM/AVfrNjpCoMcFMK/GrdiQGjzCs3lysqJE
	Icu4zZ9WGuhtBnDQGGvE5iaJ81rKCxQBeRJY+3vPURFQmYA3QpQw4fD//aPwkWlLvT7NMX
	mx4Da7WLT2WMWYKEhGnj5dAKgKqh/+j2nVJiJMAYe36NzJvytftj9+PMx7eFoQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717312158;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R4yfv214+lF4riCZiINYcm4aw+f5AMPElgutDgYh7XM=;
	b=IA99Rak1chgkYlHDVrNtSYzgM+m+b0JWM6Tm5X8QnBxAv/I97SYZMeO+AxVbPgSqfi85yQ
	NVZGE4rrVzh8OhDw==
From: "tip-bot2 for Jeff Johnson" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/mce/inject: Add missing MODULE_DESCRIPTION() line
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240530-md-x86-mce-inject-v1-1-2a9dc998f709@quicinc.com>
References: <20240530-md-x86-mce-inject-v1-1-2a9dc998f709@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171731215689.10875.9629248102691108658.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     eb9d3c0bb065e55af6ec88e82a94b57fa1bb6e5d
Gitweb:        https://git.kernel.org/tip/eb9d3c0bb065e55af6ec88e82a94b57fa1bb6e5d
Author:        Jeff Johnson <quic_jjohnson@quicinc.com>
AuthorDate:    Thu, 30 May 2024 17:20:20 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 02 Jun 2024 09:05:02 +02:00

x86/mce/inject: Add missing MODULE_DESCRIPTION() line

make W=1 C=1 warns:

  WARNING: modpost: missing MODULE_DESCRIPTION() in arch/x86/kernel/cpu/mce/mce-inject.o

Add the missing MODULE_DESCRIPTION().

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20240530-md-x86-mce-inject-v1-1-2a9dc998f709@quicinc.com
---
 arch/x86/kernel/cpu/mce/inject.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/cpu/mce/inject.c b/arch/x86/kernel/cpu/mce/inject.c
index 94953d7..4ade2a3 100644
--- a/arch/x86/kernel/cpu/mce/inject.c
+++ b/arch/x86/kernel/cpu/mce/inject.c
@@ -795,4 +795,5 @@ static void __exit inject_exit(void)
 
 module_init(inject_init);
 module_exit(inject_exit);
+MODULE_DESCRIPTION("Machine check injection support");
 MODULE_LICENSE("GPL");

