Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 894BCF222E
	for <lists+linux-tip-commits@lfdr.de>; Wed,  6 Nov 2019 23:53:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727524AbfKFWx5 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 6 Nov 2019 17:53:57 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:41580 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727196AbfKFWx4 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 6 Nov 2019 17:53:56 -0500
Received: by mail-io1-f66.google.com with SMTP id r144so102500iod.8
        for <linux-tip-commits@vger.kernel.org>; Wed, 06 Nov 2019 14:53:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qWwP0m6SqLRG+rteRbiBDc7/QsyVICBLBoO7IhUEkA4=;
        b=MbWsBt9JRPefZXp4V7YBgwnLmXu5L6g7ZNW4e3Yn+vtZpGUlfyipuDo4DhTpUiiIYE
         GWWtNUzW1i1cuB1GJAS3g1enLp0/xfCQ35eRURv9PJ4q8gPnHCy5RHlqzVPqygJSNTdT
         VP4EDnY69Vlpky3sSUUgz/4induxxdpMquyLMChBNluyDN/XT2OuXlIeSJnGkGf+NDm/
         Qf23ZtWfSG4vyO/TkZ1QfW8oCqvoU62SZA2+ViaWDxyfrz23Pb2N49hwwp3f1YsafcMs
         VfpFMwViiZoC8o/v5M5ab8IfX/NeMYFwOvQP1RnOBO9HI8JRh0hTRNnK9CyPWwoAvY7t
         A/sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qWwP0m6SqLRG+rteRbiBDc7/QsyVICBLBoO7IhUEkA4=;
        b=aEbgAjO0MbRAbU6uHcpr1N5xRx7RFpxTyPCkdOOFTIRFFcwLSxOZQyxqWwcycTqg2f
         hdk28rcsRhAcya4VsHUpmZoZKh6p4UCUT/RExWG5krHUdRMbxgB03K/u0ghu93j6OxtN
         ZnyNFTVP4YMZmDYJDUd9fnETbULLHTyO+LO1lQqVe76owO01riza4kmwppYu9L5b1h8n
         2InRY9+mjX8aGyiYRy7G8Jyr1xEvUDaOnzGS2KZCjxTi68cAJ4ElAbUE1nIEACQIyLZT
         vLHG8/YSPAAQLWkn3feJoiPfmx09j3QEsOtPDaBxKMIdNKkZO1G4xwxlCmu/K6kycgXC
         Hfvw==
X-Gm-Message-State: APjAAAU/QfEP3tOacG/42dVKR5Mc8N4F+EAK443Py6tzssqmWGZmhY/8
        cutx+5VoMSclc/Qtu9vDUpBOcsxjcRiKKKI9PzMndQ==
X-Google-Smtp-Source: APXvYqyNmeXLaksAr8Nl2Pam7oHSAtHGxBjGGzGx56rn/KBJsvcEm3oHyZSfK8yscXJ3Fkkfrs0LIJyLln81Fn3KcWw=
X-Received: by 2002:a5e:8e02:: with SMTP id a2mr64653ion.269.1573080835360;
 Wed, 06 Nov 2019 14:53:55 -0800 (PST)
MIME-Version: 1.0
References: <20191106174804.74723-1-edumazet@google.com> <157307905904.29376.8711513726869840596.tip-bot2@tip-bot2>
In-Reply-To: <157307905904.29376.8711513726869840596.tip-bot2@tip-bot2>
From:   Eric Dumazet <edumazet@google.com>
Date:   Wed, 6 Nov 2019 14:53:43 -0800
Message-ID: <CANn89iKXi3rWWruKoBwQ8rncwLvkbzjZJWuJL3K05fjAhcySwg@mail.gmail.com>
Subject: Re: [tip: timers/core] hrtimer: Annotate lockless access to timer->state
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     linux-tip-commits@vger.kernel.org,
        syzbot <syzkaller@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Wed, Nov 6, 2019 at 2:24 PM tip-bot2 for Eric Dumazet
<tip-bot2@linutronix.de> wrote:
>
> The following commit has been merged into the timers/core branch of tip:
>
> Commit-ID:     56144737e67329c9aaed15f942d46a6302e2e3d8
> Gitweb:        https://git.kernel.org/tip/56144737e67329c9aaed15f942d46a6302e2e3d8
> Author:        Eric Dumazet <edumazet@google.com>
> AuthorDate:    Wed, 06 Nov 2019 09:48:04 -08:00
> Committer:     Thomas Gleixner <tglx@linutronix.de>
> CommitterDate: Wed, 06 Nov 2019 23:18:31 +01:00
>
> hrtimer: Annotate lockless access to timer->state
>

I guess we also need to fix timer_pending(), since timer->entry.pprev
could change while we read it.

I will try to find a KCSAN report showing the issue.

Thanks !
