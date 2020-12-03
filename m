Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C1182CE2EB
	for <lists+linux-tip-commits@lfdr.de>; Fri,  4 Dec 2020 00:48:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727693AbgLCXsh (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 3 Dec 2020 18:48:37 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:43548 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731457AbgLCXsg (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 3 Dec 2020 18:48:36 -0500
Date:   Thu, 03 Dec 2020 23:47:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607039274;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BVfzYNZRlAxx6hSk4Ia8my89YvWfIL+DGIsmC4tSO3A=;
        b=GKBMe0sRY5xUTdGKq5i+BqBzoMje03kbN5ynBn5MmRHCQmvp5sCPvjBYJOLo72vWxZx0OY
        gybVl+suf7diECQUz5vENZNJno107w+PZKpGmbF2EcEjBkdbx0WhzOP+yTWB0V6APX+Ib6
        qoZgbSiF7DekMJHS8Dg+f3Q6KR+rZv6Eb9vjLdPd7SW5E9ue5k+8Nd6Wf/UvAD0Y7qj+Lm
        MIBxq6VbreDKbCujlv7VKhIOpHp/wXWQUBc256fiaiIauOFoJvUvWiY9R0DMYCsV+itejG
        vqULmh706d6uL4ESJ/IxxKRFvaDBnKn6CQ8EGOnnFJRuC07T5iRHR61oZMPmdw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607039274;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BVfzYNZRlAxx6hSk4Ia8my89YvWfIL+DGIsmC4tSO3A=;
        b=BabfJw4EHxrdMHaKctQi4rmg/M8BcZUPYJY2//XsPIu0sRj3CdP5YVzw35DimdX6K9Pyi+
        zkiLr4nLb96N6DBA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] Merge tag 'timers-v5.11' of
 https://git.linaro.org/people/daniel.lezcano/linux into timers/core
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <028084fa-d29b-a1d5-7eab-17f77ef69863@linaro.org>
References: <028084fa-d29b-a1d5-7eab-17f77ef69863@linaro.org>
MIME-Version: 1.0
Message-ID: <160703927435.3364.2181672130577051442.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     fef92cd2bc04c64bb3743d40c0b4be47aedf9e23
Gitweb:        https://git.kernel.org/tip/fef92cd2bc04c64bb3743d40c0b4be47aedf9e23
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 04 Dec 2020 00:39:45 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 04 Dec 2020 00:39:45 +01:00

Merge tag 'timers-v5.11' of https://git.linaro.org/people/daniel.lezcano/linux into timers/core

Pull clocksource/event driver updates from Daniel Lezcano:

 - Add static annotation for the sp804 init functions (Zhen Lei)

 - Code cleanups and error code path at init time fixes on the sp804
   (Kefen Wang)

 - Add new OST timer driver device tree bindings (Zhou Yanjie)

 - Remove EZChip NPS clocksource driver corresponding to the NPS
   platform which was removed from the ARC architecture (Vineet Gupta)

 - Add missing clk_disable_unprepare() on error path for Orion (Yang
   Yingliang)

 - Add device tree bindings documentation for Renesas r8a774e1
   (Marian-Cristian Rotariu)

 - Convert Renesas TMU to json-schema (Geert Uytterhoeven)

 - Fix memory leak on the error path at init time on the cadence_ttc
   driver (Yu Kuai)

 - Fix section mismatch for Ingenic timer driver (Daniel Lezcano)

 - Make RISCV_TIMER depends on RISCV_SBI (Kefeng Wang)

Link: https://lore.kernel.org/r/028084fa-d29b-a1d5-7eab-17f77ef69863@linaro.org
---
