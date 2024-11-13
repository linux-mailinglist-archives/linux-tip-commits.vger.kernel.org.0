Return-Path: <linux-tip-commits+bounces-2845-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2BF89C6C67
	for <lists+linux-tip-commits@lfdr.de>; Wed, 13 Nov 2024 11:09:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87CD728BCB3
	for <lists+linux-tip-commits@lfdr.de>; Wed, 13 Nov 2024 10:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26D4D1FB893;
	Wed, 13 Nov 2024 10:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sNlg7vlI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QNCZ98yd"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8011F9A8E;
	Wed, 13 Nov 2024 10:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731492552; cv=none; b=q+8F3eXCLjWqIfJy5s4/p4VwDUcRAvCMRx+mLo9QF1F00B00ecIQUtCWjT7+BQOyJYKdK/37ojJTIvEHapnN6O9ki7+tDFgSmEkDky73HsfZWf/KCg7g6rgByMYanDCbhbOFD0Cck2fVLLhwXFEm162fP94fqJb26do2POxBPxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731492552; c=relaxed/simple;
	bh=QlGkHbCIGR5yKndUZf+LeXFnPsfPlxrFj400+1tQESU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=T/brKSHsO+yq0KeDbLU4sbyJDBWB03v0PibOMVZ7XsUdhzilx/Cbfuz4RVnj+4RE9mOusDBO74PtlwTuxomfIa2rtYu7CaRq5EaUBlgVy0UuUTjr+eSB0rSAPfn+Z4r7KJhqn/iEozwWEJxHjcSlCZtQfVHvQeN/kbrz5GxrL0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sNlg7vlI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QNCZ98yd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 13 Nov 2024 10:09:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1731492541;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rq8cUm1xkumo6bL4NsPNwXvLFrHIDP+ppxDpwHrHm0Q=;
	b=sNlg7vlIKMD54dE+JSt/p7FpvNnBohXtjfI7KL8rW05sizlxVcrohksxKYCS+YHCOgRwKt
	Kfeyv3LXiGNgiJ0WMVmLdRA7sjAkeL3rtkvWr6FUllnsW5+Eb/tWISjh4OXdw2FVurK33S
	DxbanE87Kj75awAhv8FGJUfP5zAgQCNUzNgmdymDUq2HWzLjshPx4XgEitqem0kq5t+SXz
	1/btGZ+w/ACHIh1bohwrza0ats31qLzLGEEzBPm9XcP4jKJJEL/lmgV12vVwCXnB7obJUM
	3hpf1unk/KMEARGunndioVqAWksx1cYo/TaNG0PsSxLrXwEKVxvcyMkG++ZZZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1731492541;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rq8cUm1xkumo6bL4NsPNwXvLFrHIDP+ppxDpwHrHm0Q=;
	b=QNCZ98yddZK2tStd0btsbOZ/V1wz/tG1mkqM8NF1fSBEHilgnZMb7D/CvlH8vbF4IvTj65
	1SgwgbF9yR9SsPAw==
From: "tip-bot2 for Xiu Jianfeng" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/Documentation: Fix grammar in
 percpu-rw-semaphore.rst
Cc: Xiu Jianfeng <xiujianfeng@huawei.com>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241112025724.474881-1-xiujianfeng@huaweicloud.com>
References: <20241112025724.474881-1-xiujianfeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173149254031.32228.3413941510634534540.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     3b49a347d751553b1d1be69c8619ae2e85fdc28d
Gitweb:        https://git.kernel.org/tip/3b49a347d751553b1d1be69c8619ae2e85fdc28d
Author:        Xiu Jianfeng <xiujianfeng@huawei.com>
AuthorDate:    Tue, 12 Nov 2024 02:57:24 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 13 Nov 2024 10:59:01 +01:00

locking/Documentation: Fix grammar in percpu-rw-semaphore.rst

s/'is initialized'/'is initialized with'

Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20241112025724.474881-1-xiujianfeng@huaweicloud.com
---
 Documentation/locking/percpu-rw-semaphore.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/locking/percpu-rw-semaphore.rst b/Documentation/locking/percpu-rw-semaphore.rst
index 247de64..a105bf2 100644
--- a/Documentation/locking/percpu-rw-semaphore.rst
+++ b/Documentation/locking/percpu-rw-semaphore.rst
@@ -16,8 +16,8 @@ writing is very expensive, it calls synchronize_rcu() that can take
 hundreds of milliseconds.
 
 The lock is declared with "struct percpu_rw_semaphore" type.
-The lock is initialized percpu_init_rwsem, it returns 0 on success and
--ENOMEM on allocation failure.
+The lock is initialized with percpu_init_rwsem, it returns 0 on success
+and -ENOMEM on allocation failure.
 The lock must be freed with percpu_free_rwsem to avoid memory leak.
 
 The lock is locked for read with percpu_down_read, percpu_up_read and

