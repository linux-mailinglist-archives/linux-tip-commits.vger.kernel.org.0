Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D087D2B5202
	for <lists+linux-tip-commits@lfdr.de>; Mon, 16 Nov 2020 21:09:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731636AbgKPUIa (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 16 Nov 2020 15:08:30 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:43338 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729459AbgKPUIa (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 16 Nov 2020 15:08:30 -0500
Date:   Mon, 16 Nov 2020 20:08:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605557308;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=np68QpS74WRZwzXnueJuSt4qob2qXsd/YJ/hEUqDJBw=;
        b=fU4LQPnw503NIF+fsts6CliwvYBVLn8qee0epIK/3R7Y2qO561vaqLjh+wmo2bxLMoEvwj
        tkUp4gb3NNJU3I/Cqp1FhKXVve3zx4rizS3X5624JyqNf/xBdFzPgw7AbmPv+yFccFtgXq
        hHmD/optMiYJamU9Im9c8lpmdzqIVGZ0jh2G9pe5ltCs8rHzkbAuqQgFD7ZYBofUDyS5nT
        yS/HZ67ZMsY8P1srTq0IjSv1Ed4bxduSJSeEEhhhrcn4pxtszvIOzfGQwGB2GywhL/ODH8
        xy6pF8rCiIKR+dwPMzkRxQeB0neUMFlRU8x1+4714los/Z1ecE3XkDcFlxE2KQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605557308;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=np68QpS74WRZwzXnueJuSt4qob2qXsd/YJ/hEUqDJBw=;
        b=pl0EjPgvr5zFow1fnY77XQSacxaz8qiYIXIR/CgzwyS1nNpGMBvhJ7Ws78GAboLSsAPenx
        7mkK0ATad+DKzaAQ==
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/misc] x86/msr: Do not allow writes to MSR_IA32_ENERGY_PERF_BIAS
Cc:     Borislav Petkov <bp@suse.de>,
        Shuah Khan <skhan@linuxfoundation.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201029190259.3476-5-bp@alien8.de>
References: <20201029190259.3476-5-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <160555730711.11244.5287578166367187235.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/misc branch of tip:

Commit-ID:     18741a5251d018094536a2dffe284d269ebb07fe
Gitweb:        https://git.kernel.org/tip/18741a5251d018094536a2dffe284d269ebb07fe
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Thu, 15 Oct 2020 15:00:31 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 16 Nov 2020 17:44:04 +01:00

x86/msr: Do not allow writes to MSR_IA32_ENERGY_PERF_BIAS

Now that all in-kernel-tree users are converted to using the sysfs file,
remove the MSR from the "allowlist".

Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
Link: https://lkml.kernel.org/r/20201029190259.3476-5-bp@alien8.de
---
 arch/x86/kernel/msr.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/x86/kernel/msr.c b/arch/x86/kernel/msr.c
index c0d4098..b114786 100644
--- a/arch/x86/kernel/msr.c
+++ b/arch/x86/kernel/msr.c
@@ -99,9 +99,6 @@ static int filter_write(u32 reg)
 	if (!__ratelimit(&fw_rs))
 		return 0;
 
-	if (reg == MSR_IA32_ENERGY_PERF_BIAS)
-		return 0;
-
 	pr_err("Write to unrecognized MSR 0x%x by %s (pid: %d). Please report to x86@kernel.org.\n",
 	       reg, current->comm, current->pid);
 
