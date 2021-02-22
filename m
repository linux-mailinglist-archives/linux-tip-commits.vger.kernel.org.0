Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEC153213C4
	for <lists+linux-tip-commits@lfdr.de>; Mon, 22 Feb 2021 11:09:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbhBVKIQ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 22 Feb 2021 05:08:16 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:44356 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230464AbhBVKFq (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 22 Feb 2021 05:05:46 -0500
Date:   Mon, 22 Feb 2021 10:04:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613988299;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=frvgwm+w3iyiRcMovlzrU74qVYgkCTAZiU7xsjTh0do=;
        b=eaG/6p5HPjNaxB/0muLSq6EQS/ggryZPAezaZpqoX753ndDQsLczpA8EsCD64xJakAltFc
        LNtiAdEPEuGlPjULbA91/Edjg2BZXtzfAqAcCuvYV8Z+NFcdQYOfQg1B0MgxFzQZaIEXI+
        uDPyILjC9dFDXIbU+A2ZDvbdxRQUz0qoxbWkaCoKdRNz4Sr46d+ut5ZugVN/8ihAz9YGJk
        5mIBTi/+ov1ISgVZ9f8TVqSP1fQ6zi56XBqX+TVsdYuXouZqZ9cvijNPrMK8VNYvA6i7xH
        DoL0ljC+XK1sjFhJUEMjVvoWBHoSOIr7KA1EmpwX92dUxKqMwzar9fLJs4GVOw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613988299;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=frvgwm+w3iyiRcMovlzrU74qVYgkCTAZiU7xsjTh0do=;
        b=7gQ+/3IQELsrN2CzXgYfdu2awSrl/UlP51MyuVX6Rj0rpmRU8pP7aQONRb+oxEqlGS58M2
        +Ei1OVsBjtcb7ICw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] Merge tag 'timers-v5.11-rc5' of
 https://git.linaro.org/people/daniel.lezcano/linux into timers/urgent
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <ae3bcda6-5180-639d-6246-d2dfd271c3e7@linaro.org>
References: <ae3bcda6-5180-639d-6246-d2dfd271c3e7@linaro.org>
MIME-Version: 1.0
Message-ID: <161398829877.20312.9485076169371268914.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     8acb54abc1db4e1e3913359e4108e04e88ce4d92
Gitweb:        https://git.kernel.org/tip/8acb54abc1db4e1e3913359e4108e04e88ce4d92
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 22 Feb 2021 10:59:13 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 22 Feb 2021 10:59:13 +01:00

Merge tag 'timers-v5.11-rc5' of https://git.linaro.org/people/daniel.lezcano/linux into timers/urgent

Pull clockevent fixes from Daniel Lezcano

 - Fix harmless warning with the ixp4xx when the TIMER_OF option is not
   selected (Arnd Bergmann)

 - Make sure channel clock supply is enabled on sh_cmt (Geert Uytterhoeven)

 - Fix compilation error when DEBUG is defined with the mxs_timer (Tom Rix)

Link: https://lore.kernel.org/r/ae3bcda6-5180-639d-6246-d2dfd271c3e7@linaro.org
---
