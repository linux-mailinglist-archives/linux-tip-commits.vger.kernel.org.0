Return-Path: <linux-tip-commits+bounces-6072-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5BC4B01687
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Jul 2025 10:40:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA62C1CA40E9
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Jul 2025 08:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47FD61F582F;
	Fri, 11 Jul 2025 08:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NpkcMjHQ"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30F2202976
	for <linux-tip-commits@vger.kernel.org>; Fri, 11 Jul 2025 08:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752223041; cv=none; b=dEIvraCjSQ0T0MvW9cXq4wr/3J/aYu3RaLcMnCUhV8i961PnM/DGphC5cFOJCLlmAH9CIN6X4sUU7wenTEOtfs0wOEVpFBC/4xp7hqYNYvrtNid5NSRUUhnvz32Z+sufkmrb8THGOSlj7kSDPr9YiaAF/IGh+eW6RecuA2WDOv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752223041; c=relaxed/simple;
	bh=wBexerGmlSLuT4Q9x+PLy9NOWI2IGyv0KV2h3EhUVYI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CJ6AuhWTEmKgruqLsj6pkMn+OBr8260FLqEUk49wFPjxHdk/qTIHR6e2VgfvJzJrvB/mT0QoBoprYKe/NTfBHf5ONrib8e5Nz5MTVR6zKfrJ/Ijprh6pPFrga1JmF/pvohRrvYJekqIMMXpL0emSrwsUvYDYt2IoIASJv1wYrrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NpkcMjHQ; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-747fba9f962so1651581b3a.0
        for <linux-tip-commits@vger.kernel.org>; Fri, 11 Jul 2025 01:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752223037; x=1752827837; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6XUXolZ3NZrlkUNZw/zJhmIC6NkFxml120UZ5EcTK7M=;
        b=NpkcMjHQBE45xveVkrdNY2V8QcdYKsBT/+BIaKnhA0PERLLc/6TOOOhWYK41ZtjxCs
         bzc+3bcZ9y/HWnISV4b7E33TtThGwWeubjJ9RVrpDUcbazOy/YxSNIjN8qi4Zj+SXf80
         Ru2YWb8+oz7WWpayPjbw6XTVZUiSW3K5BkJy1f6hP9T+pn8eTmoTeOpRMHw3BVKTjDm5
         9dy6CmmPfT43r+eLA2n4Ba1w8DkZj2/Qj+adQv2f8vwBJFFg5f1w3JeF2YqyLKgUQdNj
         wlNTf2P//Q3Ig8sb8Zcrdiy5fJlkiyYYPLfzh0BNSYkXe6NJsTYzGaIKh9wJ17Bb4HLN
         1Lpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752223037; x=1752827837;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6XUXolZ3NZrlkUNZw/zJhmIC6NkFxml120UZ5EcTK7M=;
        b=Hwn573HMhnVeYVvgactlMciMuAOkriyRvrZDHlk7tMbrGIfFcq7mvds6ppDDRQAP6o
         1RaMDrcVlI6YQxfQNxF6uhORwxejDdIRu/bC8ofpVnFpJz0TWeto6auprfxft5BZmDSG
         ynfnNZDci1Hs8lc/zZ2VTGkS/3FY8nWdfEqy2E8CxAuwCbkeEDBxs8V0Csb4DSqoJ1Fi
         6i8ViIO7A01YOyc2FRExEmFq4bjveRCqUAdFicx20iRL76Cm+sl9diaE7G/bDqfWnuOw
         5CG1DrIJ7bFY8l5RMNfZJwMr8KyJUAiYCw1KtrZjfvg0W+/spkc+ErKH/1H1xpkBbj83
         7H0w==
X-Gm-Message-State: AOJu0YyYm5s+imkDFk89faB1HHbqitRtbL9pSWsM6ZJVrzZHlwwLMYRV
	TS5x4C46XSN0wZdQHqf0+/avNeWwXKxtyhOaGijr5c+zMC/FldvcHEIrtNKH1ey3CtY=
X-Gm-Gg: ASbGncsr7zMRTCblMt8IgtMtsxtIYd4pcU7cWGTbzrqcLU1/vn7P4UO/eZGvmWbXbXx
	vB3l60qGdY19Ik5MW5eo45q+n16RY4brnMTST4j1g+syjGtQd5+qImQe2tXQvtuQSMCjIkseSi7
	TcBO6h1LQyst3aW+4rlrNzmU+b1MiSPEH6ofvI2yw8RFxZt2JSwA/ve8HYsP6VbkTsQswDNUPoi
	8wfwJCR+QQ3lJg4pEO1bDmS0EWHA5HC5yfzK7fMNAqlTGndFvjmFWQliw9FqS+6zksBGC2ZlNVs
	Euc7QLvuqyFgGaFncOIAnD806kZYwmyzA+bhw4fY6XRmBMC022xxBPcxWZEBiH8itaAPr54HFKW
	8zRQ2UWaZQ/Eg/grnoBzOoM385A==
X-Google-Smtp-Source: AGHT+IHJaibR0audMDMA5x4+vGsGHVE1SoOIJ5lm3hCiQGqL/7q5s8HuBJWb4ZxBknCzgINI9eRfGQ==
X-Received: by 2002:a05:6a00:6d58:10b0:746:1d29:5892 with SMTP id d2e1a72fcca58-74eb593d0bemr6718891b3a.4.1752223037105;
        Fri, 11 Jul 2025 01:37:17 -0700 (PDT)
Received: from localhost ([36.110.131.181])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9e06c72sm4976880b3a.66.2025.07.11.01.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 01:37:16 -0700 (PDT)
From: Julian Sun <sunjunchao2870@gmail.com>
X-Google-Original-From: Julian Sun <sunjunchao@bytedance.com>
To: linux-tip-commits@vger.kernel.org
Cc: mingo@kernel.org,
	Julian Sun <sunjunchao@bytedance.com>
Subject: [PATCH] x86/fpu: Fix null-ptr-deref in x86_task_fpu()
Date: Fri, 11 Jul 2025 16:37:12 +0800
Message-Id: <20250711083712.39121-1-sunjunchao@bytedance.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following bug was triggered by LTP:
[ 1042.859480] ------------[ cut here ]------------
[ 1042.865432] BUG: kernel NULL pointer dereference, address: 0000000000000008
[ 1042.868409] RIP: 0010:proc_pid_arch_status+0x25/0x90
...
[ 1042.873200] Call Trace:
[ 1042.874107]  <TASK>
[ 1042.874222] PKRU: 55555554
[ 1042.874752]  proc_pid_arch_status+0x1e/0x90
[ 1042.875256] Call Trace:
[ 1042.875257]  <TASK>
[ 1042.875259]  proc_single_show+0x5d/0xe0
[ 1042.875263]  seq_read_iter+0x132/0x4d0
[ 1042.875790]  proc_single_show+0x5d/0xe0
[ 1042.876284]  seq_read+0xf9/0x130
[ 1042.876288]  vfs_read+0xbc/0x350
[ 1042.876510]  seq_read_iter+0x132/0x4d0
[ 1042.877019]  ? putname+0x63/0x80
[ 1042.877612]  seq_read+0xf9/0x130
[ 1042.878020]  ksys_read+0x73/0xf0
[ 1042.878212]  vfs_read+0xbc/0x350
[ 1042.878723]  __x64_sys_read+0x1d/0x30
[ 1042.878888]  ? putname+0x63/0x80
[ 1042.879089]  x64_sys_call+0x1e55/0x1fa0
[ 1042.879092]  do_syscall_64+0x65/0x290
[ 1042.879410]  ksys_read+0x73/0xf0
[ 1042.879598]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 1042.879761]  __x64_sys_read+0x1d/0x30
[ 1042.880043] RIP: 0033:0x7f9cf0d4d25d

This issue can be easily reproduced using kirk --run-suite fs.

The problem can be fixed by only printing a warning in x86_task_fpu()
instead of returning a null pointer.

Fixes: 22aafe3bcb67 ("x86/fpu: Remove init_task FPU state dependencies, add debugging warning for PF_KTHREAD tasks")
Signed-off-by: Julian Sun <sunjunchao@bytedance.com>
---
 arch/x86/kernel/fpu/core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index ea138583dd92..632ddd73f845 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -58,8 +58,7 @@ DEFINE_PER_CPU(struct fpu *, fpu_fpregs_owner_ctx);
 #ifdef CONFIG_X86_DEBUG_FPU
 struct fpu *x86_task_fpu(struct task_struct *task)
 {
-	if (WARN_ON_ONCE(task->flags & PF_KTHREAD))
-		return NULL;
+	WARN_ON_ONCE(task->flags & PF_KTHREAD);
 
 	return (void *)task + sizeof(*task);
 }
-- 
2.39.5


