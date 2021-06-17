Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C87E93AB4A4
	for <lists+linux-tip-commits@lfdr.de>; Thu, 17 Jun 2021 15:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231702AbhFQN06 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 17 Jun 2021 09:26:58 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:48828 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbhFQN06 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 17 Jun 2021 09:26:58 -0400
Date:   Thu, 17 Jun 2021 13:24:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623936289;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XkHTCtUP8KBggHG+WfJ7zK47K2/eZAJX2uaiZRFdYf0=;
        b=vNWsp/of9xrMtOnJyN8xDTdplTzp3a/0yVm+nsDBuOsdvRY6Rsc00nGeLl75c61yAyISi4
        oQt7qs1kxJU8Gfkd4/eehFtBpdM3H93pBqMDfTapU64b+ykzrxYSbkvz+oLzMpDdnG7Qv3
        pSjrfN795tF10B3dyibsoW3jZwzEz0iYWeTJjSOEuAGDY6gOXv7hUOGJ47PpshE8FME1tr
        bXt5fdSMRIOJUPRXVC00qNUpEa2YriHONogHxHKyfeNh39cfcKz6bKtgtD2m80tDin2qJU
        /BTxUQUMdkEGlREu3cloig7vq7Cw2uJ6/XXI/QkFfS2CkY507bQVbJNI5JJ4aw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623936289;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XkHTCtUP8KBggHG+WfJ7zK47K2/eZAJX2uaiZRFdYf0=;
        b=AiZjAL3p16JjdQALVkT4gKS7+OvLFd/160gsI56vMbJbuGFq9iCPqRadMP0Kotq7Bqqe/T
        G8gLiiyOUQg8KHCg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] Merge tag 'irqchip-fixes-5.13-2' of
 git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into
 irq/urgent
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20210610171127.2404752-1-maz@kernel.org>
References: <20210610171127.2404752-1-maz@kernel.org>
MIME-Version: 1.0
Message-ID: <162393628874.19906.12290535771615558990.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     a13d0f8d117ca6b7885b51c4b21fe8d5a9eae714
Gitweb:        https://git.kernel.org/tip/a13d0f8d117ca6b7885b51c4b21fe8d5a9eae714
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 17 Jun 2021 15:22:31 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 17 Jun 2021 15:22:31 +02:00

Merge tag 'irqchip-fixes-5.13-2' of git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into irq/urgent

Pull irqchip fixes from Marc Zyngier:

- Fix GICv3 NMI handling where an IRQ could be mistakenly handled
  as a NMI, with disatrous effects

Link: https://lore.kernel.org/r/20210610171127.2404752-1-maz@kernel.org
---
