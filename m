Return-Path: <linux-tip-commits+bounces-3153-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E75C59FE962
	for <lists+linux-tip-commits@lfdr.de>; Mon, 30 Dec 2024 18:21:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9272161396
	for <lists+linux-tip-commits@lfdr.de>; Mon, 30 Dec 2024 17:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77A241AF0BB;
	Mon, 30 Dec 2024 17:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Tkdq3Ghr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QMza5Xs7"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38E21AB505;
	Mon, 30 Dec 2024 17:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735579291; cv=none; b=Gqqxv1C4g5LrwXosbCG8uNtvIDycCgfvpymJ/loqnF0+A9XtwrnI38zfv5RxP6ruZ9cnJJxc2XKeHHPQKQd0yISnmL7TjWYs87UMBwxjE8op5+1gVzPDVJpMNVdEfRb0X8q3XscCs9C+5QHLmS6KjfdSWThtQcCjuGPyxn5oKMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735579291; c=relaxed/simple;
	bh=I/ZD3xfU6twdGlgIujH8YnjZO+llvUCSNX+zYi9GBJQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=cwxWhNcUSMJBwqj4CmrCIhwBmbhpvqiNO5DO2pL6YwkL1FRg5zDjbgKXxn7+OAdZywGpqCExaMq+9yatIk0rZh4EPdXO1Ky/VYuHtJO+0txYSDgjrADuGCtKUwF5OUKaZgagP9+WeuYN9madXHn9zKtAQaHFM/m0yK7JNuCOPRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Tkdq3Ghr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QMza5Xs7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 30 Dec 2024 17:21:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1735579288;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RBPRbcTzaJ2Ofmx4lLp8Qa7lPmGNNFrtCpRFnnUkyEk=;
	b=Tkdq3GhrJzh0DpGv/cy3c0HXhbmFWWe/pRnVlyDRYlofBwlEeEaeLWH92zecl+4wFwkDQv
	oVWLszXs1wQLGNT3yMBvIqyAx9tx/9hQfYiezoFVrcVSJPNXJ5CrxFOTbbNMIDBWhoipIy
	Kvct2ljpovKJRsLoeh6dkkJqR4hmFQ2dTsksyxP6D7t0EOAARoGp3Myv9mDFw7Wku6piMU
	AMLx60t6aLoDvnPvX4U+UWgN0KH1Qz6ZyIDWO32AEK9USaLXdQ39e+O9W5y7KN3nfNJi6U
	kOSDGocJnkYu9ZeL1vEwt1zit31DRtFhCvNQ7s5XFbCberLbnR9GmiMbLlZkQA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1735579288;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RBPRbcTzaJ2Ofmx4lLp8Qa7lPmGNNFrtCpRFnnUkyEk=;
	b=QMza5Xs7s8PH15Q0+8toFhiCSj5efLHkfNriaQ7ZFe2yfNHv72vnz7Lb9TQNoevA+YOt3b
	o3uAvaSyaSqEOXDQ==
From: "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] Documentation/kernel-parameters: Fix a typo in
 kvm.enable_virt_at_load text
Cc: "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241202120416.6054-5-bp@kernel.org>
References: <20241202120416.6054-5-bp@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173557928773.399.15372502198650036550.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     1146f7429f610d51b886402f1f7a43faa08d814a
Gitweb:        https://git.kernel.org/tip/1146f7429f610d51b886402f1f7a43faa08d814a
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Mon, 02 Dec 2024 13:04:16 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 30 Dec 2024 17:58:58 +01:00

Documentation/kernel-parameters: Fix a typo in kvm.enable_virt_at_load text

s/lode/load/

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20241202120416.6054-5-bp@kernel.org
---
 Documentation/admin-guide/kernel-parameters.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 316cccf..262a946 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2769,7 +2769,7 @@
 			VMs, i.e. on the 0=>1 and 1=>0 transitions of the
 			number of VMs.
 
-			Enabling virtualization at module lode avoids potential
+			Enabling virtualization at module load avoids potential
 			latency for creation of the 0=>1 VM, as KVM serializes
 			virtualization enabling across all online CPUs.  The
 			"cost" of enabling virtualization when KVM is loaded,

