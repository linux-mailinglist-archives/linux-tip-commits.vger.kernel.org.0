Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED9E4F214D
	for <lists+linux-tip-commits@lfdr.de>; Wed,  6 Nov 2019 23:03:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727196AbfKFWDM (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 6 Nov 2019 17:03:12 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:40707 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726779AbfKFWDM (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 6 Nov 2019 17:03:12 -0500
Received: by mail-io1-f68.google.com with SMTP id p6so28663427iod.7
        for <linux-tip-commits@vger.kernel.org>; Wed, 06 Nov 2019 14:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uzOSEwwxlZUn+RZ80uzKZcPZx0SHIWxdqxRKaOr72PQ=;
        b=ZvxQabNfRd7utzX5GnZ5Ohq0RX5n5e/BnldYMHQTtRr5eA7bYfiVztyd7qSS/I8T7b
         Pkz2QCsHupVJxBYzzpLlI2tPOdtQX+WGgeSIlUmUXS507QqeB2/zSuEuRBRZ+6SjIztd
         c86Pe6BCIzzzR3vQPjkgGhLri8II0y++T1TLwL2Zha0Sed+Fn0nu51IpT7ZkAEQfkbe3
         +9MSrewLmo9y8yG1k1UdxgilmEF1qoaGLXq/DuFxLRXLyUE0+dRb0gaEFO0uZlLsc/G1
         ccvg5y3LxZkcf1Y5uCbk0uKCFlSacJ1ws5gjwhKZNi6JuTAUxx4UFarPAKp5XFOFC2Lk
         EriQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uzOSEwwxlZUn+RZ80uzKZcPZx0SHIWxdqxRKaOr72PQ=;
        b=MBLGCzHDMEdXL2D+ASpGQcWNdkdjJn1I5SUOo/Dj4lk96FWsAWvHPW0QeiUo64/DPb
         JUCkLXAlkFhGqkt54YKQVTM/LKITm9FJlkuY5CabAOcY8zw3rB+Nhww3cOjISZpyDo0y
         bFpGU53EMLKifrQEP894RazOv7I+0O5e/+qIa1Htr2dp8ZbEXTcB9Te/FoiAKkUEhYAd
         Zdqy5/l7XJC+zG7FOev24tbezw1gYgzj3s7fJ3KY24n9v+tpmoSarpVgkOis595yIl4/
         Kv1Wv2dvTvsHQUskbxEw8FiKvtT5J2Xfqcai/HmuYHVJY242vVLBTbteQEpWpNMbowZk
         L3rg==
X-Gm-Message-State: APjAAAXpPZoww3rbwFnvofFz0DPaXbKKmLIkDQcW7eZ6AfPYaC91ABK9
        2+BjjHC64BEXiykeCASbSjbd9OaOFwnS9oGqmyatl3uqqqg=
X-Google-Smtp-Source: APXvYqySmoxWwT6r5prJenB+QFGMiPAykmqD29iMpdYhZ8RMRbdy7um+kUa5w8Q1HhLGjL/PHFTjuw+S+RlOcBFXidc=
X-Received: by 2002:a02:7158:: with SMTP id n24mr345719jaf.127.1573077789213;
 Wed, 06 Nov 2019 14:03:09 -0800 (PST)
MIME-Version: 1.0
References: <20191106174804.74723-1-edumazet@google.com> <157307438959.29376.9644507314555163943.tip-bot2@tip-bot2>
In-Reply-To: <157307438959.29376.9644507314555163943.tip-bot2@tip-bot2>
From:   Eric Dumazet <edumazet@google.com>
Date:   Wed, 6 Nov 2019 14:02:55 -0800
Message-ID: <CANn89iKBaEdCzgF-MT1wrxBZtBD2Ktr9qeThTG_XKOy742XcmQ@mail.gmail.com>
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

On Wed, Nov 6, 2019 at 1:06 PM tip-bot2 for Eric Dumazet
<tip-bot2@linutronix.de> wrote:
>
> The following commit has been merged into the timers/core branch of tip:
>
> Commit-ID:     de4db39b9f0e682e59caa828a277632510901560
> Gitweb:        https://git.kernel.org/tip/de4db39b9f0e682e59caa828a277632510901560
> Author:        Eric Dumazet <edumazet@google.com>
> AuthorDate:    Wed, 06 Nov 2019 09:48:04 -08:00
> Committer:     Thomas Gleixner <tglx@linutronix.de>
> CommitterDate: Wed, 06 Nov 2019 21:59:56 +01:00
>
> hrtimer: Annotate lockless access to timer->state

...

> -/*
> - * Helper function to check, whether the timer is on one of the queues
> +/**
> + * hrtimer_is_queued = check, whether the timer is on one of the queues
> + * @timer:     Timer to check
> + *
> + * Returns: True if the timer is queued, false otherwise
> + *
> + * The function can be used lockless, but it gives only a current snapshot.
>   */
> -static inline int hrtimer_is_queued(struct hrtimer *timer)
> +static inline bool hrtimer_is_queued(struct hrtimer *timer)
>  {
> -       return timer->state & HRTIMER_STATE_ENQUEUED;
> +       /* The READ_ONCE pairs with the update functions of timer->state */
> +       return !!READ_ONCE(timer->state) & HRTIMER_STATE_ENQUEUED;

You probably meant :

return !!(READ_ONCE(timer->state) & HRTIMER_STATE_ENQUEUED);

Sorry for not spotting this earlier.
