Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D75F3ACFB9
	for <lists+linux-tip-commits@lfdr.de>; Fri, 18 Jun 2021 18:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235642AbhFRQF7 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 18 Jun 2021 12:05:59 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57474 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234784AbhFRQFz (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 18 Jun 2021 12:05:55 -0400
Date:   Fri, 18 Jun 2021 16:03:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624032225;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bBxvYf0FN4jiFQ4rbawy1zAQuYvLQYj9z9RHwYz51r8=;
        b=f7lckfoSwxw8ctTinR7xCVewG6xIP0Bt/GAVanNSqC1Rm5ure6Myn3g5rPOfnCDuzZJ8iC
        NA9aWPuTnCLqoKWJtXzk1R9oU/xk4s2kkuRyndRSsU983S5k0m8KkupsNnjYsCTgBQnO2o
        hlQjvA2i5HRTtY54AxC2UnPR33B6ANEV/f8QPdJaYR7o+GuYcmYaWs4EhSGXACM8ilzCWu
        EP2xe18FcTgRdmZwnZ3GelOmaQXRBrP0R2KDh7IQ9n/E3WTb3hR+3zoe27TA1uSaZP/8Ch
        8oXw9x6e2sGds6XDxDE1oAwd5CcgT8N0lG7pkt+opHlyPUo1m64Fj0x+BClE+g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624032225;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bBxvYf0FN4jiFQ4rbawy1zAQuYvLQYj9z9RHwYz51r8=;
        b=CtQsCJ7iyoHTqXSmtPX3rObvdDcZ4Xl9wnvq5Dnho+79C79v+8SMrAF5orTSHUVJrTH8qO
        i+DpMn3LyYcWQABg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] Merge tag 'timers-v5.14' of
 https://git.linaro.org/people/daniel.lezcano/linux into timers/core
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <65ed5f60-d7a5-b4ae-ff78-0382d4671cc5@linaro.org>
References: <65ed5f60-d7a5-b4ae-ff78-0382d4671cc5@linaro.org>
MIME-Version: 1.0
Message-ID: <162403222436.19906.11280472168955346294.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     f6b6a80360995ad175e43d220af979f119e52cd3
Gitweb:        https://git.kernel.org/tip/f6b6a80360995ad175e43d220af979f119e52cd3
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 18 Jun 2021 17:57:47 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 18 Jun 2021 17:57:47 +02:00

Merge tag 'timers-v5.14' of https://git.linaro.org/people/daniel.lezcano/linux into timers/core

Pull clockevent/source updates from Daniel Lezcano:

 - Remove arch_timer_rate1 variable as it is unused in the architected
   ARM timer (Jisheng Zhang)

 - Minor cleanups (whitespace, constification, ...) for the Samsung pwm
   timer (Krzysztof Kozlowski)

 - Acknowledge and disable the timer interrupt at suspend time to
   prevent the suspend to be aborted by the ATF if there is a pending
   one on the Mediatek timer (Evan Benn)

 - Save and restore the configuration register at suspend/resume time
   for TI dm timer (Tony Lindgren)

 - Set the scene for the next timers support by renaming the array
   variables on the Ingenic time (Zhou Yanjie)

 - Add the clock rate change notification to adjust the prescalar value
   and compensate the clock source on the ARM global timer (Andrea
   Merello)

 - Add missing variable static annotation on the ARM global timer (Zou
   Wei)

 - Remove a duplicate argument when building the bits field on the ARM
   global timer (Wan Jiabing)

 - Improve the timer workaround function by reducing the loop on the
   Allwinner A64 timer (Samuel Holland)

 - Do no restore the register context in case of error on the TI dm
   timer (Tony Lindgren)

Link: https://lore.kernel.org/r/65ed5f60-d7a5-b4ae-ff78-0382d4671cc5@linaro.org
---
